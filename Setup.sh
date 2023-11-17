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
BOLD='\033[1m'
RESET='\033[0m'

# Example usage
#    echo -e "${BOLD}This is bold text.${RESET}"

# Example usage
#    echo -e "${BOLD}${RED}This is bold red text.${RESET}"
#    echo -e "${BOLD}${GREEN}This is bold green text.${RESET}"
#    echo -e "${BOLD}${YELLOW}This is bold yellow text.${RESET}"
#    echo -e "${BOLD}${BLUE}This is bold blue text.${RESET}"

# Define ASCII art for welcome text
setupsh_ascii_art="
${MAGENTA}   _____      _                    _     ${RESET}
${MAGENTA}  / ____|    | |                  | |    ${RESET}
${MAGENTA} | (___   ___| |_ _   _ _ __   ___| |__  ${RESET}
${MAGENTA}  \___ \ / _ \ __| | | | '_ \ / __| '_ \ ${RESET}
${MAGENTA}  ____) |  __/ |_| |_| | |_) |\__ \ | | |${RESET}
${MAGENTA} |_____/ \___|\__|\__,_| .__(_)___/_| |_|${RESET}
${MAGENTA}                       | |               ${RESET}
${MAGENTA}                       |_|               ${RESET}
"
# Define ASCII art for Setting up text
settingup_ascii_art="
${MAGENTA}   _____      _   _   _                           ${RESET}
${MAGENTA}  / ____|    | | | | (_)                          ${RESET}
${MAGENTA} | (___   ___| |_| |_ _ _ __   __ _   _   _ _ __  ${RESET}
${MAGENTA}  \___ \ / _ \ __| __| | '_ \ / _' | | | | | '_ \ ${RESET}
${MAGENTA}  ____) |  __/ |_| |_| | | | | (_| | | |_| | |_) |${RESET}
${MAGENTA} |_____/ \___|\__|\__|_|_| |_|\__, |  \__,_| .__/ ${RESET}
${MAGENTA}                               __/ |       | |    ${RESET}
${MAGENTA}                              |___/        |_|    ${RESET}
"


# Check if run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${BOLD}${RED}Please run this script as root...${RESET}"
    exit 1
fi

# Clear the screen
clear

# Main screen
while true; do
    # Print the setupsh ASCII art
    echo -e "$setupsh_ascii_art"

    # Display menu options
    echo -e "${BOLD}${GREEN}1) Set up the PC${RESET}"
    echo -e "${BOLD}${GREEN}2) Print the script${RESET}"
    echo -e "${BOLD}${GREEN}3) Exit the script${RESET}"

    # Prompt user for input
    read -p "Select an option: " option

    case $option in
        1)
            # Option 1: Set up the PC
            	echo -e "${BLUE}Setting up the PC..."
	    	sleep 5
     		clear
     			# Print the setupsh ASCII art
    			echo -e "$settingup_ascii_art"
            	# Add your setup commands here
            	sudo pacman -Syyu
            ;;

        2)
            # Option 2: Print the script
	        echo -e "${BOLD}${YELLOW}Printing the script:${RESET}"
	        sleep 2
	        clear
	        echo -e "${CYAN}"
	        cat "$0"  # Print the script
	        echo -e "${RESET}"
	        read -p "Type 'q' to exit: " response
	        if [ "$response" == "q" ]; then
	        clear  # Clear the terminal
	        fi
            ;;

        3)
            # Option 3: Exit the script
            echo -e "${RED}Exiting the script. Goodbye!"
            exit 0
            ;;

        *)
            # Invalid option
            echo -e "${RED}Invalid option. Please select 1, 2, or 3."
            sleep 2
            clear
            ;;
    esac
done

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
cp Dark_moon.png WhiteSur-gtk-theme
cd WhiteSur-gtk-theme
./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
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
gsettings set org.gnome.desktop.background picture-uri '~/Gnome-Setup/WhiteSur-gtk-theme/Dark_Moon.png'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-nord'
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark--light_panel'
sudo update-alternatives --set x-cursor-theme ~/.icons/Nordzy-cursors

# Make Theme tweaks
sudo ./tweaks.sh -g -n -b 'Dark_Moon.png'
sudo ./tweaks.sh -F -d
cd ..

# Install Vencord 
discord
sleep 30
sudo sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
killall Discord

# Aply Spicetify and Marketplace and the Nord theme
spotify
sleep 30
killall spotify
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh

# Delete the Gnome-Setup folder
cd ..
sudo rm -r Gnome-Setup

# Set default shell to fish
chsh -s /usr/bin/fish
