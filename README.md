# Alfred Workflow Collection

A curated collection of Alfred 5.7+ workflows with comprehensive development tools and templates.

## Available Workflows

### Screenshot Capture
- **File**: `Screenshot-Capture.alfredworkflow`
- **Trigger**: `sc`
- **Commands**:
  - `sc fs` - Full screen screenshot
  - `sc w` - Window screenshot
  - `sc s` - Selection screenshot
- **Features**: Auto-saves to Desktop, copies filename to clipboard
- **Directory**: `screenshot-capture/`

## Development Tools

### Workflow Template
- **Directory**: `template/`
- **Purpose**: Ready-to-use template for creating new workflows
- **Includes**: Validated plist structure, documentation, examples
- **Usage**: Copy the template directory and customize for your workflow

### Documentation
- **`DEVELOPMENT_TUTORIAL.md`**: Complete guide to Alfred workflow development
- **`template/README.md`**: Template documentation with examples and best practices
- **`CLAUDE.md`**: Development guidance for AI assistants

## Quick Start

### Installing Workflows
1. Double-click any `.alfredworkflow` file
2. Alfred will automatically import and install the workflow
3. Use the specified keyword trigger in Alfred

### Creating New Workflows
1. Copy the template: `cp -r template/ your-workflow-name/`
2. Modify `info.plist` with your workflow details
3. Update the script with your functionality
4. Package: `zip -r your-workflow.alfredworkflow your-workflow-name/`

## Requirements

All workflows require:
- **Alfred 5.7+** with Powerpack license
- **macOS** for system command compatibility

## Workflow Structure

```
workflow-name/
├── info.plist          # Workflow configuration
├── README.md           # Workflow documentation
└── (additional files)  # Icons, scripts, etc.
```

## Development

### Building & Packaging
```bash
# Validate workflow plist
plutil -lint workflow-name/info.plist

# Create distributable package
zip -r workflow-name.alfredworkflow workflow-name/
```

### Best Practices
- Use the provided template for consistency
- Test workflows thoroughly before distribution
- Follow Alfred 5.7+ plist structure requirements
- Include proper error handling and user feedback

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