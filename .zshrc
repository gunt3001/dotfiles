# Set shell unicode support
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set preferred editor to Neovim
export EDITOR='nvim'

# Set up dotfiles management system alias
# Run 'config' in place of 'git' command to manage
# Read more at: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lazyconfig='/usr/local/bin/lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Other aliases
alias l='ls -lah --color'
alias ..='cd ..'

# Override default permissions for new files and folders
# Compatible with Synology NAS
umask 002

# Configure Starship.rs prompt
# https://starship.rs/guide/
eval "$(starship init zsh)"

# Enable command history via arrow keys
HISTFILE=~/.local/state/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
# Don't save and find duplicates
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# History is shared between instances immediately (effective after new prompts)
setopt SHARE_HISTORY

# Enable case insensitive autocomplete and middle-of-word completion
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

