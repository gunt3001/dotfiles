# Set shell unicode support
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set preferred editor to Neovim
export EDITOR='nvim'

# Add extra PATH dirs
path+=(~/.local/bin)
path+=(/opt/homebrew/bin)
path+=(/usr/local/bin)
export PATH

# Set up dotfiles management system alias
# Run 'config' in place of 'git' command to manage
# Read more at: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lazyconfig='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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
mkdir -p ~/.local/state/zsh
HISTFILE=~/.local/state/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
# Don't save and find duplicates
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# History is shared between instances immediately (effective after new prompts)
# setopt SHARE_HISTORY

# Enable case insensitive autocomplete and middle-of-word completion
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Install fzf https://github.com/junegunn/fzf
if [ ! -d "${HOME}/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --xdg --no-update-rc
fi

# Install zoxide https://github.com/ajeetdsouza/zoxide
if [ ! -f "${HOME}/.local/bin/zoxide" ]; then
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# zinit Plugin Manager - auto-install, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# Disable default alises like zi because it conflicts with Zoxide
declare -A ZINIT
ZINIT[NO_ALIASES]=1
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Add in zsh plugins
zinit light Aloxaf/fzf-tab # Use fzf for general auto-completions. Needs to be before zsh-autosuggestions, but after compinit
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions # Command details pop-up
zinit light zsh-users/zsh-autosuggestions # General autocompletion for paths, commands from history

# Plugin configurations
# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# preview sub-directory
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# pop-up style suggestions when using tmux
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Shell integrations
source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh # fzf - default hotkey C-r
eval "$(zoxide init zsh)"

# fnm
FNM_PATH="/opt/homebrew/bin/fnm"
if [ -f "$FNM_PATH" ]; then
  eval "`fnm env --use-on-cd --shell zsh`"
fi
