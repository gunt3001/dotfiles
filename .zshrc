# Set shell unicode support
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set preferred editor to Neovim
export EDITOR='nvim'

# Set up dotfiles management system alias
# Run 'config' in place of 'git' command to manage
# Read more at: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Override default permissions for new files and folders
# Compatible with Synology NAS
umask 002

