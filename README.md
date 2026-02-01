# Dotfiles

## Setup

```sh
git clone --bare <repo-url> $HOME/.cfg
git --git-dir=$HOME/.cfg --work-tree=$HOME checkout
```

A bare repo alias (`config` and `lazyconfig` by default) is already configured in the included `.zshrc`.
