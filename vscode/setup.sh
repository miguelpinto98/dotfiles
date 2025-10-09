#!/bin/bash

# VS Code Configuration Setup Script

echo "Setting up VS Code configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# VS Code settings directory
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

# Create VS Code settings directory if it doesn't exist
if [ ! -d "$VSCODE_DIR" ]; then
    echo "Creating VS Code settings directory..."
    mkdir -p "$VSCODE_DIR"
fi

# Backup existing settings
if [ -f "$VSCODE_DIR/settings.json" ]; then
    echo "⚠ Backing up existing settings.json to settings.json.backup"
    cp "$VSCODE_DIR/settings.json" "$VSCODE_DIR/settings.json.backup"
fi

if [ -f "$VSCODE_DIR/keybindings.json" ]; then
    echo "⚠ Backing up existing keybindings.json to keybindings.json.backup"
    cp "$VSCODE_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json.backup"
fi

# Copy settings
echo "Copying VS Code settings..."
cp "$SCRIPT_DIR/settings.json" "$VSCODE_DIR/settings.json"
echo "✓ Settings installed"

# Copy keybindings
echo "Copying VS Code keybindings..."
cp "$SCRIPT_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json"
echo "✓ Keybindings installed"

# Install extensions
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Installing VS Code Extensions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if code command is available
if ! command -v code &> /dev/null; then
    echo "⚠ 'code' command not found in PATH"
    echo ""
    echo "To install the 'code' command:"
    echo "  1. Open VS Code"
    echo "  2. Press Cmd+Shift+P"
    echo "  3. Type 'shell command'"
    echo "  4. Select 'Shell Command: Install 'code' command in PATH'"
    echo ""
    echo "After installing, run this script again to install extensions."
else
    echo "Installing extensions from extensions.txt..."
    echo ""
    
    # Read extensions and install them
    while IFS= read -r extension || [ -n "$extension" ]; do
        # Skip empty lines and comments
        if [[ -z "$extension" || "$extension" =~ ^#.* ]]; then
            continue
        fi
        
        echo "Installing: $extension"
        code --install-extension "$extension" --force
    done < "$SCRIPT_DIR/extensions.txt"
    
    echo ""
    echo "✓ All extensions installed"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "VS Code Configuration Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "What was configured:"
echo "  • Settings (font, editor, formatting, language-specific)"
echo "  • Keybindings (shortcuts and custom keymaps)"
echo "  • Extensions (lean, essential-only setup)"
echo ""
echo "Next steps:"
echo "  1. Restart VS Code for changes to take effect"
echo "  2. Sign in to GitHub for Copilot"
echo ""
