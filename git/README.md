# Git Configuration

Enhanced Git configuration with productivity shortcuts and modern best practices.

## 🚀 Features

### Modern Git Defaults
- **Pull strategy**: Rebase instead of merge (cleaner history)
- **Auto-prune**: Automatically remove deleted remote branches
- **Better diff algorithm**: Histogram algorithm for more readable diffs
- **Conflict style**: zdiff3 shows common ancestor in merge conflicts
- **Auto-stash**: Automatically stash changes before rebase/pull

### Performance Improvements
- **Untracked cache**: Faster status checks
- **FSMonitor**: Better performance on large repositories
- **Autocorrect**: Fixes typos automatically after 2 seconds

### Enhanced Aliases

#### Viewing History
```bash
git ll           # Compact one-line log with decorations
git lg           # Graph view of all branches
git dog          # Your existing beautiful log format
git hist         # Detailed history with dates
git last         # Show last commit with stats
git today        # Show your commits from today
```

#### Smart Workflow
```bash
git sw           # Switch branches (modern alternative to checkout)
git swc <name>   # Create and switch to new branch
git oops         # Amend last commit without editing message
git uncommit     # Undo last commit but keep changes
git unstage      # Remove files from staging
git discard      # Discard local changes
git wipe         # Create emergency savepoint before hard reset
```

#### Branch Management
```bash
git branches     # Show all branches (local and remote)
git recent       # Show branches sorted by last commit date
git gone         # Delete local branches that were deleted on remote
git publish      # Push current branch and set upstream
git unpublish    # Delete current branch from remote
```

#### Better Diffs
```bash
git dc           # Diff cached/staged changes
git ds           # Diff staged (same as dc)
git dw           # Word-by-word diff
```

#### Stash Operations
```bash
git ss           # Stash save
git sp           # Stash pop
git sl           # Stash list
git sshow [n]    # Show stash contents (default: most recent)
```

#### Finding Things
```bash
git find <text>          # Find commits that added/removed text
git findmsg <text>       # Find commits by message
git aliases              # Show all your git aliases
git contributors         # Show contributors with email
git ranked               # Show commit counts by author
```

### Push/Pull Behavior
- **Auto-setup remote**: Automatically create remote branch on first push
- **Follow tags**: Push tags with commits
- **Current push**: Push current branch to same-named remote branch
- **Auto-stash on pull**: Stash uncommitted changes before pulling

### Merge & Rebase
- **Auto-squash**: Automatically squash commits marked with `fixup!` or `squash!`
- **Better conflict resolution**: Shows 3-way diff (base, ours, theirs)
- **Auto-stash**: Stash changes before rebase, unstash after

## 🎨 Color Configuration

Your existing beautiful color scheme is preserved:
- **Branches**: Yellow (current), Green (local), Cyan (remote)
- **Diffs**: Yellow (meta), Magenta (hunk), Red (old), Green (new)
- **Status**: Green (added), Yellow (changed), Red (untracked)

## 🔧 Optional Features

### GPG Signing
To sign your commits with GPG, uncomment in `gitconfig`:
```ini
[user]
    signingkey = YOUR_GPG_KEY_ID
[commit]
    gpgsign = true
```

Then set up GPG:
```bash
# Generate key
gpg --full-generate-key

# List keys
gpg --list-secret-keys --keyid-format=long

# Add to GitHub/GitLab
gpg --armor --export YOUR_KEY_ID | pbcopy
```

### VS Code as Editor
To use VS Code instead of vim, uncomment in `gitconfig`:
```ini
[core]
    editor = code --wait
```

## 📝 Global Gitignore

Enhanced `.gitignore_global` now includes:
- **IDE files**: VS Code, IntelliJ, Sublime Text
- **Node.js**: node_modules, logs, cache
- **Python**: __pycache__, venv, .env
- **Build outputs**: dist, build, coverage
- **OS files**: .DS_Store, Thumbs.db
- **Environment files**: .env, .env.local

## 💡 Usage Examples

### Daily Workflow
```bash
# Start new feature
git swc feature/new-thing

# Make commits
git cm "Add feature"
git cm "Fix typo"

# Oops, forgot something
git oops

# Push to remote
git publish

# See what you did today
git today

# Update from master
git sw master
git pl
```

### Branch Cleanup
```bash
# See all branches by recent activity
git recent

# Remove local branches that were merged/deleted remotely
git gone
```

### Finding Issues
```bash
# Find when a bug was introduced
git find "buggy_function"

# See who worked on a file
git contributors

# Check commit history for a message
git findmsg "fix api"
```

### Emergency Recovery
```bash
# Create a savepoint before risky operation
git wipe

# Made a mistake? Undo last commit
git uncommit

# Want to start over?
git reset --hard HEAD
```

## 🔄 Updating Configuration

To update your git config:
```bash
cd ~/dotfiles/git
./git.sh
```

Or manually:
```bash
cp ~/dotfiles/git/gitconfig ~/.gitconfig
cp ~/dotfiles/git/gitignore_global ~/.gitignore_global
```

## 📚 Learn More

- [Git Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book/en/v2)
- [Git Aliases Guide](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases)
