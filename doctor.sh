#!/bin/bash

###############################################################################
# Doctor Script - Verify Dotfiles Installation
# Checks if all tools and configurations are properly installed
###############################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║              Dotfiles Health Check (Doctor)                   ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Function to check if command exists
check_command() {
    local cmd="$1"
    local name="$2"
    local required="${3:-true}"
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n 1 | cut -d' ' -f1-3 || echo "unknown")
        echo -e "${GREEN}✓${NC} $name: ${BLUE}$version${NC}"
        ((PASSED++))
        return 0
    else
        if [ "$required" = "true" ]; then
            echo -e "${RED}✗${NC} $name: ${RED}not found${NC}"
            ((FAILED++))
        else
            echo -e "${YELLOW}⚠${NC} $name: ${YELLOW}not installed (optional)${NC}"
            ((WARNINGS++))
        fi
        return 1
    fi
}

# Function to check if file exists
check_file() {
    local file="$1"
    local name="$2"
    local required="${3:-true}"
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $name: ${BLUE}$file${NC}"
        ((PASSED++))
        return 0
    else
        if [ "$required" = "true" ]; then
            echo -e "${RED}✗${NC} $name: ${RED}not found${NC}"
            ((FAILED++))
        else
            echo -e "${YELLOW}⚠${NC} $name: ${YELLOW}not found (optional)${NC}"
            ((WARNINGS++))
        fi
        return 1
    fi
}

# Function to check directory
check_directory() {
    local dir="$1"
    local name="$2"
    local required="${3:-true}"
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $name: ${BLUE}$dir${NC}"
        ((PASSED++))
        return 0
    else
        if [ "$required" = "true" ]; then
            echo -e "${RED}✗${NC} $name: ${RED}not found${NC}"
            ((FAILED++))
        else
            echo -e "${YELLOW}⚠${NC} $name: ${YELLOW}not found (optional)${NC}"
            ((WARNINGS++))
        fi
        return 1
    fi
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Core Development Tools..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_command "xcode-select" "Xcode Command Line Tools"
check_command "brew" "Homebrew"
check_command "git" "Git"
check_command "zsh" "Zsh"
check_command "code" "VS Code CLI"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking CLI Tools..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_command "bat" "bat (cat replacement)"
check_command "eza" "eza (ls replacement)"
check_command "fd" "fd (find replacement)"
check_command "rg" "ripgrep (grep replacement)"
check_command "fzf" "fzf (fuzzy finder)"
check_command "jq" "jq (JSON processor)"
check_command "starship" "Starship prompt"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Node.js Environment..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_command "nvm" "NVM (Node Version Manager)"
check_command "node" "Node.js"
check_command "npm" "npm"
check_command "pnpm" "pnpm"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Configuration Files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_file "$HOME/.zshrc" "Zsh config"
check_file "$HOME/.gitconfig" "Git config"
check_file "$HOME/.gitignore_global" "Global gitignore"
check_file "$HOME/.ssh/config" "SSH config"
check_file "$HOME/.config/starship.toml" "Starship config"
check_file "$HOME/Library/Application Support/Code/User/settings.json" "VS Code settings"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Oh My Zsh..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_directory "$HOME/.oh-my-zsh" "Oh My Zsh"
check_directory "/opt/homebrew/share/zsh-syntax-highlighting" "zsh-syntax-highlighting"
check_directory "/opt/homebrew/share/zsh-autosuggestions" "zsh-autosuggestions"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Optional Tools..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_command "docker" "Docker" "false"
check_command "mas" "Mac App Store CLI" "false"
check_command "autojump" "Autojump" "false"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Git Configuration..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if git config user.name &> /dev/null; then
    echo -e "${GREEN}✓${NC} Git user.name: ${BLUE}$(git config user.name)${NC}"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Git user.name: ${YELLOW}not configured${NC}"
    ((WARNINGS++))
fi

if git config user.email &> /dev/null; then
    echo -e "${GREEN}✓${NC} Git user.email: ${BLUE}$(git config user.email)${NC}"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Git user.email: ${YELLOW}not configured${NC}"
    ((WARNINGS++))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking VS Code Extensions..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if command -v code &> /dev/null; then
    EXTENSIONS_COUNT=$(code --list-extensions | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${NC} VS Code extensions installed: ${BLUE}$EXTENSIONS_COUNT${NC}"
    ((PASSED++))
    
    # Check for essential extensions
    ESSENTIAL=("esbenp.prettier-vscode" "dbaeumer.vscode-eslint" "eamodio.gitlens" "github.copilot")
    for ext in "${ESSENTIAL[@]}"; do
        if code --list-extensions | grep -q "$ext"; then
            echo -e "${GREEN}  ✓${NC} $ext"
        else
            echo -e "${YELLOW}  ⚠${NC} $ext ${YELLOW}(not installed)${NC}"
            ((WARNINGS++))
        fi
    done
else
    echo -e "${RED}✗${NC} VS Code CLI not available"
    ((FAILED++))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "System Information"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo -e "${BLUE}macOS Version:${NC} $(sw_vers -productVersion)"
echo -e "${BLUE}Hostname:${NC} $(hostname)"
echo -e "${BLUE}Shell:${NC} $SHELL"
echo -e "${BLUE}Terminal:${NC} $TERM_PROGRAM"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Health Check Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

TOTAL=$((PASSED + FAILED + WARNINGS))
echo -e "${GREEN}✓ Passed:${NC} $PASSED"
echo -e "${YELLOW}⚠ Warnings:${NC} $WARNINGS"
echo -e "${RED}✗ Failed:${NC} $FAILED"
echo -e "${BLUE}Total Checks:${NC} $TOTAL"
echo ""

if [ $FAILED -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 Perfect! Everything is installed and configured!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 0
elif [ $FAILED -eq 0 ]; then
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}⚠ Good! Some optional items are missing but core is OK.${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}❌ Issues found! Please review the failed checks above.${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "To fix issues, run: ./install.sh"
    echo ""
    exit 1
fi
