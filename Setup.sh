#!/bin/bash

# Clone all files for the Theme

cd ..
mkdir .Applications
mkdir Setup
cd Setup

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


# Install Desktop Background and GDM Theme 

cd WhiteSur-gtk-theme
gsettings set org.gnome.desktop.background picture-uri 'Dark_Moon.png'
sudo ./tweaks.sh -g -n -b 'Dark_Moon.png'
cd ..
cd ..
cd Gnome-Setup

# Install Dependencies
sudo pacman -S --needed - < install.txt --noconfirm


# Enable Cups

sudo systemctl enable org.cups.cupsd
sudo systemctl start org.cups.cupsd


# Uninstall dependencies

sudo pacman -Rs - < uninstall.txt --noconfirm


# Install Vencord 

sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
killall Discord


# Aply Spicetify and install The theme

curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh


# Delete the Gnome-Setup folder

cd ..
sudo rmdir -r Gnome-Setup


# Restart
restart
