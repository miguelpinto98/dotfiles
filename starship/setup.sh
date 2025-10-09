#!/bin/bash

# Starship Configuration Setup Script

echo "Setting up Starship configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create ~/.config directory if it doesn't exist
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config directory..."
    mkdir -p "$HOME/.config"
fi

# Backup existing Starship config if it exists
if [ -f "$HOME/.config/starship.toml" ]; then
    echo "⚠ Backing up existing starship.toml to starship.toml.backup"
    cp "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup"
fi

# Copy Starship config
echo "Copying Starship configuration..."
cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
echo "✓ Starship configured"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Starship Configuration Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "What was configured:"
echo "  • Minimal, fast prompt"
echo "  • Git status indicators"
echo "  • Node.js version display"
echo "  • Command duration"
echo "  • Directory truncation"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Customize: ~/.config/starship.toml"
echo ""
