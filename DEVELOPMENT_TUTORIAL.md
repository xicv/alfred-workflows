# Alfred Workflow Development Tutorial 2025

A complete guide to creating Alfred workflows from scratch using modern best practices.

## Table of Contents

1. [Understanding Alfred Workflows](#understanding-alfred-workflows)
2. [Setting Up Your Environment](#setting-up-your-environment)
3. [Creating Your First Workflow](#creating-your-first-workflow)
4. [Advanced Workflow Objects](#advanced-workflow-objects)
5. [Scripting Best Practices](#scripting-best-practices)
6. [Packaging and Distribution](#packaging-and-distribution)
7. [Testing and Debugging](#testing-and-debugging)
8. [Common Patterns and Examples](#common-patterns-and-examples)

## Understanding Alfred Workflows

### What is an Alfred Workflow?

Alfred workflows are mini-applications that extend Alfred's functionality. They consist of:

- **Triggers**: Hotkeys, keywords, or automated actions
- **Actions**: Scripts, filters, or output operations
- **Connections**: Links between triggers and actions
- **Variables**: Data storage and transfer

### Workflow Architecture

```
Input → Processing → Output
   ↓         ↓          ↓
Trigger → Script → Result/Action
```

## Setting Up Your Environment

### Prerequisites

1. **Alfred 5.7+** with Powerpack license
2. **macOS** (for testing and development)
3. **Text Editor** (VS Code, Sublime Text, etc.)
4. **Command Line Tools** (for scripting)

### Development Tools

- **Alfred Preferences**: Workflow editor
- **Terminal**: For script testing
- **plutil**: For plist validation
- **Git**: For version control

## Creating Your First Workflow

### Step 1: Plan Your Workflow

Define what your workflow will do:
- What trigger will activate it?
- What action will it perform?
- What output will it produce?

### Step 2: Create the Basic Structure

1. Create a new directory for your workflow
2. Create the `info.plist` file with required fields
3. Add your script logic

### Step 3: Configure the Keyword Input

```xml
<dict>
    <key>config</key>
    <dict>
        <key>argumenttype</key>
        <integer>1</integer>
        <key>keyword</key>
        <string>yourkeyword</string>
        <key>subtext</key>
        <string>Enter your command</string>
        <key>text</key>
        <string>Your Workflow Name</string>
        <key>withspace</key>
        <true/>
    </dict>
    <key>type</key>
    <string>alfred.workflow.input.keyword</string>
    <key>uid</key>
    <string>KEYWORD_INPUT</string>
    <key>version</key>
    <integer>1</integer>
</dict>
```

### Step 4: Create the Script Action

```xml
<dict>
    <key>config</key>
    <dict>
        <key>concurrently</key>
        <false/>
        <key>escaping</key>
        <integer>102</integer>
        <key>script</key>
        <string>#!/bin/bash

# Get the query from Alfred
query="{query}"

# Your workflow logic here
echo "Processing: $query"</string>
        <key>scriptargtype</key>
        <integer>0</integer>
        <key>type</key>
        <integer>0</integer>
    </dict>
    <key>type</key>
    <string>alfred.workflow.action.script</string>
    <key>uid</key>
    <string>SCRIPT_ACTION</string>
    <key>version</key>
    <integer>2</integer>
</dict>
```

### Step 5: Connect Objects

```xml
<key>connections</key>
<dict>
    <key>KEYWORD_INPUT</key>
    <array>
        <dict>
            <key>destinationuid</key>
            <string>SCRIPT_ACTION</string>
            <key>modifiers</key>
            <integer>0</integer>
            <key>vitoclose</key>
            <false/>
        </dict>
    </array>
</dict>
```

## Advanced Workflow Objects

### Hotkey Triggers

```xml
<dict>
    <key>config</key>
    <dict>
        <key>hotkey</key>
        <integer>65535</integer>
        <key>hotmod</key>
        <integer>1048576</integer>
        <key>hotstring</key>
        <string>⌘⌥⎵</string>
    </dict>
    <key>type</key>
    <string>alfred.workflow.input.hotkey</string>
    <key>uid</key>
    <string>HOTKEY_TRIGGER</string>
</dict>
```

### Script Filters (Dynamic Results)

```xml
<dict>
    <key>config</key>
    <dict>
        <key>script</key>
        <string>#!/bin/bash

query="{query}"

# Generate JSON output for Alfred
cat << EOF
{"items": [
    {
        "uid": "item1",
        "title": "First Result",
        "subtitle": "Description for first result",
        "arg": "result1",
        "icon": {"path": "icon1.png"}
    },
    {
        "uid": "item2",
        "title": "Second Result",
        "subtitle": "Description for second result",
        "arg": "result2",
        "icon": {"path": "icon2.png"}
    }
]}
EOF</string>
        <key>scriptargtype</key>
        <integer>0</integer>
        <key>type</key>
        <integer>0</integer>
    </dict>
    <key>type</key>
    <string>alfred.workflow.input.scriptfilter</string>
</dict>
```

### List Filters

```xml
<dict>
    <key>config</key>
    <dict>
        <key>items</key>
        <string>Option 1|Option 2|Option 3</string>
        <key>keyword</key>
        <string>list</string>
    </dict>
    <key>type</key>
    <string>alfred.workflow.input.listfilter</string>
</dict>
```

## Scripting Best Practices

### Bash Scripting Template

```bash
#!/bin/bash

# Alfred Workflow Script Template
# Version: 1.0
# Author: Your Name

# Configuration
WORKFLOW_NAME="Your Workflow Name"
VERSION="1.0"

# Utility functions
log_message() {
    echo "[$WORKFLOW_NAME] $1" >&2
}

show_notification() {
    local message="$1"
    osascript -e "display notification \"$message\" with title \"$WORKFLOW_NAME\""
}

copy_to_clipboard() {
    local content="$1"
    echo -n "$content" | pbcopy
}

error_handler() {
    local error_message="$1"
    log_message "ERROR: $error_message"
    show_notification "Error: $error_message"
    exit 1
}

# Main workflow logic
main() {
    local query="$1"

    # Input validation
    if [[ -z "$query" ]]; then
        error_handler "No input provided"
    fi

    # Process query
    case "$query" in
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            process_command "$query"
            ;;
    esac
}

# Command processing
process_command() {
    local command="$1"

    # Example command processing
    case "$command" in
        "action1")
            log_message "Executing action 1"
            # Your action 1 logic here
            show_notification "Action 1 completed"
            ;;
        "action2")
            log_message "Executing action 2"
            # Your action 2 logic here
            copy_to_clipboard "Action 2 result"
            ;;
        *)
            error_handler "Unknown command: $command"
            ;;
    esac
}

# Help function
show_help() {
    cat << EOF
$WORKFLOW_NAME v$VERSION

Usage:
  keyword [command]

Commands:
  action1    Description of action 1
  action2    Description of action 2
  help       Show this help message

Examples:
  keyword action1    Execute action 1
  keyword action2    Execute action 2
EOF
}

# Entry point
main "{query}"
```

### Error Handling Patterns

```bash
# Safe file operations
safe_write() {
    local content="$1"
    local file_path="$2"

    if ! echo "$content" > "$file_path" 2>/dev/null; then
        error_handler "Failed to write to $file_path"
    fi
}

# Safe command execution
safe_execute() {
    local command="$1"
    local output

    if ! output=$($command 2>&1); then
        error_handler "Command failed: $command"
    fi

    echo "$output"
}

# Input validation
validate_input() {
    local input="$1"
    local pattern="$2"

    if [[ ! "$input" =~ $pattern ]]; then
        error_handler "Invalid input format"
    fi
}
```

### Working with Files

```bash
# Create timestamped filenames
create_timestamped_filename() {
    local prefix="$1"
    local extension="${2:-txt}"
    echo "${prefix}_$(date +%Y%m%d_%H%M%S).$extension"
}

# Safe file paths
get_workflow_data_dir() {
    local workflow_dir="$HOME/Library/Application Support/Alfred/Workflow Data"
    local bundle_id="$1"

    mkdir -p "$workflow_dir/$bundle_id"
    echo "$workflow_dir/$bundle_id"
}

# Cleanup old files
cleanup_old_files() {
    local directory="$1"
    local days="$2"

    find "$directory" -type f -mtime "+$days" -delete 2>/dev/null
}
```

## Packaging and Distribution

### Creating the Workflow Package

1. **Organize Files**:
```bash
my-workflow/
├── info.plist
├── icon.png
├── script.sh
└── README.md
```

2. **Create ZIP Archive**:
```bash
zip -r my-workflow.alfredworkflow my-workflow/
```

3. **Validate Package**:
```bash
# Check plist syntax
plutil -lint my-workflow/info.plist

# Test import functionality
# Import into Alfred and test all features
```

### Version Management

```bash
# Increment version number
sed -i '' 's/<string>1.0<\/string>/<string>1.1<\/string>/' info.plist

# Create release package
git tag v1.1
zip -r my-workflow-v1.1.alfredworkflow my-workflow/
```

## Testing and Debugging

### Testing Checklist

- [ ] Workflow imports successfully
- [ ] Keyword triggers correctly
- [ ] All commands work as expected
- [ ] Error conditions are handled
- [ ] File operations work
- [ ] Clipboard functionality works
- [ ] Notifications display properly
- [ ] No conflicts with other workflows

### Debugging Techniques

1. **Enable Debug Mode**:
```bash
# Add debug logging to your script
DEBUG=true
if [[ "$DEBUG" == "true" ]]; then
    echo "DEBUG: query=$query" >&2
fi
```

2. **Test Scripts Independently**:
```bash
# Test your script in Terminal first
./script.sh "test input"
```

3. **Check Alfred Console**:
- Open Alfred Preferences → Advanced → View Log
- Look for error messages and warnings

4. **Validate Plist Structure**:
```bash
plutil -lint info.plist
```

### Common Issues and Solutions

**Issue**: Workflow won't import
- **Solution**: Check plist syntax and required fields

**Issue**: Keyword doesn't trigger
- **Solution**: Verify keyword configuration and connections

**Issue**: Script fails silently
- **Solution**: Add error handling and debug logging

**Issue**: File permission errors
- **Solution**: Check script permissions and file paths

## Common Patterns and Examples

### Web Search Workflow

```bash
#!/bin/bash

query="{query}"

# URL encode the query
encoded_query=$(echo "$query" | jq -sRr @uri)

# Open search URL
open "https://www.google.com/search?q=$encoded_query"

echo "Searched for: $query"
```

### File Management Workflow

```bash
#!/bin/bash

query="{query}"
action="$1"
filename="$2"

case "$action" in
    "create")
        touch ~/Desktop/"$filename"
        echo "Created file: $filename"
        ;;
    "delete")
        rm ~/Desktop/"$filename"
        echo "Deleted file: $filename"
        ;;
    *)
        echo "Usage: file [create|delete] filename"
        ;;
esac
```

### System Information Workflow

```bash
#!/bin/bash

query="{query}"

case "$query" in
    "cpu")
        top -l 1 | head -n 10
        ;;
    "memory")
        vm_stat
        ;;
    "disk")
        df -h
        ;;
    *)
        echo "Usage: sys [cpu|memory|disk]"
        ;;
esac
```

### Application Launcher

```bash
#!/bin/bash

app_name="{query}"

# Find application
app_path=$(mdfind "kMDItemDisplayName == '$app_name' && kMDItemKind == 'Application'" | head -1)

if [[ -n "$app_path" ]]; then
    open "$app_path"
    echo "Launched: $app_name"
else
    echo "Application not found: $app_name"
fi
```

## Conclusion

This tutorial provides a comprehensive foundation for Alfred workflow development in 2025. By following these patterns and best practices, you can create robust, efficient workflows that integrate seamlessly with Alfred.

Remember to:
- Test thoroughly before distribution
- Handle errors gracefully
- Provide clear user feedback
- Keep your code maintainable
- Document your workflows

Happy workflow building!