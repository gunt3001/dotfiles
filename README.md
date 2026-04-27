# 🏠 Dotfiles Management with Chezmoi

This repository contains my personal configuration files managed by [chezmoi](https://www.chezmoi.io/).

---

## 🚀 Quick Start

### 1. Install Chezmoi
Install the binary via your preferred package manager:

* **macOS/Linux:** `brew install chezmoi`
* **Windows:** `winget install twpayne.chezmoi`
* **Linux (curl):** `sh -c "$(curl -fsLS get.chezmoi.io)"`

### 2. Initialize on a New Machine
To pull this repo and apply the configurations to your home directory:

```bash
# Replace YOUR_USERNAME with your GitHub handle
chezmoi init --apply [https://github.com/gunt3001/dotfiles.git](https://github.com/gunt3001/dotfiles.git)
```

---

## 🛠️ Daily Workflow

### Managing Files
| Action | Command |
| :--- | :--- |
| **Add a new file** | `chezmoi add ~/.zshrc` |
| **Edit a tracked file** | `chezmoi edit ~/.zshrc` |
| **See pending changes** | `chezmoi diff` |
| **Apply changes to disk** | `chezmoi apply -v` |

### Syncing with Git
Chezmoi manages a "source state" in a hidden directory. To push your changes:

```bash
# Open a shell in the source directory
chezmoi cd

# Standard git workflow
git add .
git commit -m "Update config"
git push
```

### Updating from the Repo
To pull the latest changes from GitHub and apply them:

```bash
chezmoi update
```

---

## 📝 Key Features
* **Scripts:** Files prefixed with `run_` (e.g., `run_onchange_install.sh`) execute automatically when changed.
* **Templates:** Files ending in `.tmpl` allow for machine-specific logic and variables.
* **Ignore:** Use `.chezmoiignore` to prevent specific files from being applied to certain machines.

> [!TIP]
> Always run `chezmoi diff` before `chezmoi apply` to verify what changes will be written to your home directory.