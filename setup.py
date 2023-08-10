#!/usr/bin/env python3

import subprocess
import os
import urllib.request
import tarfile
import sys
import json

HOMEDIR = "/home/gun"
DOTFILES_REPO_URL = "https://github.com/gunt3001/dotfiles.git"
DOTFILES_GIT_DIR = os.path.join(HOMEDIR, ".cfg")
ONEDRIVE_SOURCE_MOUNT_DIR = "/mnt/user/Home/OneDrive"
ONEDRIVE_DEST_MOUNT_DIR = os.path.join(HOMEDIR, "OneDrive")
OHMYZSH_INSTALL_DIR = os.path.join(HOMEDIR, ".oh-my-zsh")
UNIX_USERNAME_GROUP = "gun:gun"
UNIX_UID_GID = "1026:100"

install_flags = {}

def main(is_interactive = False):
    print ("===== Starting personal setup script... =====")
    print ("Note: Home dir is fixed at /home/gun/")
    print ("Note: Run as root if installing programs!")

    if is_interactive:
        install_flags["oh-my-zsh"] = ask_option("Oh-My-Zsh")
        install_flags["yt-dlp"] = ask_option("yt-dlp (install or update)")
        install_flags["lf"] = ask_option("lf file manager (install or update)")
        install_flags["dotfiles"] = ask_option("Dotfiles")
        install_flags["onedrive-symlink"] = ask_option("OneDrive symlink to home dir")
        install_flags["sakura"] = ask_option("Sakura downloader")
        answer = input("Proceed? (y/n): ").lower()
        if answer != "y":
            return

    if not is_interactive or install_flags["oh-my-zsh"]:
        print("Setting up Oh-My-Zsh")
        install_oh_my_zsh()
    if not is_interactive or install_flags["yt-dlp"]:
        print("Setting up yt-dlp (install or update)")
        install_yt_dlp()
    if not is_interactive or install_flags["lf"]:
        print("Setting up lf file manager (install or update)")
        install_lf()
    if not is_interactive or install_flags["dotfiles"]:
        print("Setting up Dotfiles")
        setup_dotfiles()
    if not is_interactive or install_flags["onedrive-symlink"]:
        print("Setting up OneDrive symlink to home dir")
        setup_onedrive_symlink()
    if not is_interactive or install_flags["sakura"]:
        print("Setting up Sakura downloader")
        install_sakura()

    # [Finalize] Reset ownership in home dir
    # If not interactive, assume UNRAID group
    if is_interactive:
        subprocess.run(["chown", "-R", UNIX_USERNAME_GROUP, HOMEDIR], check=True)
    else:
        subprocess.run(["chown", "-R", UNIX_UID_GID, HOMEDIR], check=True)

def install_oh_my_zsh():
    if not os.path.isdir(OHMYZSH_INSTALL_DIR):
        subprocess.run(["git", "clone", "https://github.com/ohmyzsh/ohmyzsh.git",
                        OHMYZSH_INSTALL_DIR], check=True)
        subprocess.run(["chsh", "--shell", "/usr/bin/zsh", "gun"])
    else:
        print("Oh-My-Zsh directory already exists. Skipping.")

def install_yt_dlp():
    urllib.request.urlretrieve("https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp", "/usr/local/bin/yt-dlp")
    os.chmod("/usr/local/bin/yt-dlp", 0o755)

def install_lf():
    dl_path = os.path.join(HOMEDIR, "lf.tar.gz")
    urllib.request.urlretrieve("https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz", dl_path)
    file = tarfile.open(dl_path)
    file.extract("lf", "/usr/local/bin")
    file.close()
    os.chmod("/usr/local/bin/lf", 0o755)
    os.remove(dl_path)

def install_sakura():
    sakura_download_key = os.getenv("SAKURA_DOWNLOAD_KEY")
    
    if not sakura_download_key:
        print("Sakura download key not found, skipping.")
        return
    
    latest_release_asset_id = get_sakura_latest_release_asset_id(sakura_download_key)

    if latest_release_asset_id:
        download_path = os.path.join(HOMEDIR, "SakuraHSDownloader")
        download_sakura_release_by_id(sakura_download_key, latest_release_asset_id, download_path)
    
def get_sakura_latest_release_asset_id(token):
    url = f"https://api.github.com/repos/gunt3001/private-sakura-downloader/releases/latest"
    
    curl_command = [
        "curl",
        "-H", f"Authorization: Bearer {token}",
        "-H", "Accept: application/vnd.github.v3+json",
        url
    ]
    
    try:
        result = subprocess.run(curl_command, capture_output=True, text=True, check=True)
        release_data = result.stdout
        release_data_json = json.loads(release_data)
        
        for asset in release_data_json.get("assets", []):
            if asset.get("name") == "SakuraHSDownloader":
                return asset.get("id")
        
        print("Asset ID for SakuraHSDownloader not found.")
        return None
    except subprocess.CalledProcessError:
        print("Failed to fetch latest Sakura release.")
        return None

def download_sakura_release_by_id(token, asset_id, download_path):
    url = f"https://api.github.com/repos/gunt3001/private-sakura-downloader/releases/assets/{asset_id}"
    
    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/octet-stream"
    }
    
    curl_command = [
        "curl",
        "-H", f"Authorization: Bearer {token}",
        "-H", "Accept: application/octet-stream",
        "-L", url,
        "-o", download_path
    ]
    
    try:
        subprocess.run(curl_command, check=True)
        print("SakuraHSDownloader downloaded successfully.")
    except subprocess.CalledProcessError:
        print("Failed to download SakuraHSDownloader.")

def setup_dotfiles():
    # Setup dotfiles
    # Set up dotfiles management system outlined in this tutorial
    # https://www.atlassian.com/git/tutorials/dotfiles
    if not os.path.isdir(DOTFILES_GIT_DIR):
        subprocess.run(["git", "clone", "--bare", DOTFILES_REPO_URL,
                        DOTFILES_GIT_DIR], check=True)
        subprocess.run(["git", "--git-dir="+DOTFILES_GIT_DIR, "--work-tree="+HOMEDIR,
                        "checkout"], check=True)
    else:
        print("Dotfiles git directory already exists in home. Skipping.")

def setup_onedrive_symlink():
    # Symlink to OneDrive mount to home directory, if exists
    if os.path.isdir(ONEDRIVE_SOURCE_MOUNT_DIR) and not os.path.isdir(ONEDRIVE_DEST_MOUNT_DIR):
        os.symlink(ONEDRIVE_SOURCE_MOUNT_DIR,
                ONEDRIVE_DEST_MOUNT_DIR,
                target_is_directory=True)
    elif not os.path.isdir(ONEDRIVE_SOURCE_MOUNT_DIR):
        print("OneDrive mount directory at " + ONEDRIVE_SOURCE_MOUNT_DIR + "does not exist. Skipping.")
    elif os.path.isdir(ONEDRIVE_DEST_MOUNT_DIR):
        print("OneDrive directory already exists on home. Skipping.")

def ask_option(component):
    valid_answers = ["y", "n"]
    answer = ""
    while answer not in valid_answers:
        answer = input("Setup " + component + "? (y/n): ").lower()
    return answer == "y"

main(len(sys.argv) > 1 and sys.argv[1] == "-i")
