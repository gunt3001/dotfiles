# Change Komorebi config dir
# https://lgug2z.github.io/komorebi/common-workflows/komorebi-config-home.html
$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"

# Activate Starship (https://starship.rs/guide/#%F0%9F%9A%80-installation)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
