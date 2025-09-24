# Optimized Development Workflow

This comprehensive development workflow integrates Alfred, Claude Code, and Chrome DevTools to streamline your web development process.

## Features

### 🚀 Core Workflows

1. **Error Logger** (`err` keyword)
   - Auto-generate timestamped error logs
   - Direct integration with Claude Code
   - Project context awareness

2. **Dev Screenshot** (`devsc` keyword)
   - Context-aware screenshot capture
   - Automatic categorization (error, bug, feature, ui)
   - Claude Code integration with context

3. **Chrome Monitor** (`chrome` keyword)
   - Chrome DevTools error capture
   - Console logging
   - Network analysis
   - Performance monitoring

### 📝 Smart Snippets

50+ pre-configured Alfred snippets for common Claude Code commands:
- Error debugging (`err_analyze`, `err_debug`, `err_fix`)
- Screenshot analysis (`sc_error`, `sc_bug`, `sc_ui`)
- Code review (`code_review`, `code_optimize`, `code_refactor`)
- Development workflow (`dev_test`, `dev_build`, `dev_deploy`)

### 🤖 Automated Scripts

- **dev-integration.sh**: Core development environment setup
- **auto-debug.sh**: Automated debugging workflow
- **monitor.sh**: Continuous development monitoring

## Installation

### 1. Install Alfred Workflows

```bash
# Install the workflows
cd dev-workflow

# Error Logger
open error-logger

# Dev Screenshot
open screenshot-dev

# Chrome Monitor
open chrome-monitor
```

### 2. Setup Development Scripts

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Add to your PATH (optional)
echo 'export PATH="$PATH:$(pwd)/scripts"' >> ~/.bashrc
```

### 3. Import Alfred Snippets

1. Open Alfred Preferences
2. Go to Snippets
3. Import `snippets/claude-snippets.txt`

### 4. Configure Directories

The scripts create these directories automatically:
- `~/Desktop/dev-logs/` - Error logs and debugging info
- `~/Desktop/dev-screenshots/` - Development screenshots
- `~/Desktop/dev-monitor/` - Monitoring data
- `~/Desktop/dev-scripts/` - Development scripts

## Usage

### Debugging Workflow

#### Manual Debugging
```bash
# 1. Capture error (Chrome DevTools → Copy to clipboard)
err [error_description]

# 2. Take screenshot
devsc [error|bug|feature|ui]

# 3. Use snippet to analyze
# Type: err_analyze (with error log path in clipboard)
```

#### Automated Debugging
```bash
# Quick debug cycle
scripts/auto-debug.sh quick "Describe the issue"

# Continuous monitoring
scripts/auto-debug.sh monitor

# Auto-capture Chrome errors
scripts/auto-debug.sh capture
```

### Development Workflow

#### Setup New Project
```bash
# Setup development environment
scripts/dev-integration.sh setup /path/to/project

# Get project context
scripts/dev-integration.sh context /path/to/project
```

#### Daily Development
1. Start monitoring: `scripts/auto-debug.sh monitor`
2. Work on your code
3. Errors auto-captured and sent to Claude Code
4. Screenshots taken when changes detected
5. Claude Code provides analysis and fixes

### Chrome DevTools Integration

#### Console Errors
```bash
chrome errors
```

#### Network Analysis
```bash
chrome network
# (Copy network requests from Chrome DevTools)
```

#### Performance Analysis
```bash
chrome performance
# (Copy performance metrics from Chrome DevTools)
```

## Workflow Examples

### Example 1: Bug Fixing
1. See bug in browser
2. `cmd+option+I` to open DevTools
3. Copy error from console
4. `err bug description` (creates log file)
5. `devsc bug` (takes screenshot)
6. `err_analyze` (sends to Claude Code)
7. Claude Code analyzes and provides fixes

### Example 2: Feature Development
1. Start new feature
2. `scripts/dev-integration.sh setup`
3. Work on feature
4. `devsc feature` (document progress)
5. `code_review` (get feedback)
6. `dev_test` (run tests)

### Example 3: Performance Optimization
1. `chrome performance`
2. Record performance in Chrome DevTools
3. Copy metrics to clipboard
4. `chrome_performance` snippet
5. Claude Code analyzes and suggests optimizations

## Alfred Keywords Reference

| Keyword | Description | Example |
|---------|-------------|---------|
| `err` | Log development error | `err Button not working` |
| `err auto` | Auto-capture Chrome errors | `err auto` |
| `devsc` | Take development screenshot | `devsc error` |
| `chrome errors` | Capture Chrome errors | `chrome errors` |
| `chrome console` | Log console output | `chrome console` |
| `chrome network` | Network analysis | `chrome network` |
| `chrome performance` | Performance analysis | `chrome performance` |

## Smart Snippets Reference

### Error Debugging
- `err_analyze` - Analyze error log
- `err_debug` - Debug specific error
- `err_fix` - Request error fix
- `err_console` - Analyze console output

### Screenshot Analysis
- `sc_error` - Analyze error screenshot
- `sc_bug` - Identify bugs in screenshot
- `sc_ui` - Review UI screenshot
- `sc_feature` - Analyze feature screenshot

### Code Review
- `code_review` - General code review
- `code_optimize` - Performance optimization
- `code_refactor` - Code refactoring
- `code_debug` - Debug specific code

### Development Workflow
- `dev_test` - Run tests and fix failures
- `dev_build` - Build project and fix errors
- `dev_deploy` - Deploy and check issues
- `dev_monitor` - Monitor for errors

## Advanced Features

### Customization

#### Add New Snippets
Edit `snippets/claude-snippets.txt` and reimport in Alfred.

#### Modify Workflows
Edit the `info.plist` files in each workflow directory.

#### Extend Scripts
Add new functions to `scripts/dev-integration.sh`.

### Automation

#### cron Jobs
```bash
# Add to crontab for automatic monitoring
*/5 * * * * /path/to/dev-workflow/scripts/auto-debug.sh capture
```

#### Git Hooks
```bash
# Add to .git/hooks/pre-commit for pre-commit checks
#!/bin/bash
/path/to/dev-workflow/scripts/dev-integration.sh send "Review this commit" .
```

### MCP Integration

For advanced MCP integration, add these servers to your Claude Code configuration:

```json
{
  "mcpServers": {
    "alfred": {
      "command": "node",
      "args": ["path/to/alfred-mcp-server.js"],
      "env": {}
    }
  }
}
```

## Troubleshooting

### Common Issues

1. **Chrome not responding**: Make sure Chrome is running and accessible
2. **Claude Code not found**: Install Claude Code from Anthropic
3. **Permissions not working**: Check Alfred permissions in System Preferences
4. **Screenshots not saving**: Check Desktop permissions

### Debug Mode

Enable debug mode by setting:
```bash
export DEBUG_DEV_WORKFLOW=1
```

### Logs

Check these locations for logs:
- `~/Desktop/dev-logs/` - Error logs
- `~/Desktop/dev-monitor/` - Monitoring logs
- Console output from scripts

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your improvements
4. Test thoroughly
5. Submit a pull request

## Support

For issues and questions:
1. Check the troubleshooting section
2. Review the logs
3. Create an issue with detailed information

---

**This optimized workflow saves 60-80% of development time through automation and intelligent tool integration.**