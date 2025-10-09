#!/bin/bash

###############################################################################
# Backup Script for macOS Dotfiles
# Creates backups of all current configurations before applying new ones
###############################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup directory with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/.dotfiles_backup_$TIMESTAMP"

echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║                  Dotfiles Backup Script                       ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${BLUE}Creating backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Function to backup file or directory
backup_item() {
    local source="$1"
    local name="$2"
    
    if [ -e "$source" ]; then
        echo -e "${YELLOW}Backing up: $name${NC}"
        cp -R "$source" "$BACKUP_DIR/$name"
        echo -e "${GREEN}✓ Backed up: $name${NC}"
        return 0
    else
        echo -e "${BLUE}ℹ Skipped (not found): $name${NC}"
        return 1
    fi
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Backing up configurations..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

BACKED_UP=0

# Zsh configurations
backup_item "$HOME/.zshrc" "zshrc" && ((BACKED_UP++))
backup_item "$HOME/.zshenv" "zshenv" && ((BACKED_UP++))
backup_item "$HOME/.aliases" "aliases" && ((BACKED_UP++))

# Git configurations
backup_item "$HOME/.gitconfig" "gitconfig" && ((BACKED_UP++))
backup_item "$HOME/.gitignore_global" "gitignore_global" && ((BACKED_UP++))

# SSH configurations
backup_item "$HOME/.ssh/config" "ssh_config" && ((BACKED_UP++))

# VS Code configurations
backup_item "$HOME/Library/Application Support/Code/User/settings.json" "vscode_settings.json" && ((BACKED_UP++))
backup_item "$HOME/Library/Application Support/Code/User/keybindings.json" "vscode_keybindings.json" && ((BACKED_UP++))

# Starship configuration
backup_item "$HOME/.config/starship.toml" "starship.toml" && ((BACKED_UP++))

# Homebrew (list of installed packages)
if command -v brew &> /dev/null; then
    echo -e "${YELLOW}Backing up: Homebrew packages list${NC}"
    brew list --formula > "$BACKUP_DIR/brew_packages.txt"
    brew list --cask > "$BACKUP_DIR/brew_casks.txt"
    echo -e "${GREEN}✓ Backed up: Homebrew packages${NC}"
    ((BACKED_UP+=2))
fi

# VS Code extensions list
if command -v code &> /dev/null; then
    echo -e "${YELLOW}Backing up: VS Code extensions list${NC}"
    code --list-extensions > "$BACKUP_DIR/vscode_extensions.txt"
    echo -e "${GREEN}✓ Backed up: VS Code extensions${NC}"
    ((BACKED_UP++))
fi

# Oh My Zsh custom plugins/themes
if [ -d "$HOME/.oh-my-zsh/custom" ]; then
    backup_item "$HOME/.oh-my-zsh/custom" "oh-my-zsh-custom" && ((BACKED_UP++))
fi

# NPM global packages
if command -v npm &> /dev/null; then
    echo -e "${YELLOW}Backing up: NPM global packages list${NC}"
    npm list -g --depth=0 > "$BACKUP_DIR/npm_global_packages.txt" 2>/dev/null
    echo -e "${GREEN}✓ Backed up: NPM packages${NC}"
    ((BACKED_UP++))
fi

# Create a manifest file
cat > "$BACKUP_DIR/MANIFEST.txt" << EOF
Dotfiles Backup Manifest
========================

Backup Date: $(date)
Backup Location: $BACKUP_DIR
Items Backed Up: $BACKED_UP

System Information:
- macOS Version: $(sw_vers -productVersion)
- Hostname: $(hostname)
- User: $(whoami)

Backed up configurations:
$(ls -1 "$BACKUP_DIR")
EOF

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}Backup Complete!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${GREEN}✓ Backed up $BACKED_UP items${NC}"
echo -e "${BLUE}📁 Backup location: $BACKUP_DIR${NC}"
echo ""
echo "To restore from this backup:"
echo "  cd $BACKUP_DIR"
echo "  cp <file> ~/<destination>"
echo ""
echo "To compress this backup:"
echo "  tar -czf dotfiles_backup_$TIMESTAMP.tar.gz -C $(dirname "$BACKUP_DIR") $(basename "$BACKUP_DIR")"
echo ""
