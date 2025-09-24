#!/bin/bash

# Quick Setup Script for Optimized Development Workflow

echo "🚀 Setting up Optimized Development Workflow"
echo "=============================================="

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_DIR="$SCRIPT_DIR"

echo "📁 Installing from: $WORKFLOW_DIR"

# Create necessary directories
echo "📂 Creating directories..."
mkdir -p ~/Desktop/dev-logs
mkdir -p ~/Desktop/dev-screenshots
mkdir -p ~/Desktop/dev-monitor
mkdir -p ~/Desktop/dev-scripts

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x "$WORKFLOW_DIR/scripts/"*.sh

# Copy scripts to dev-scripts directory
echo "📋 Installing scripts..."
cp "$WORKFLOW_DIR/scripts/"*.sh ~/Desktop/dev-scripts/

# Open Alfred workflows for installation
echo "🎯 Opening Alfred workflows for installation..."
open "$WORKFLOW_DIR/error-logger.alfredworkflow"
open "$WORKFLOW_DIR/screenshot-dev.alfredworkflow"
open "$WORKFLOW_DIR/chrome-monitor.alfredworkflow"

# Create symlink for scripts (optional)
if [ ! -L "/usr/local/bin/dev-workflow" ]; then
    echo "🔗 Creating command line tools..."
    sudo ln -sf "$WORKFLOW_DIR/scripts/dev-integration.sh" /usr/local/bin/dev-workflow
    sudo ln -sf "$WORKFLOW_DIR/scripts/auto-debug.sh" /usr/local/bin/auto-debug
fi

# Test Claude Code availability
if command -v claude &> /dev/null; then
    echo "✅ Claude Code found and ready"
else
    echo "⚠️  Claude Code not found. Please install Claude Code from Anthropic"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📖 Next steps:"
echo "1. Import the Alfred workflows (they should be opening now)"
echo "2. Import the snippets from: $WORKFLOW_DIR/snippets/claude-snippets.txt"
echo "3. Test the workflows with: err test, devsc test, chrome test"
echo ""
echo "🚀 Quick start commands:"
echo "   err [description]          - Log development error"
echo "   devsc [type]              - Take development screenshot"
echo "   chrome [type]             - Monitor Chrome DevTools"
echo "   auto-debug quick [issue]  - Quick debug cycle"
echo "   dev-workflow setup        - Setup development environment"
echo ""
echo "📚 Documentation available at: $WORKFLOW_DIR/README.md"
echo ""
echo "Happy coding! 🎉"