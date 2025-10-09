#!/bin/bash

# SSH Configuration Setup Script

echo "Setting up SSH configuration..."

# Create .ssh directory with correct permissions if it doesn't exist
if [ ! -d "$HOME/.ssh" ]; then
    echo "Creating ~/.ssh directory..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo "✓ Created ~/.ssh directory"
else
    echo "✓ ~/.ssh directory already exists"
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup existing SSH config if it exists
if [ -f "$HOME/.ssh/config" ]; then
    echo "⚠ Backing up existing SSH config to ~/.ssh/config.backup"
    cp "$HOME/.ssh/config" "$HOME/.ssh/config.backup"
fi

# Copy the SSH config template
echo "Copying SSH config template to ~/.ssh/config"
cp "$SCRIPT_DIR/config.template" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"
echo "✓ SSH config installed"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SSH Configuration Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo ""
echo "1. Edit ~/.ssh/config to customize for your needs"
echo ""
echo "2. For 1Password SSH agent integration:"
echo "   • Open 1Password > Settings > Developer"
echo "   • Enable 'Use the SSH agent'"
echo "   • Enable 'Display key names when authorizing connections'"
echo ""
echo "3. Generate SSH keys (if needed):"
echo "   ssh-keygen -t ed25519 -C 'your_email@example.com'"
echo ""
echo "4. Add your public key to GitHub/GitLab/etc:"
echo "   cat ~/.ssh/id_ed25519.pub | pbcopy"
echo ""
echo "5. Test your SSH connection:"
echo "   ssh -T git@github.com"
echo ""
