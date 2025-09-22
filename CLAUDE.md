# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Alfred workflow development kit containing working workflows, templates, and comprehensive documentation for creating Alfred 5.7+ workflows in 2025. The repository focuses on modern Alfred workflow development with validated plist structures and best practices.

## Common Development Commands

### Workflow Validation
```bash
# Validate plist syntax before packaging
plutil -lint workflow-name/info.plist

# Test workflow import (manual process in Alfred)
# Double-click the .alfredworkflow file to test import
```

### Workflow Packaging
```bash
# Create a distributable .alfredworkflow file
zip -r workflow-name.alfredworkflow workflow-name/

# Package the screenshot workflow
zip -r screenshot-capture.alfredworkflow screenshot-capture/
```

### File Structure Management
```bash
# Create new workflow from template
cp -r template/ your-new-workflow/

# List all workflow directories
find . -maxdepth 2 -type d -name "info.plist" | sed 's|/info.plist||'
```

## Architecture Overview

### Core Components

1. **Working Workflows**: Complete, functional Alfred workflows (e.g., `screenshot-capture/`)
2. **Template System**: Reusable template in `template/` with validated plist structure
3. **Documentation**: Comprehensive guides and API references

### Alfred Workflow Structure

Every Alfred workflow follows this pattern:
- **`info.plist`**: Core workflow configuration with objects, connections, and metadata
- **Keyword Input Object**: Triggers workflow execution with user input
- **Script Action Object**: Executes bash scripts with `{query}` variable
- **Connections Dictionary**: Links input objects to action objects

### Key Plist Structure
```xml
<dict>
    <key>bundleid</key>     <!-- Unique reverse domain identifier -->
    <key>objects</key>      <!-- Array of workflow components -->
    <key>connections</key>  <!-- Object relationships -->
    <key>uidata</key>       <!-- Visual layout positioning -->
</dict>
```

### Script Integration Pattern
Workflows use `/bin/bash` scripts that:
1. Receive user input via `{query}` variable
2. Use `case` statements for command routing
3. Provide feedback via `echo` and notifications
4. Copy results to clipboard with `pbcopy`
5. Handle errors gracefully with `osascript` notifications

## Development Workflow

### Creating New Workflows
1. Copy `template/` directory to new workflow name
2. Replace placeholders in `info.plist`:
   - `bundleid`: Your unique identifier
   - `keyword`: Your trigger keyword
   - Object UIDs: Generate unique identifiers
3. Update script logic in the script action object
4. Validate with `plutil -lint`
5. Package as `.alfredworkflow` file

### Testing Checklist
- [ ] Plist validates successfully
- [ ] Workflow imports to Alfred without errors
- [ ] Keyword triggers work as expected
- [ ] All script functions execute correctly
- [ ] Error conditions are handled gracefully
- [ ] Clipboard operations work
- [ ] Notifications display properly

### Script Best Practices
- Always handle `{query}` variable safely
- Use `case` statements for multiple commands
- Provide help text for empty/invalid input
- Use `osascript` for user notifications
- Copy meaningful output to clipboard with `pbcopy`
- Implement proper error handling and logging

## Important Files

- **`template/info.plist`**: Validated template for new workflows
- **`template/README.md`**: Complete development reference with examples
- **`DEVELOPMENT_TUTORIAL.md`**: Comprehensive workflow development guide
- **`README.md`**: Project overview and screenshot workflow documentation

## Testing Environment

Workflows require:
- Alfred 5.7+ with Powerpack license
- macOS for `screencapture` and system commands
- Manual testing in Alfred (no automated test framework)
- Screen recording permissions for screenshot functionality