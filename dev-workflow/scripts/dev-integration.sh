#!/bin/bash

# Development Integration Script
# This script provides automated development workflow integration

DEV_SCRIPTS_DIR="$HOME/Desktop/dev-scripts"
LOG_DIR="$HOME/Desktop/dev-logs"
SCREENSHOT_DIR="$HOME/Desktop/dev-screenshots"
MONITOR_DIR="$HOME/Desktop/dev-monitor"

# Create directories if they don't exist
mkdir -p "$DEV_SCRIPTS_DIR" "$LOG_DIR" "$SCREENSHOT_DIR" "$MONITOR_DIR"

# Function to log development actions
log_dev_action() {
    local action="$1"
    local details="$2"
    local logfile="$LOG_DIR/dev_actions_$(date +%Y%m%d).log"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $action: $details" >> "$logfile"
}

# Function to get project context
get_project_context() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local context_file="$LOG_DIR/project_context_${project_name}_$(date +%Y%m%d_%H%M%S).txt"

    cat > "$context_file" << EOF
Project Context Analysis
=======================
Project: $project_name
Directory: $project_dir
Timestamp: $(date)
User: $(whoami)

Package.json Analysis:
$(if [ -f "$project_dir/package.json" ]; then
    cat "$project_dir/package.json" | jq -r '.name // "N/A", .version // "N/A", .description // "N/A"' 2>/dev/null | paste -sd " " -
else
    echo "No package.json found"
fi)

Git Status:
$(cd "$project_dir" && git status --porcelain 2>/dev/null || echo "Not a git repository")

Recent Commits:
$(cd "$project_dir" && git log --oneline -5 2>/dev/null || echo "No git history")

Current Files:
$(find "$project_dir" -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.vue" -o -name "*.py" | head -10)

EOF

    echo "$context_file"
}

# Function to create Claude Code commands
create_claude_command() {
    local type="$1"
    local filepath="$2"
    local context="$3"

    case "$type" in
        "error")
            echo "Analyze this error log and provide fixes. Context: $context. File: $filepath"
            ;;
        "screenshot")
            echo "Analyze this development screenshot. Context: $context. File: $filepath"
            ;;
        "code")
            echo "Review this code and suggest improvements. Context: $context. File: $filepath"
            ;;
        "debug")
            echo "Debug this issue. Context: $context. File: $filepath"
            ;;
        *)
            echo "Analyze this file: $filepath. Context: $context"
            ;;
    esac
}

# Function to send to Claude Code
send_to_claude() {
    local command="$1"
    local filepath="$2"

    if command -v claude &> /dev/null; then
        echo "Sending to Claude Code: $command"
        claude "$command"
        log_dev_action "Claude Code" "Sent command: $command"
    else
        echo "Claude Code not found. Please install Claude Code."
        log_dev_action "Claude Code" "Claude Code not found"
    fi
}

# Function to setup development environment
setup_dev_env() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    echo "Setting up development environment for: $project_dir"

    # Create project-specific directories
    local project_name=$(basename "$project_dir")
    local project_logs="$LOG_DIR/$project_name"
    local project_screenshots="$SCREENSHOT_DIR/$project_name"

    mkdir -p "$project_logs" "$project_screenshots"

    # Create project context
    get_project_context "$project_dir"

    echo "Development environment setup complete!"
    log_dev_action "Setup" "Environment setup for $project_name"
}

# Function to monitor development activity
monitor_dev_activity() {
    local project_dir="$1"
    if [ -z "$project_dir" ]; then
        project_dir="$(pwd)"
    fi

    local project_name=$(basename "$project_dir")
    local monitor_file="$MONITOR_DIR/${project_name}_activity_$(date +%Y%m%d_%H%M%S).log"

    # Monitor file changes
    echo "Monitoring development activity for: $project_name"
    echo "Press Ctrl+C to stop monitoring"

    while true; do
        echo "[$(date)] Activity check:" >> "$monitor_file"
        git status --porcelain >> "$monitor_file" 2>/dev/null
        sleep 300  # Check every 5 minutes
    done
}

# Main script logic
case "${1:-help}" in
    "setup")
        setup_dev_env "$2"
        ;;
    "context")
        get_project_context "$2"
        ;;
    "monitor")
        monitor_dev_activity "$2"
        ;;
    "send")
        send_to_claude "$2" "$3"
        ;;
    "log")
        log_dev_action "$2" "$3"
        ;;
    "help"|*)
        echo "Development Integration Script"
        echo "Usage: $0 [command] [options]"
        echo ""
        echo "Commands:"
        echo "  setup [dir]       - Setup development environment"
        echo "  context [dir]     - Get project context"
        echo "  monitor [dir]     - Monitor development activity"
        echo "  send <cmd> <file> - Send command to Claude Code"
        echo "  log <action> <details> - Log development action"
        echo "  help              - Show this help message"
        ;;
esac