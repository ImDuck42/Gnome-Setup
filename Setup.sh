#!/bin/bash


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


# Install the Theme, Icon and Cursor

cd WhiteSur-gtk-theme
./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
cd ..

cd Nordzy-icon
./install.sh -t default -c -p
cd ..

cd Nordzy-cursors
./install.sh
cd ..


# Install Desktop Background and GDM Theme 

cp Dark_moon.png WhiteSur-gtk-theme
cd WhiteSur-gtk-theme
gsettings set org.gnome.desktop.background picture-uri 'Dark_Moon.png'
sudo ./tweaks.sh -g -n -b 'Dark_Moon.png'
sudo ./tweaks.sh -F -d
cd ..


# Install Vencord 

sudo sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
killall Discord


# Aply Spicetify and install The theme

curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh


# Delete the Gnome-Setup folder

cd ..
sudo rm -r Gnome-Setup


# Set default shell to fish




# Restart
reboot
