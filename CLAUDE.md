# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Alfred workflow development kit containing working workflows, templates, and comprehensive documentation for creating Alfred 5.7+ workflows in 2025. The repository focuses on modern Alfred workflow development with validated plist structures and best practices.

## Critical Architecture Notes

**⚠️ Alfred Workflow Package Structure**: Alfred workflows require files to be at the **root level** of the zip package, not in a subdirectory. This is the most common cause of import failures.

**Correct structure for .alfredworkflow files:**
```
workflow-name.alfredworkflow
├── info.plist
├── icon.icns
└── README.md
```

**Incorrect structure (will fail to import):**
```
workflow-name.alfredworkflow
└── workflow-name/
    ├── info.plist
    ├── icon.icns
    └── README.md
```

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
# Create a distributable .alfredworkflow file (CORRECT METHOD)
cd workflow-name/
zip -r ../workflow-name.alfredworkflow .

# OR from parent directory (ensures root-level files)
zip -r workflow-name.alfredworkflow workflow-name/

# Package the screenshot workflow
cd screenshot-capture/
zip -r ../screenshot-capture.alfredworkflow .

# ALWAYS TEST: Double-click the .alfredworkflow file to verify import works
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
3. **Development Workflow**: Advanced tools in `dev-workflow/` with automated scripts and smart snippets
4. **Documentation**: Comprehensive guides and API references

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

### Development Workflow Integration
The `dev-workflow/` directory contains:
- **Automated Scripts**: `dev-integration.sh`, `auto-debug.sh` for development automation
- **Smart Snippets**: 50+ pre-configured Alfred snippets for Claude Code integration
- **Optimized Workflows**: Advanced workflows with Claude Code integration
- **Setup Scripts**: One-click installation and configuration

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
- **`dev-workflow/README.md`**: Advanced development workflow integration guide
- **`dev-workflow/snippets/claude-snippets.txt`**: 50+ pre-configured Alfred snippets for Claude Code
- **`dev-workflow/scripts/dev-integration.sh`**: Core development environment setup script

## Testing Environment

Workflows require:
- Alfred 5.7+ with Powerpack license
- macOS for `screencapture` and system commands
- Manual testing in Alfred (no automated test framework)
- Screen recording permissions for screenshot functionality
- **Critical**: Always test workflow import by double-clicking .alfredworkflow files

## Development Integration

### Automated Development Environment
The `dev-workflow/scripts/` directory provides automated setup:
- **dev-integration.sh**: Creates standard directories (`~/Desktop/dev-scripts/`, `~/Desktop/dev-logs/`, etc.)
- **auto-debug.sh**: Automated debugging workflow with Claude Code integration
- **setup.sh**: One-click installation of all workflows and snippets

### Smart Snippets System
Alfred snippets in `dev-workflow/snippets/claude-snippets.txt` provide:
- Error debugging commands (`err_analyze`, `err_debug`, `err_fix`)
- Screenshot analysis commands (`sc_error`, `sc_bug`, `sc_ui`)
- Code review commands (`code_review`, `code_optimize`, `code_refactor`)
- Development workflow commands (`dev_test`, `dev_build`, `dev_deploy`)

### Standard Directory Structure
Development workflows use standardized directories:
- `~/Desktop/dev-logs/`: Error logs and development notes
- `~/Desktop/dev-screenshots/`: Development screenshots
- `~/Desktop/dev-monitor/`: Chrome monitoring data
- `~/Desktop/dev-scripts/`: Executable development scripts