#!/bin/bash

###############################################################################
# Master Installation Script for macOS Dotfiles
###############################################################################

# Color codes for output
RED='###########################################################################################
# 10. Setup SSH Config###############################################################################
# 11. Apply macOS System Settings
###############################################################################

print_section "Step 11: Applying macOS System Settings"on
###############################################################################

print_section "Step 10: Setting up SSH Configuration"##############################################################
# 9. Set##############################################################################################################
# 12. Final Steps
###############################################################################

print_section "Installation Complete!"###########################################
# 10. Apply macOS System Settings
###############################################################################

print_section "Step 10: Applying macOS System Settings"H Configuration
###############################################################################

print_section "Step 9: Setting up SSH Configuration"0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt user
prompt_user() {
    local prompt="$1"
    local default="${2:-y}"
    local response
    
    if [[ "$default" == "y" ]]; then
        read -p "$prompt [Y/n]: " response
        response=${response:-y}
    else
        read -p "$prompt [y/N]: " response
        response=${response:-n}
    fi
    
    [[ "$response" =~ ^[Yy]$ ]]
}

###############################################################################
# Main Installation Flow
###############################################################################

clear
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║                  macOS Dotfiles Installer                     ║
║                                                               ║
║         This script will set up your macOS environment        ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_info "Installation directory: $DOTFILES_DIR"
echo ""

if ! prompt_user "Do you want to continue with the installation?"; then
    print_info "Installation cancelled."
    exit 0
fi

###############################################################################
# 0. Install Xcode Command Line Tools
###############################################################################

print_section "Step 0: Installing Xcode Command Line Tools"

if xcode-select -p &> /dev/null; then
    print_success "Xcode Command Line Tools are already installed"
    xcode-select -p
else
    print_info "Installing Xcode Command Line Tools..."
    print_warning "This may take several minutes and will open a dialog box"
    
    # Trigger the installation
    xcode-select --install
    
    print_info "Please complete the installation in the dialog box that appeared"
    print_info "Press Enter when the installation is complete..."
    read
    
    # Verify installation
    if xcode-select -p &> /dev/null; then
        print_success "Xcode Command Line Tools installed successfully"
    else
        print_error "Xcode Command Line Tools installation failed or was cancelled"
        print_error "Please install them manually with: xcode-select --install"
        exit 1
    fi
fi

###############################################################################
# 1. Install Homebrew
###############################################################################

print_section "Step 1: Installing Homebrew"

if command_exists brew; then
    print_success "Homebrew is already installed"
    brew --version
else
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $? -eq 0 ]]; then
        print_success "Homebrew installed successfully"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        print_error "Failed to install Homebrew"
        exit 1
    fi
fi

###############################################################################
# 2. Install Homebrew Packages
###############################################################################

print_section "Step 2: Installing Homebrew Packages"

if prompt_user "Do you want to install Homebrew packages?"; then
    print_info "Installing Homebrew packages..."
    cd "$DOTFILES_DIR/homebrew"
    
    if [[ -f "install.sh" ]]; then
        bash install.sh
        if [[ $? -eq 0 ]]; then
            print_success "Homebrew packages installed successfully"
        else
            print_error "Failed to install some Homebrew packages"
        fi
    else
        print_error "install.sh not found in homebrew directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping Homebrew packages installation"
fi

###############################################################################
# 3. Install Homebrew Casks
###############################################################################

print_section "Step 3: Installing Homebrew Casks (Applications)"

if prompt_user "Do you want to install Homebrew casks (applications)?"; then
    print_info "Installing Homebrew casks..."
    cd "$DOTFILES_DIR/homebrew"
    
    if [[ -f "cask.sh" ]]; then
        bash cask.sh
        if [[ $? -eq 0 ]]; then
            print_success "Homebrew casks installed successfully"
        else
            print_warning "Some casks may have failed to install (this is normal)"
        fi
    else
        print_error "cask.sh not found in homebrew directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping Homebrew casks installation"
fi

###############################################################################
# 4. Install Mac App Store Apps
###############################################################################

print_section "Step 4: Installing Mac App Store Apps"

if command_exists mas; then
    if prompt_user "Do you want to install Mac App Store apps? (requires App Store login)"; then
        print_info "Installing Mac App Store apps..."
        cd "$DOTFILES_DIR/mac"
        
        if [[ -f "mas.sh" ]]; then
            bash mas.sh
            if [[ $? -eq 0 ]]; then
                print_success "Mac App Store apps installed successfully"
            else
                print_warning "Some apps may require manual installation from the App Store"
            fi
        else
            print_error "mas.sh not found in mac directory"
        fi
        
        cd "$DOTFILES_DIR"
    else
        print_warning "Skipping Mac App Store apps installation"
    fi
else
    print_warning "mas not installed. Skipping Mac App Store apps."
fi

###############################################################################
# 5. Setup iTerm2 and Zsh
###############################################################################

print_section "Step 5: Setting up iTerm2 and Zsh"

if prompt_user "Do you want to setup iTerm2 and Zsh?"; then
    print_info "Setting up iTerm2 and Zsh..."
    cd "$DOTFILES_DIR/iterm"
    
    if [[ -f "setup.sh" ]]; then
        bash setup.sh
        if [[ $? -eq 0 ]]; then
            print_success "iTerm2 and Zsh configured successfully"
        else
            print_warning "iTerm2 and Zsh setup completed with warnings"
        fi
    else
        print_error "setup.sh not found in iterm directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping iTerm2 and Zsh setup"
fi

###############################################################################
# 6. Setup Git Configuration
###############################################################################

print_section "Step 6: Setting up Git Configuration"

if prompt_user "Do you want to setup Git configuration?"; then
    print_info "Setting up Git configuration..."
    cd "$DOTFILES_DIR/git"
    
    if [[ -f "git.sh" ]]; then
        bash git.sh
        if [[ $? -eq 0 ]]; then
            print_success "Git configured successfully"
            print_warning "Remember to update your name and email in ~/.gitconfig"
        else
            print_error "Failed to setup Git configuration"
        fi
    else
        print_error "git.sh not found in git directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping Git configuration"
fi

###############################################################################
# 7. Copy EditorConfig
###############################################################################

print_section "Step 7: Setting up EditorConfig"

if [[ -f "$DOTFILES_DIR/.editorconfig" ]]; then
    print_info "Copying .editorconfig to home directory..."
    cp "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"
    print_success "EditorConfig installed at ~/.editorconfig"
else
    print_warning ".editorconfig not found in dotfiles directory"
fi

###############################################################################
# 8. Setup Starship Configuration
###############################################################################

print_section "Step 8: Setting up Starship Configuration"

if command_exists starship; then
    if prompt_user "Do you want to setup Starship prompt configuration?"; then
        print_info "Setting up Starship configuration..."
        cd "$DOTFILES_DIR/starship"
        
        if [[ -f "setup.sh" ]]; then
            bash setup.sh
            if [[ $? -eq 0 ]]; then
                print_success "Starship configured successfully"
            else
                print_warning "Starship setup completed with warnings"
            fi
        else
            print_error "setup.sh not found in starship directory"
        fi
        
        cd "$DOTFILES_DIR"
    else
        print_warning "Skipping Starship configuration"
    fi
else
    print_warning "Starship not installed. Install it via 'homebrew/install.sh' first."
fi

###############################################################################
# 9. Setup VS Code Configuration
###############################################################################

print_section "Step 9: Setting up VS Code Configuration"

if prompt_user "Do you want to setup SSH configuration?"; then
    print_info "Setting up SSH configuration..."
    cd "$DOTFILES_DIR/ssh"
    
    if [[ -f "setup.sh" ]]; then
        bash setup.sh
        if [[ $? -eq 0 ]]; then
            print_success "SSH configuration setup successfully"
            print_warning "Remember to customize ~/.ssh/config for your needs"
        else
            print_error "Failed to setup SSH configuration"
        fi
    else
        print_error "setup.sh not found in ssh directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping SSH configuration"
fi

###############################################################################
# 8. Apply macOS System Settings
###############################################################################

print_section "Step 8: Applying macOS System Settings"

print_warning "This will change various macOS system settings (Dock, Finder, Safari, etc.)"
if prompt_user "Do you want to apply macOS system settings?"; then
    print_info "Applying macOS system settings..."
    cd "$DOTFILES_DIR/mac"
    
    if [[ -f "setup.sh" ]]; then
        bash setup.sh
        if [[ $? -eq 0 ]]; then
            print_success "macOS system settings applied successfully"
        else
            print_error "Failed to apply some macOS settings"
        fi
    else
        print_error "setup.sh not found in mac directory"
    fi
    
    cd "$DOTFILES_DIR"
else
    print_warning "Skipping macOS system settings"
fi

###############################################################################
# 9. Final Steps
###############################################################################

print_section "Installation Complete!"

echo ""
print_success "Dotfiles installation completed!"
echo ""
print_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Update your Git credentials in ~/.gitconfig"
echo "  3. Sign in to the Mac App Store if you skipped that step"
echo "  4. Configure iTerm2 to use the Hybrid color scheme"
echo "  5. Run: ./doctor.sh to verify everything is working"
echo "  6. Consider restarting your Mac for all settings to take effect"
echo ""
print_info "Manual setup required:"
echo "  • Enable trackpad dragging: System Settings > Accessibility > Pointer Control"
echo "    > Mouse & Trackpad > Trackpad Options… > Enable dragging"
echo ""

if prompt_user "Would you like to restart your Mac now?"; then
    print_info "Restarting in 5 seconds... (Press Ctrl+C to cancel)"
    sleep 5
    sudo shutdown -r now
else
    print_info "Remember to restart your Mac later for all changes to take effect."
fi

echo ""
print_success "Enjoy your new setup! 🚀"
echo ""
