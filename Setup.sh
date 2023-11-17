#!/bin/bash

# Text colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
LIGHT_YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_MAGENTA='\033[1;35m'
LIGHT_CYAN='\033[1;36m'

# Example usage
#    echo -e "${RED}This is red text${NC}"
#    echo -e "${LIGHT_GREEN}This is light green text${NC}"
#    echo -e "${YELLOW}This is yellow text${NC}"
#    echo -e "${LIGHT_BLUE}This is light blue text${NC}"

# Bold text
#    BOLD='\033[1m'
#    RESET='\033[0m'

# Example usage
#    echo -e "${BOLD}This is bold text.${RESET}"

# Example usage
#    echo -e "${BOLD}${RED}This is bold red text.${RESET}"
#    echo -e "${BOLD}${GREEN}This is bold green text.${RESET}"
#    echo -e "${BOLD}${YELLOW}This is bold yellow text.${RESET}"
#    echo -e "${BOLD}${BLUE}This is bold blue text.${RESET}"


# Check if run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Update
sudo pacman -Syuu

#Uninstall dependencies
sudo pacman -Rs htop firedragon geary gestures mpv --noconfirm

# Install dependencies
sudo pacman -S appimagelauncher discord spotify spicetify-cli totem lolipop gimp obs-studio telegram-desktop stacer libreoffice-fresh yuzu-mainline-git citra-canary-git dconf-editor qbittirrent gnome-boxes visual-studio-code-bin steam wine bottles opera cups jre-openjdk neofetch --noconfirm


# Enable Cups
sudo systemctl enable org.cups.cupsd
sudo systemctl start org.cups.cupsd


# Clone all files for the Theme
cd ..
mkdir .Applications
cd Gnome-Setup

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/alvatip/Nordzy-icon.git
git clone https://github.com/alvatip/Nordzy-cursors.git


# Install the WhiteSur gtk/GDM theme and tweaks
cd WhiteSur-gtk-theme
./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
cp Dark_moon.png WhiteSur-gtk-theme
cd WhiteSur-gtk-theme
sudo ./tweaks.sh -g -n -b 'Dark_Moon.png'
sudo ./tweaks.sh -F -d
cd ..

# Install the Iconpack and Cursor
cd Nordzy-icon
./install.sh -t default -c -p
cd ..

cd Nordzy-cursors
./install.sh
cd ..

# Use Background Theme Iconpack and Cursor
cd WhiteSur-gtk-theme
gsettings set org.gnome.desktop.background picture-uri 'Dark_Moon.png'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-nord'
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark--light_panel'
sudo update-alternatives --set x-cursor-theme ~/.icons/Nordzy-cursors

# Make Theme tweaks
sudo ./tweaks.sh -g -n -b 'Dark_Moon.png'
sudo ./tweaks.sh -F -d
cd ..

# Install Vencord 
sudo sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
killall Discord

# Aply Spicetify and Marketplace and the Nord theme
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh

# Delete the Gnome-Setup folder
cd ..
sudo rm -r Gnome-Setup

# Set default shell to fish
chsh -s /usr/bin/fish
