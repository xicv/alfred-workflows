# Alfred Workflow Development Template

A complete, validated template for creating Alfred 5.7+ workflows in 2025.

## Quick Start

1. Copy the `template/` directory to your workflow folder
2. Modify `info.plist` with your workflow details
3. Update the script with your functionality
4. Package as `.alfredworkflow` file

## File Structure

```
your-workflow/
├── info.plist          # Workflow configuration
├── icon.png            # Workflow icon (optional)
├── README.md           # Documentation
└── scripts/            # Additional scripts (optional)
```

## Required Fields in info.plist

### Basic Information
- `bundleid`: Unique identifier (reverse domain notation)
- `name`: Display name in Alfred
- `description`: Workflow description
- `createdby`: Author name
- `version`: Workflow version

### Workflow Objects
- `objects`: Array of workflow components
- `connections`: Links between objects
- `uidata`: Visual layout data

### Object Types
- `alfred.workflow.input.keyword`: Keyword trigger
- `alfred.workflow.action.script`: Script execution
- `alfred.workflow.input.hotkey`: Hotkey trigger
- `alfred.workflow.output.clipboard`: Clipboard output

## Configuration Template

### Keyword Input Object
```xml
<dict>
    <key>config</key>
    <dict>
        <key>argumenttype</key>
        <integer>1</integer>  <!-- 0=no arg, 1=required, 2=optional -->
        <key>keyword</key>
        <string>yourkeyword</string>
        <key>withspace</key>
        <true/>
    </dict>
    <key>type</key>
    <string>alfred.workflow.input.keyword</string>
    <key>uid</key>
    <string>UNIQUE_ID</string>
</dict>
```

### Script Action Object
```xml
<dict>
    <key>config</key>
    <dict>
        <key>script</key>
        <string>#!/bin/bash
query="{query}"
# Your script here
        </string>
        <key>type</key>
        <integer>0</integer>  <!-- 0=/bin/bash -->
    </dict>
    <key>type</key>
    <string>alfred.workflow.action.script</string>
</dict>
```

## Best Practices 2025

### 1. Script Structure
- Use `/bin/bash` for maximum compatibility
- Always handle the `{query}` variable
- Provide help for invalid arguments
- Use `case` statements for multiple commands

### 2. File Paths
- Use relative paths in workflows
- Store user files in `~/Library/Application Support/Alfred/Workflow Data/`
- Use `~` expansion for user directories

### 3. Permissions
- Request necessary permissions in workflow description
- Handle permission failures gracefully
- Use `osascript` for user interactions

### 4. Error Handling
```bash
#!/bin/bash

query="{query}"

# Error handling function
error_handler() {
    echo "Error: $1" >&2
    osascript -e "display notification \"$1\" with title \"Workflow Error\""
    exit 1
}

# Main logic
case "$query" in
    "command")
        # Your command here
        ;;
    *)
        error_handler "Invalid command. Use: keyword [command]"
        ;;
esac
```

## Common Script Patterns

### File Operations
```bash
filename="file_$(date +%Y%m%d_%H%M%S).txt"
echo "content" > ~/Desktop/"$filename"
echo -n "$filename" | pbcopy
```

### Notifications
```bash
osascript -e "display notification \"Message\" with title \"Workflow Name\""
```

### Web Requests
```bash
curl -s "https://api.example.com/endpoint" | jq '.data'
```

### System Commands
```bash
screencapture -x ~/Desktop/screenshot.png
open /Applications/TextEdit.app
```

## Packaging for Distribution

1. Create workflow directory
2. Add all files and scripts
3. Create ZIP archive: `zip -r workflow.alfredworkflow workflow/`
4. Test import in Alfred

## Testing Your Workflow

1. Import into Alfred
2. Test all keyword combinations
3. Verify file operations
4. Test error conditions
5. Check clipboard functionality

## Debugging

1. Use `echo` statements for debugging
2. Check Alfred debug console
3. Test scripts independently in Terminal
4. Verify file permissions

## Resources

- [Alfred Documentation](https://www.alfredapp.com/help/)
- [Alfred Forum](https://www.alfredforum.com/)
- [Alfred Workflow Gallery](https://alfredapp.com/workflows/)

## Template Variables

Replace these placeholders in the template:

- `com.yourcompany.workflow.name` → Your bundle ID
- `Your Name` → Your name/organization
- `Workflow Name` → Your workflow name
- `keyword` → Your trigger keyword
- `UNIQUE_ID` → Generate unique IDs for each object

## Example: Simple Calculator Workflow

```bash
#!/bin/bash

query="{query}"

# Simple calculator
calculate() {
    echo "$1" | bc -l 2>/dev/null || echo "Invalid expression"
}

case "$query" in
    ""|"-h"|"--help")
        echo "Usage: calc [mathematical expression]"
        echo "Example: calc 2+2*3"
        ;;
    *)
        result=$(calculate "$query")
        echo "Result: $result"
        echo -n "$result" | pbcopy
        osascript -e "display notification \"Result: $result\" with title \"Calculator\""
        ;;
esac
```

This template provides everything needed to create modern, compatible Alfred workflows in 2025.