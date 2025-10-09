# My macOS Dotfiles

Complete macOS development environment setup with automated installation.

## 🚀 Quick Start

Clone this repository and run the master installation script:

```bash
git clone https://github.com/miguelpinto98/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installation script will guide you through:
0. ✅ Xcode Command Line Tools (required for development)
1. ✅ Homebrew installation
2. ✅ Homebrew packages (dev tools, CLI utilities)
3. ✅ Homebrew casks (applications)
4. ✅ Mac App Store apps (via `mas`)
5. ✅ iTerm2 and Zsh configuration (with Oh My Zsh, Starship)
6. ✅ Git configuration (enhanced aliases, modern workflow)
7. ✅ Starship prompt (customized, fast, minimal)
8. ✅ VS Code settings and extensions (lean 2025 setup)
9. ✅ SSH configuration (with 1Password integration)
10. ✅ macOS system settings (Dock, Finder, Safari, etc.)

The script is interactive and will prompt you before each step.

## 📦 What's Included

### Development Tools
- **Languages & Runtimes**: Node.js (via nvm), Python
- **Version Control**: Git with custom aliases and diff-so-fancy
- **Package Managers**: pnpm, npm
- **CLI Tools**: bat, eza, fzf, ripgrep, fd, jq, yq, httpie, tldr

### Applications
- **Browsers**: Arc, Brave
- **Development**: VS Code, iTerm2, Docker, Insomnia, DevToys, Figma
- **Productivity**: Raycast, Rectangle, 1Password, Slack
- **Utilities**: AppCleaner, Stats, ImageOptim, The Unarchiver
- **Media**: Spotify, VLC, Stremio

### Shell Configuration
- **Oh My Zsh** with plugins (git, docker, npm, pnpm, completions, autosuggestions, syntax highlighting)
- **Starship** prompt
- **Modern CLI aliases** (cat→bat, ls→eza, find→fd, grep→rg)
- **Autojump** for quick navigation
- **Custom aliases** for pnpm, docker compose, and utilities

## 🔧 Manual Installation (Advanced)

If you prefer to run scripts individually:

```bash
# 1. Install Homebrew packages
./homebrew/install.sh

# 2. Install applications
./homebrew/cask.sh

# 3. Install Mac App Store apps
./mac/mas.sh

# 4. Setup iTerm2 and Zsh
./iterm/setup.sh

# 5. Setup Git configuration
./git/git.sh

# 6. Setup Starship prompt
./starship/setup.sh

# 7. Apply macOS settings
./mac/setup.sh

# 8. Setup VS Code
./vscode/setup.sh

# 9. Setup SSH configuration
./ssh/setup.sh
```

## 🛠️ Maintenance Scripts

### Backup Your Current Setup
```bash
./backup.sh
```
Creates a timestamped backup of all your current configurations before making changes.

### Verify Installation
```bash
./doctor.sh
```
Comprehensive health check of your development environment. Verifies:
- All required tools are installed
- Configuration files exist
- VS Code extensions are present
- Git is configured
- System information

### Clean Up VS Code Extensions
```bash
./vscode/cleanup.sh
```
Removes extensions not in your curated list, keeping VS Code lean.

## ⚙️ Manual Setup Required

### Enable Trackpad Dragging
```
System Settings > Accessibility > Pointer Control > Mouse & Trackpad > 
Trackpad Options… > Enable dragging
```

### Update Git Credentials
Edit `~/.gitconfig` to update your name and email:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 📝 Customization

### Modify Installation
Edit the respective files before running:
- `homebrew/install.sh` - Add/remove CLI tools
- `homebrew/cask.sh` - Add/remove applications
- `mac/mas.sh` - Add/remove App Store apps
- `mac/setup.sh` - Customize macOS settings
- `iterm/aliases` - Add custom shell aliases
- `git/gitconfig` - Customize git configuration
- `ssh/config.template` - Customize SSH settings (safe for public repos)

## 🔄 Updates

To update your dotfiles after making changes:

```bash
cd ~/dotfiles
git pull
./install.sh
```

## 📚 What Gets Configured

### macOS System Settings
- **Finder**: Show hidden files, extensions, path bar, list view by default
- **Dock**: Auto-hide with faster animation, positioned on right, smaller icons
- **Keyboard**: Faster repeat rate, disable auto-correct/capitalization
- **Trackpad**: Tap to click enabled
- **Safari**: Developer tools enabled, privacy-focused settings
- **Screenshots**: PNG format, no shadow, removed from desktop

### Git Configuration
Custom aliases for common operations:
- `git dog` - Beautiful commit log graph
- `git oops` - Amend last commit without editing message
- And many more shortcuts

## 🛟 Troubleshooting

- **Xcode Command Line Tools**: The script will install these automatically if missing
- **Homebrew installation fails**: Ensure you completed the Xcode Command Line Tools installation
- **Permission errors**: Some operations may require administrator password
- **Apps fail to install**: Check your internet connection and App Store login
- **Settings don't apply**: Restart your Mac or run `killall Dock Finder SystemUIServer`

## 📄 License

MIT License - Feel free to use and modify as needed!
