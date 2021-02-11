#!/usr/bin/env python3

import subprocess
import os
import urllib.request

# TODO: Installation flags and interactive mode

HOMEDIR = "/home/gun"
DOTFILES_REPO_URL = "https://github.com/gunt3001/dotfiles.git"
DOTFILES_GIT_DIR = os.path.join(HOMEDIR, ".cfg")
ONEDRIVE_SOURCE_MOUNT_DIR = "/mnt/user/Home/OneDrive"
ONEDRIVE_DEST_MOUNT_DIR = os.path.join(HOMEDIR, "OneDrive")
OHMYZSH_INSTALL_DIR = os.path.join(HOMEDIR, ".oh-my-zsh")

# Install oh-my-zsh
subprocess.run(["git", "clone", "https://github.com/ohmyzsh/ohmyzsh.git",
                OHMYZSH_INSTALL_DIR], check=True)
subprocess.run(["chsh", "--shell", "/usr/bin/zsh", "gun"])

# Install youtube-dl
urllib.request.urlretrieve("https://yt-dl.org/downloads/latest/youtube-dl", "/usr/local/bin/youtube-dl")
os.chmod("/usr/local/bin/youtube-dl", 0o755)

# Setup dotfiles
# Set up dotfiles management system outlined in this tutorial
# https://www.atlassian.com/git/tutorials/dotfiles
subprocess.run(["git", "clone", "--bare", DOTFILES_REPO_URL,
                DOTFILES_GIT_DIR], check=True)
subprocess.run(["git", "--git-dir="+DOTFILES_GIT_DIR, "--work-tree="+HOMEDIR,
                "checkout"], check=True)

# Symlink to OneDrive mount to home directory, if exists
if os.path.isdir(ONEDRIVE_SOURCE_MOUNT_DIR) and not os.path.isdir(ONEDRIVE_DEST_MOUNT_DIR):
    os.symlink(ONEDRIVE_SOURCE_MOUNT_DIR,
               ONEDRIVE_DEST_MOUNT_DIR,
               target_is_directory=True)

# [Finalize] Reset ownership in home dir
subprocess.run(["chown", "-R", "gun:gun", HOMEDIR], check=True)
