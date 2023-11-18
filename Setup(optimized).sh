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

RESET='\033[0m'

# ASCII art
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

manualsteps_ascii_art="
${MAGENTA} __  __                         _      ____ _                  ${RESET}
${MAGENTA}|  \/  |                       | |   / ____| |                 ${RESET}
${MAGENTA}| \  / | __ _ _ __  _   _  __ _| |  | (___ | |_ ___ _ __  ___  ${RESET}
${MAGENTA}| |\/| |/ _' | '_ \| | | |/ _' | |   \___ \| __/ _ \ '_ \/ __| ${RESET}
${MAGENTA}| |  | | (_| | | | | |_| | (_| | |   ____) |  |  __/ |_) \__ \ ${RESET}
${MAGENTA}|_|  |_|\__,_|_| |_|\__,_|\__,_|_|  |_____/ \__\___| .__/|___/ ${RESET}
${MAGENTA}						     | |         ${RESET}
${MAGENTA}						     |_|         ${RESET}
"

# Check if run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Please run this script as root.${RESET}"
    exit 1
fi

# Clear the screen
clear

# Main screen
while true; do
    echo -e "$setupsh_ascii_art"

    # Display menu options
    echo -e "${GREEN}1) Set up the PC"
    echo -e "2) Print the script"
    echo -e "3) Show Sources page"
    echo -e "4) Exit the script${RESET}"

    # Prompt user for input
    read -p "Select an option: " option

    case $option in
        1)
            # Option 1: Set up the PC
            echo -e "${BLUE}starting Setup..."
            sleep 5
            clear
            echo -e "$settingup_ascii_art"
            # setup commands
            
            
            
            break
            ;;

        2)
            # Option 2: Print the script
            echo -e "${YELLOW}Printing the script:${RESET}"
            sleep 2
            clear
            echo -e "${CYAN}"
            cat "$0"
            echo -e "${RESET}"
            read -p "Type 'q' to exit: " response
            [ "$response" == "q" ] && clear
            ;;
	
	3)
	    # Option 3: Shaow Sources page
	    clear
	    echo -e "${CYAN}	   
Links to all Resources:
	WhiteSur-gtk
	-> https://github.com/vinceliuice/WhiteSur-gtk-theme
	    	
	Nordzy Icons:
	-> https://github.com/alvatip/Nordzy-icon
	    	
	Nordzy Cursors:
	-> https://github.com/alvatip/Nordzy-cursors
	    	
	Spicetify:
	-> https://spicetify.app/
	    	
	Vencord:
	-> https://vencord.dev/
						Made by ImDuck42
						-> https://github.com/ImDuck42
						-> https://discord.gg/fbdYpD6wcS
	    
${RESET}"
	    read -p "Type 'q' to exit: " response
            [ "$response" == "q" ] && clear
            ;;
	    
        4)
            # Option 3: Exit the script
            echo -e "${RED}Exiting the script. Goodbye!"
            exit 0
            ;;

        *)
            # Invalid option
            echo -e "$manualsteps_ascii_art"
            echo -e "${RED}Invalid option. Please select 1, 2, or 3."
            sleep 2
            clear
            ;;
    esac
done

clear
echo -e "$manualsteps_ascii_art"
echo -e 



# Update, Uninstall and Install dependencies
pacman -Syuu --noconfirm
pacman -Rs htop firedragon geary gestures mpv --noconfirm
pacman -S appimagelauncher discord spotify spicetify-cli totem lollypop gimp obs-studio telegram-desktop stacer libreoffice-fresh yuzu-mainline-git citra-canary-git dconf-editor qbittorrent gnome-boxes visual-studio-code-bin steam wine bottles opera cups jre-openjdk neofetch --noconfirm

# Enable Cups
systemctl enable org.cups.cupsd
systemctl start org.cups.cupsd

# Clone all files for the Theme
cd ..
mkdir -p .Applications
mkdir -p Games
cd Games
mkdir -p Yuzu Citra
cd ..
cd Gnome-Setup

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/alvatip/Nordzy-icon.git
git clone https://github.com/alvatip/Nordzy-cursors.git

# Install the WhiteSur gtk/GDM theme and tweaks
cp Dark_moon.png WhiteSur-gtk-theme
cd WhiteSur-gtk-theme
./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
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
gsettings set org.gnome.desktop.background picture-uri '~/Gnome-Setup/WhiteSur-gtk-theme/Dark_Moon.png'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-nord'
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark--light_panel'
update-alternatives --set x-cursor-theme ~/.icons/Nordzy-cursors

# Install Vencord
discord &
sleep 30
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
killall Discord

# Apply Spicetify and Marketplace and the Nord theme
spotify &
sleep 30
killall spotify
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh

# Delete the Gnome-Setup folder
cd ..
rm -r Gnome-Setup

# Set default shell to fish
chsh -s /usr/bin/fish