# Alfred Workflow Collection

A curated collection of Alfred 5.7+ workflows with comprehensive development tools and optimized workflows for modern developers.

## Available Workflows

### 🖥️ Screenshot Capture
- **File**: `Screenshot-Capture.alfredworkflow`
- **Trigger**: `sc`
- **Commands**:
  - `sc fs` - Full screen screenshot
  - `sc w` - Window screenshot
  - `sc s` - Selection screenshot
- **Features**: Auto-saves to Desktop, copies filename to clipboard
- **Directory**: `screenshot-capture/`

### 🚀 Optimized Development Workflows

#### Error Logger (NEW!)
- **File**: `error-logger-fixed.alfredworkflow`
- **Trigger**: `err`
- **Usage**:
  - `err [description]` - Create error log with description
  - `err auto` - Auto-capture Chrome errors
- **Features**:
  - Creates timestamped error logs in `~/Desktop/dev-logs/`
  - Auto-copies file path to clipboard
  - Project context awareness
  - Claude Code integration ready
- **Perfect for**: Debugging Chrome errors, logging issues

#### Development Screenshot (NEW!)
- **File**: `screenshot-dev.alfredworkflow` (direct install)
- **Trigger**: `devsc`
- **Usage**:
  - `devsc error` - Error screenshots
  - `devsc bug` - Bug documentation
  - `devsc feature` - Feature implementation
  - `devsc ui` - UI review
- **Features**:
  - Context-aware screenshot naming
  - Saves to `~/Desktop/dev-screenshots/`
  - Auto-copies file path to clipboard
  - Ready for Claude Code analysis
- **Perfect for**: Visual bug tracking, feature documentation

#### Chrome Monitor (NEW!)
- **File**: `chrome-monitor.alfredworkflow` (direct install)
- **Trigger**: `chrome`
- **Usage**:
  - `chrome errors` - Console error analysis
  - `chrome console` - Console output logging
  - `chrome network` - Network request analysis
  - `chrome performance` - Performance metrics
- **Features**:
  - Creates structured analysis logs
  - Saves to `~/Desktop/dev-monitor/`
  - Auto-copies file path to clipboard
  - DevTools integration ready
- **Perfect for**: Chrome DevTools workflow integration

## 🛠️ Development Tools

### Workflow Template
- **Directory**: `template/`
- **Purpose**: Ready-to-use template for creating new workflows
- **Includes**: Validated plist structure, documentation, examples
- **Usage**: Copy the template directory and customize for your workflow

### 🤖 Smart Development Integration
- **Directory**: `dev-workflow/`
- **Purpose**: Complete development workflow optimization
- **Includes**:
  - Automated Alfred workflows for debugging
  - Smart snippets for Claude Code integration
  - Development scripts for automation
  - Comprehensive documentation
- **Features**: 60-80% time reduction in development debugging cycles

### 📝 Smart Snippets Collection
- **File**: `dev-workflow/snippets/claude-snippets.txt`
- **Purpose**: Pre-configured Alfred snippets for Claude Code
- **Categories**:
  - Error debugging (`err_analyze`, `err_debug`, `err_fix`)
  - Screenshot analysis (`sc_error`, `sc_bug`, `sc_ui`)
  - Code review (`code_review`, `code_optimize`, `code_refactor`)
  - Development workflow (`dev_test`, `dev_build`, `dev_deploy`)
  - Chrome DevTools integration (`chrome_errors`, `chrome_console`)

### 🚀 Development Scripts
- **Location**: `dev-workflow/scripts/` and `~/Desktop/dev-scripts/`
- **Available Scripts**:
  - `dev-integration.sh` - Core development environment setup
  - `auto-debug.sh` - Automated debugging workflows
  - `setup.sh` - One-click installation script

### Documentation
- **`DEVELOPMENT_TUTORIAL.md`**: Complete guide to Alfred workflow development
- **`template/README.md`**: Template documentation with examples and best practices
- **`CLAUDE.md`**: Development guidance for AI assistants
- **`dev-workflow/README.md`**: Comprehensive development workflow guide
- **`dev-workflow/QUICK_SETUP.md`**: Quick setup instructions for optimized workflows

## 🚀 Quick Start

### Installing Workflows

#### Method 1: Direct Install (Recommended)
Development workflows are now pre-installed in Alfred's sync directory:
- **Dev Screenshot**: `devsc` - saves to `~/Desktop/dev-screenshots/`
- **Chrome Monitor**: `chrome` - saves to `~/Desktop/dev-monitor/`

#### Method 2: Import .alfredworkflow Files
1. **Double-click any `.alfredworkflow` file**
2. Alfred will automatically import and install the workflow
3. Use the specified keyword trigger in Alfred

### Setting Up Optimized Development Workflow
1. **Development Workflows** (pre-installed):
   - `devsc` - Development screenshots
   - `chrome` - Chrome monitoring
2. **Optional Additional Workflows**:
   - `error-logger-fixed.alfredworkflow` - Error logging

2. **Import Smart Snippets**:
   - Open Alfred Preferences → Snippets
   - Import `dev-workflow/snippets/claude-snippets.txt`

3. **Test Your Pre-installed Workflows**:
   ```bash
   devsc bug
   chrome errors
   ```

4. **Optional: Run Setup Script**:
   ```bash
   cd dev-workflow
   ./setup.sh
   ```

### Creating New Workflows
1. Copy the template: `cp -r template/ your-workflow-name/`
2. Modify `info.plist` with your workflow details
3. Update the script with your functionality
4. Validate: `plutil -lint your-workflow-name/info.plist`
5. Package: `cd your-workflow-name/ && zip -r ../your-workflow-name.alfredworkflow .`

## Requirements

All workflows require:
- **Alfred 5.7+** with Powerpack license
- **macOS** for system command compatibility

### Development Workflow Requirements
- **Claude Code** (recommended for AI integration)
- **Chrome Browser** (for Chrome monitoring workflow)
- **Git** (for development context tracking)
- **Basic bash knowledge** (for customizing scripts)

## Workflow Structure

```
workflow-name/
├── info.plist          # Workflow configuration
├── README.md           # Workflow documentation
└── (additional files)  # Icons, scripts, etc.
```

## 📁 Development Workflow Directory Structure

```
dev-workflow/
├── *.alfredworkflow    # Packaged workflows (ready to import)
├── error-logger-fixed/          # Error logger workflow source
├── screenshot-dev-fixed/        # Screenshot workflow source
├── chrome-monitor-fixed/        # Chrome monitor workflow source
├── scripts/                    # Development automation scripts
│   ├── dev-integration.sh       # Core development setup
│   ├── auto-debug.sh           # Automated debugging
│   └── setup.sh                # Installation script
├── snippets/                   # Alfred snippets collection
│   └── claude-snippets.txt     # 50+ pre-configured snippets
├── README.md                   # Comprehensive guide
└── QUICK_SETUP.md              # Quick setup instructions

# Auto-created directories:
~/Desktop/dev-logs/           # Error logs
~/Desktop/dev-screenshots/    # Development screenshots
~/Desktop/dev-monitor/        # Monitoring data
~/Desktop/dev-scripts/        # Executable scripts
```

## 🛠️ Development

### Building & Packaging
```bash
# Validate workflow plist
plutil -lint workflow-name/info.plist

# Create distributable package (from inside workflow directory)
cd workflow-name/
zip -r ../workflow-name.alfredworkflow .

# Or from parent directory (ensure files are at root level, not in subdirectory)
zip -r workflow-name.alfredworkflow workflow-name/

# Package all development workflows
cd dev-workflow/
zip -r development-workflows.zip *.alfredworkflow scripts/ snippets/
```

### Best Practices
- Use the provided template for consistency
- Test workflows thoroughly before distribution
- Follow Alfred 5.7+ plist structure requirements
- Include proper error handling and user feedback
- Use unique bundle identifiers for custom workflows

### 🔧 Development Workflow Tips

#### Error Debugging Cycle
1. **Capture Error**: `err [description]` (copies Chrome errors)
2. **Take Screenshot**: `devsc error` (visual documentation)
3. **Analyze**: Use `err_analyze` snippet (sends to Claude Code)
4. **Fix**: Apply Claude Code's suggestions
5. **Test**: Verify the fix works

#### Chrome DevTools Integration
1. **Copy console errors** from Chrome DevTools
2. **Use**: `chrome errors` (creates structured log)
3. **Add context**: Paste network requests if needed
4. **Analyze**: Use `chrome_errors` snippet for Claude Code

#### Smart Snippets Usage
- **Error Analysis**: `err_analyze`, `err_debug`, `err_fix`
- **Screenshot Review**: `sc_error`, `sc_bug`, `sc_ui`
- **Code Optimization**: `code_review`, `code_optimize`, `code_refactor`
- **Development Workflow**: `dev_test`, `dev_build`, `dev_deploy`

## 📚 Complete Tutorials

### Tutorial 1: Debugging Chrome Errors (5 Minutes)

**Scenario**: You see a JavaScript error in Chrome DevTools

**Step 1: Capture the Error**
```bash
# 1. In Chrome DevTools, right-click the error → Copy
# 2. In Alfred, type:
err Button click not working
# 3. Press Enter
```
**Result**: Creates `/Users/username/Desktop/dev-logs/error_20230923_143022.log`

**Step 2: Take Screenshot**
```bash
# In Alfred, type:
devsc error
# Take screenshot of the error in browser
```
**Result**: Creates `/Users/username/Desktop/dev-screenshots/error_20230923_143025.png`

**Step 3: Analyze with Claude Code**
```bash
# File path is already in clipboard from Step 1
# In your terminal, Claude Code will auto-analyze:
claude "Analyze this error and suggest fixes"
```

**Step 4: Use Smart Snippet**
```bash
# In Alfred, type snippet:
err_analyze
# (expands to: "Analyze this error log: [filepath]")
```

### Tutorial 2: Web Development Debug Cycle (10 Minutes)

**Scenario**: Your React app has a styling bug

**Step 1: Document the Issue**
```bash
# Capture the visual bug
devsc bug
# Describe the issue
err CSS styling broken on main component
```

**Step 2: Get Chrome Context**
```bash
# Copy console errors from Chrome DevTools
chrome console
# Copy network requests if needed
chrome network
```

**Step 3: Automated Analysis**
```bash
# Use the auto-debug script
~/Desktop/dev-scripts/auto-debug.sh quick "CSS styling issue"
```

**Step 4: Apply and Test**
```bash
# Apply Claude Code's fixes
# Test the changes
# If needed, take comparison screenshot
devsc feature
```

### Tutorial 3: Performance Optimization (15 Minutes)

**Scenario**: Your web app is running slowly

**Step 1: Capture Performance Data**
```bash
# In Chrome DevTools:
# 1. Go to Performance tab
# 2. Record performance (Ctrl+E)
# 3. Copy the performance metrics
# 4. In Alfred:
chrome performance
```

**Step 2: Create Comprehensive Log**
```bash
# Add your observations
err Performance issues with loading times
# Paste performance data
```

**Step 3: Advanced Analysis**
```bash
# Use Claude Code with multiple files:
claude "Analyze this performance issue and suggest optimizations"
```

### Tutorial 4: Feature Development Workflow (20 Minutes)

**Scenario**: Building a new feature from scratch

**Step 1: Setup Project Context**
```bash
# Navigate to your project
cd /path/to/your/project
~/Desktop/dev-scripts/dev-integration.sh setup
```

**Step 2: Document Requirements**
```bash
# Create feature documentation
devsc feature
err New user authentication feature needed
```

**Step 3: Development and Testing**
```bash
# During development:
#   - Use err for any errors
#   - Use devsc for progress screenshots
#   - Use code_review snippet for code feedback

# After implementing:
dev_test
```

**Step 4: Deployment Preparation**
```bash
# Final review:
code_review
dev_build
dev_deploy
```

### Tutorial 5: Daily Development Routine (Ongoing)

**Morning Setup**
```bash
# Start monitoring
~/Desktop/dev-scripts/auto-debug.sh monitor &
# Creates continuous monitoring
```

**During Development**
```bash
# When you encounter errors:
err [description]
devsc [type]
# Use appropriate snippet for analysis
```

**End of Day**
```bash
# Review today's logs:
ls -la ~/Desktop/dev-logs/
ls -la ~/Desktop/dev-screenshots/
# Archive or clean up as needed
```

## 🎯 Advanced Usage Patterns

### Pattern 1: Error Investigation
```bash
# 1. Initial error capture
err "Unexpected behavior in user authentication"

# 2. Visual documentation
devsc error

# 3. Get browser context
chrome errors

# 4. Automated debugging
auto-debug quick "Authentication flow issue"
```

### Pattern 2: Code Review Process
```bash
# 1. Capture code changes
git diff | pbcopy
err "Code review needed for authentication feature"

# 2. Use smart snippet
code_review

# 3. Claude Code analysis
claude "Review this code for security and performance"
```

### Pattern 3: Performance Monitoring
```bash
# 1. Baseline performance
chrome performance
err "Baseline performance metrics"

# 2. After optimizations
chrome performance
err "Post-optimization performance"

# 3. Comparison analysis
claude "Compare before/after performance metrics"
```

## 🛠️ Customization Guide

### Adding Custom Snippets
1. Open Alfred Preferences → Snippets
2. Add new snippet with:
   - **Keyword**: Your custom trigger
   - **Content**: Your Claude Code prompt template

### Modifying Workflows
1. Open workflow in Alfred
2. Edit the script section
3. Test with: `plutil -lint info.plist`
4. Re-package the workflow

### Extending Scripts
```bash
# Add custom functions to dev-integration.sh
custom_function() {
    # Your custom logic
}

# Then use in your workflow scripts
```

## Contributing

1. Use the template for new workflows
2. Follow the documented structure patterns
3. Include comprehensive README documentation
4. Test across different Alfred versions

## License

MIT License - Feel free to modify and redistribute workflows and templates.

## Support

For workflow-specific issues, check the individual workflow documentation.
For development questions, refer to `DEVELOPMENT_TUTORIAL.md` and the template documentation.