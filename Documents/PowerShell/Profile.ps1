# Define variables for the dotfiles directory and home directory
$DotfilesGitDir = "$HOME\.cfg"

# Function to alias the `config` command to use git with dotfiles repo
function Dotfiles-Config {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Args
    )

    # Construct the git command with the custom --git-dir and --work-tree
    git --git-dir=$DotfilesGitDir --work-tree=$HOME @Args
}

# Same, for Lazygit command
function Dotfiles-Config-Lazygit {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Args
    )

    # Construct the git command with the custom --git-dir and --work-tree
    lazygit --git-dir=$DotfilesGitDir --work-tree=$HOME @Args
}

# Set an alias for `config` to use the function
Set-Alias config Dotfiles-Config

# Change Komorebi config dir
# https://lgug2z.github.io/komorebi/common-workflows/komorebi-config-home.html
$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"

Set-Alias lazyconfig Dotfiles-Config-Lazygit

# Activate Starship (https://starship.rs/guide/#%F0%9F%9A%80-installation)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
