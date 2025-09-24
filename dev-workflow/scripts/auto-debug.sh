#!/bin/bash

# Auto-Debug Script - Automated debugging workflow
# This script automates the debugging process with Claude Code

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/dev-integration.sh"

# Function to auto-capture Chrome errors
auto_capture_errors() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local error_log="$LOG_DIR/auto_errors_${project_name}_$(date +%Y%m%d_%H%M%S).log"

    echo "Auto-capturing Chrome errors..."

    # Try to get Chrome console errors via AppleScript
    osascript -e 'tell application "Google Chrome"
        if it is running then
            tell active tab of front window
                execute javascript "
                    var errors = [];
                    var originalError = console.error;
                    console.error = function() {
                        errors.push(Array.from(arguments).join(' '));
                        originalError.apply(console, arguments);
                    };
                    errors.join('\n');
                "
            end tell
        end if
    end tell' > "$error_log"

    # Add context
    echo "" >> "$error_log"
    echo "=== Auto-captured at $(date) ===" >> "$error_log"
    echo "=== Project: $project_name ===" >> "$error_log"

    if [ -s "$error_log" ] && [ $(wc -l < "$error_log") -gt 3 ]; then
        echo "Errors captured, sending to Claude Code..."
        send_to_claude "$(create_claude_command "error" "$error_log" "Auto-captured from Chrome")" "$error_log"
    else
        echo "No errors found or Chrome not running"
        rm -f "$error_log"
    fi
}

# Function to auto-screenshot on error
auto_screenshot_error() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local screenshot_file="$SCREENSHOT_DIR/auto_error_${project_name}_$(date +%Y%m%d_%H%M%S).png"

    echo "Taking auto-screenshot for debugging..."

    # Capture screen after a short delay
    sleep 2
    screencapture -x "$screenshot_file"

    if [ -f "$screenshot_file" ]; then
        echo "Screenshot captured, analyzing..."
        send_to_claude "$(create_claude_command "screenshot" "$screenshot_file" "Auto-captured error screenshot")" "$screenshot_file"
    else
        echo "Screenshot failed"
    fi
}

# Function to monitor and auto-debug
monitor_and_debug() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local monitor_log="$MONITOR_DIR/${project_name}_auto_debug_$(date +%Y%m%d).log"

    echo "Starting auto-debug monitoring for: $project_name"
    echo "Monitoring log: $monitor_log"
    echo "Press Ctrl+C to stop monitoring"

    while true; do
        echo "[$(date)] Auto-debug cycle started" >> "$monitor_log"

        # Check for Chrome errors
        auto_capture_errors "$project_dir"

        # Check for file changes (git status)
        if [ -d "$project_dir/.git" ]; then
            local changes=$(cd "$project_dir" && git status --porcelain)
            if [ -n "$changes" ]; then
                echo "[$(date)] Git changes detected" >> "$monitor_log"
                echo "$changes" >> "$monitor_log"

                # Auto-screenshot if there are changes
                auto_screenshot_error "$project_dir"
            fi
        fi

        # Wait before next cycle
        echo "[$(date)] Waiting 5 minutes..." >> "$monitor_log"
        sleep 300
    done
}

# Function to quick debug cycle
quick_debug() {
    local issue="$1"
    if [ -z "$issue" ]; then
        echo "Please describe the issue:"
        read issue
    fi

    local project_dir="$2"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local debug_log="$LOG_DIR/quick_debug_${project_name}_$(date +%Y%m%d_%H%M%S).log"

    echo "Starting quick debug cycle for: $issue"
    echo "Project: $project_name"

    # Step 1: Capture console errors
    auto_capture_errors "$project_dir"

    # Step 2: Take screenshot
    auto_screenshot_error "$project_dir"

    # Step 3: Create debug context
    cat > "$debug_log" << EOF
Quick Debug Session
==================
Issue: $issue
Project: $project_name
Timestamp: $(date)
User: $(whoami)

Git Status:
$(cd "$project_dir" && git status --porcelain 2>/dev/null)

Recent Files Modified:
$(cd "$project_dir" && find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.vue" -o -name "*.py" -newermt "5 minutes ago" 2>/dev/null || echo "No recently modified files")

Issue Description:
$issue

Debug Request:
Please analyze this debugging session and provide:
1. Root cause analysis
2. Suggested fixes
3. Code examples if needed
4. Prevention strategies

EOF

    echo "Debug log created: $debug_log"
    send_to_claude "$(create_claude_command "debug" "$debug_log" "Quick debug session")" "$debug_log"
}

# Main script logic
case "${1:-help}" in
    "capture")
        auto_capture_errors "$2"
        ;;
    "screenshot")
        auto_screenshot_error "$2"
        ;;
    "monitor")
        monitor_and_debug "$2"
        ;;
    "quick")
        quick_debug "$2" "$3"
        ;;
    "help"|*)
        echo "Auto-Debug Script"
        echo "Usage: $0 [command] [options]"
        echo ""
        echo "Commands:"
        echo "  capture [dir]      - Auto-capture Chrome errors"
        echo "  screenshot [dir]   - Auto-screenshot for debugging"
        echo "  monitor [dir]      - Monitor and auto-debug continuously"
        echo "  quick <issue> [dir] - Quick debug cycle for specific issue"
        echo "  help               - Show this help message"
        ;;
esac