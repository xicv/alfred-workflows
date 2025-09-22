# Screenshot Capture Alfred Workflow

This is a properly formatted Alfred workflow for taking screenshots using keyword commands.

## Features

- **Keyword**: `sc`
- **Arguments**:
  - `fs` - Full screen screenshot (immediate, no interaction)
  - `w` - Window screenshot (interactive selection)
  - `s` - Selection screenshot (interactive area selection)
- **Output**: Screenshots saved to `~/Desktop` with filename copied to clipboard

## File Structure

```
Screenshot-Capture.alfredworkflow
└── info.plist
```

## What Was Wrong with Previous Attempts

The main issues that caused "The workflow you are trying to import is invalid or corrupted" errors were:

1. **XML Syntax Error**: The original plist file had a mismatched closing tag (`</string>` instead of `</key>` on line 110), which made the XML invalid.

2. **Missing Required Fields**: The workflow was missing some important fields that Alfred expects:
   - Proper XML structure validation
   - Correct plist formatting

3. **Directory Structure**: The workflow needs to be properly packaged as a zip file with the correct internal structure.

## Fixed Issues

1. **Fixed XML Syntax**: Corrected the mismatched closing tag in the plist file
2. **Validated Plist**: Used `plutil -lint` to verify the plist file is valid
3. **Proper Packaging**: Created a clean zip file with the correct structure
4. **Required Fields**: Ensured all required Alfred workflow fields are present:
   - `bundleid`
   - `name`
   - `createdby`
   - `description`
   - `objects` (workflow nodes)
   - `connections` (node connections)
   - `uidata` (layout information)

## Usage

1. Double-click `Screenshot-Capture.alfredworkflow` to import into Alfred
2. Use the following commands:
   - `sc fs` - Take full screen screenshot
   - `sc w` - Take window screenshot (click on desired window)
   - `sc s` - Take selection screenshot (drag to select area)

## How to Import

1. Open Alfred Preferences
2. Go to Workflows tab
3. Click the + button at the bottom
4. Select "Import..."
5. Choose the `Screenshot-Capture.alfredworkflow` file

## Technical Details

- **Bundle ID**: `com.alfredapp.screenshot.capture`
- **Alfred Version**: Compatible with Alfred 5.7
- **macOS Version**: Tested on macOS 10.15+
- **Script Type**: Bash
- **File Format**: Validated XML plist structure