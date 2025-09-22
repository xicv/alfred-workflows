# Screenshot Capture Workflow

An Alfred workflow for capturing screenshots with various options and automatic naming.

## Features

- **Full Screen**: Capture entire screen
- **Window**: Capture specific window
- **Selection**: Capture selected area
- **Timed**: 5-second delayed capture
- **Clipboard**: Save directly to clipboard
- **Desktop**: Save to desktop with timestamp

## Usage

1. Trigger Alfred and type `shot`
2. Choose capture type:
   - `full` - Full screen screenshot
   - `window` - Active window screenshot
   - `selection` - Area selection screenshot
   - `timed` - 5-second delayed screenshot
   - `clipboard` - Save to clipboard only
   - `desktop` - Save to desktop

## Commands

| Command | Action | Output |
|---------|--------|---------|
| `full` | Capture entire screen | Desktop file |
| `window` | Capture active window | Desktop file |
| `selection` | Capture selected area | Desktop file |
| `timed` | 5-second delay capture | Desktop file |
| `clipboard` | Full screen to clipboard | Clipboard only |
| `desktop` | Full screen to desktop | Desktop file |

## Requirements

- Alfred 5.7+ with Powerpack
- macOS screen recording permissions
- Accessibility permissions for window capture

## Installation

1. Double-click `screenshot-capture.alfredworkflow`
2. Grant necessary permissions when prompted
3. Use `shot` keyword to trigger

## File Naming

Screenshots are saved with format: `Screenshot_YYYY-MM-DD_HH-MM-SS.png`

## Author

Created with Alfred Workflow Development Kit