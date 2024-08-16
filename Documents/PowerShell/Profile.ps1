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

# Set an alias for `config` to use the function
Set-Alias config Dotfiles-Config
