#!/bin/bash

# ------------------------------------------------//Predefine Colors//----------------------------------------------------

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

# ------------------------------------------------//Header Scii Art//----------------------------------------------------

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

resources_ascii_art="
${MAGENTA}  _____                                          ${RESET}
${MAGENTA} |  __ \                                         ${RESET}
${MAGENTA} | |__) |___  ___  ___  _   _ _ __ ___ ___  ___  ${RESET}
${MAGENTA} |  _  // _ \/ __|/ _ \| | | | '__/ __/ _ \/ __| ${RESET}
${MAGENTA} | | \ \  __/\__ \ (_) | |_| | | | (_|  __/\__ \ ${RESET}
${MAGENTA} |_|  \_\___||___/\___/ \__,_|_|  \___\___||___/ ${RESET}
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

# ------------------------------------------------//External Rverences//----------------------------------------------------

# Repository URLs
WHITE_SUR_THEME_REPO="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
NORDZY_ICON_REPO="https://github.com/alvatip/Nordzy-icon.git"
NORDZY_CURSOR_REPO="https://github.com/alvatip/Nordzy-cursors.git"

# Other URLs
SPICETIFY_URL="https://spicetify.app/"
VENCORD_URL="https://vencord.dev/"

# Social URLs
GITHUB_PROFILE_URL="https://github.com/ImDuck42"
DISCORD_SERVER_URL="https://discord.gg/fbdYpD6wcS"

# ------------------------------------------------//Pre-Run scripts//----------------------------------------------------

# Check if the user is running as root
if [ "$(id -u)" -ne 0 ] || \
   [ -z "$XDG_CURRENT_DESKTOP" ] || [ "$XDG_CURRENT_DESKTOP" != "GNOME" ] || \
   [ "$(awk -F= '/^ID=/ {print $2}' /etc/os-release)" != "arch" ] && \
   [ "$(awk -F= '/^ID_LIKE=/ {print $2}' /etc/os-release)" != "arch" ]; then
    echo -e "${RED}This script requires root privileges and is intended for GNOME on Arch-based systems.${RESET}"
    exit 1
fi

# List of repositories to clone
repositories=("https://github.com/vinceliuice/WhiteSur-gtk-theme.git" "https://github.com/alvatip/Nordzy-icon.git" "https://github.com/alvatip/Nordzy-cursors.git")

# Clear the screen
clear

# ------------------------------------------------//Main Screen//----------------------------------------------------

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
            
# ------------------------------------------------//Stage 1) Updating Un-/Installing dependencies//----------------------------------------------------

		echo -e "${GREEN}Stage 1) Updating Uninstalling/Installing dependencies${RESET}"
		sleep 5

		# Update, Uninstall and Install dependencies

		echo -e "${YELLOW}Updating${RESET}"
  
		pacman -Syuu --noconfirm

		echo -e "${YELLOW}Uninstaling dependencies${RESET}"
  
		pacman -Rs htop firedragon geary gestures mpv --noconfirm

		echo -e "${YELLOW}Installing dependencies${RESET}"
  
		pacman -S gnome-tweaks appimagelauncher discord spotify spicetify-cli totem lollypop gimp obs-studio telegram-desktop stacer libreoffice-fresh yuzu-mainline-git citra-canary-git dconf-editor qbittorrent gnome-boxes visual-studio-code-bin steam wine bottles opera cups jre-openjdk neofetch --noconfirm

		echo -e "${BLUE}Stage 1) completed..
		sleep 2${RESET}"

# ------------------------------------------------//stage 2) Installing Themes//----------------------------------------------------

		echo -e "${GREEN}Stage 2) Installing Themes${RESET}"
		sleep 5

		echo -e "${YELLOW}Creating directories${RESET}"

		# Clone all files for the Theme
		cd ..
		mkdir -p .Applications
  		mkdir -p Projects
    		mkdir -p Stuff
		mkdir -p Games
		cd Games
		mkdir -p Yuzu Citra
		cd ..
		cd Gnome-Setup

		echo -e "${YELLOW}Cloning Themes${RESET}"

		# Clone all repositories
		for repo in "$WHITE_SUR_THEME_REPO" "$NORDZY_ICON_REPO" "$NORDZY_CURSOR_REPO"; do
		    if git clone "$repo" 2>/dev/null; then
		        echo -e "${GREEN}Successfully cloned $repo${RESET}"
		    else
		        echo -e "${RED}Warning: Unable to clone $repo. Exiting Script${RESET}"
		        exit 1
		    fi
		done

  		
		echo -e "${YELLOW}Installing WhiteSur-gtk and Tweaks${RESET}"

		# Install the WhiteSur gtk/GDM theme and tweaks
		cp Dark_Moon.png '$HOME/Pictures'
		cd WhiteSur-gtk-theme
		./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
		sudo ./tweaks.sh -g -n -b '$HOME/Pictures/Dark_Moon.png'
		sudo ./tweaks.sh -F -d
		cd ..

		echo -e "${YELLOW}Installing Nordzy Iconpack and Cursor${RESET}"

		# Install the Iconpack and Cursor
		cd Nordzy-icon
		./install.sh -t default -c -p
		cd ..

		cd Nordzy-cursors
		./install.sh
		cd ..

		echo -e "${YELLOW}Apllying GTK-Theme Iconpack and Cursor${RESET}"

		# Use Background Theme Iconpack and Cursor
		cd WhiteSur-gtk-theme
		gsettings set org.gnome.desktop.background picture-uri '$HOME/Pictures/Dark_Moon.png'
		gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-nord'
  		gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-solid-nord'
		gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark--light_panel'
		gsettings set org.gnome.desktop.interface cursor-theme 'Nordzy-cursors'

		echo -e "${BLUE}Stage 2) completed ..${RESET}"
		sleep 2

# ------------------------------------------------//Stage 3) Installing Vencord and Spicetify//----------------------------------------------------

		echo -e "${GREEN}stage 3) Installing Vencord and Spicetify${RESET}"
		sleep 5

		echo -e "${YELLOW}Installing Vencord${RESET}"

		# Install Vencord
		discord &
		sleep 30
		sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
		killall Discord

		echo -e "${YELLOW}Installing Spicetify with Nord Theme${RESET}"

		# Apply Spicetify and Marketplace and the Nord theme
		spotify &
		sleep 30
		killall spotify
		curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
		curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

		spicetify backup apply

		curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh

		echo -e "${BLUE}Stage 3) completed${RESET}"
		sleep 2

# ------------------------------------------------//Stage 4) Others//----------------------------------------------------

		echo -e "${GREEN}Stage 4) Others${RESET}"
		sleep 5

		echo -e "${YELLOW}Set fish as default shell${RESET}"

		# Change default shell to Fish if it's not already
		[ "$(echo $SHELL)" != "/usr/bin/fish" ] && chsh -s /usr/bin/fish
  
		echo -e "${BLUE}Stage 4) completed${RESET}"
		sleep 2
		echo -e "${MAGENTA}Setup finished, please wait ...${RESET}"
		sleep 10
            
# ------------------------------------------------//Manual-Steps Screen//----------------------------------------------------
            
            	clear
		echo -e "$manualsteps_ascii_art"
		echo -e "
${GREEN}1) Sort your Application Menu${RESET}

${GREEN}2) Install Gnome Extensions:${RESET}
${BLUE}Extensions Website:${RESET} ${CYAN}https://extensions.gnome.org${RESET}
${BLUE}Dash to Dock:${RESET} ${CYAN}https://extensions.gnome.org/extension/307/dash-to-dock${RESET}
${BLUE}Blur my Shell:${RESET} ${CYAN}https://extensions.gnome.org/extension/3193/blur-my-shell${RESET}
${BLUE}Just Perfection:${RESET} ${CYAN}https://extensions.gnome.org/extension/3843/just-perfection${RESET}
${BLUE}Tiling Assistant:${RESET} ${CYAN}https://extensions.gnome.org/extension/3733/tiling-assistant${RESET}
${BLUE}Rounded Corners:${RESET} ${CYAN}https://extensions.gnome.org/extension/1514/rounded-corners${RESET}

${GREEN}3) Go to your Gnome-Extensions app and enable all installed + User Themes${RESET}
${BLUE}--> Configure your Extensions${RESET}
${CYAN}-> gnome-extensions${RESET}

${GREEN}4) Go to your Gnome-Tweaks app and change the Settings as you like${RESET}
${CYAN}-> gnome-tweaks${RESET}

${GREEN}5) Also Tweak the settings in your Gnome-Settings${RESET}
${CYAN}-> gnome-control-center${RESET}

${GREEN}6) You should also go into your apps and sett them up to your liking${RESET}
"

		read -p "Type 'q' to exit: " response
            	[ "$response" == "q" ] && clear
            
            break
            ;;

        2)
            # Option 2: Print the script
            echo -e "${YELLOW}Printing the script...${RESET}"
            sleep 2
            clear
            echo -e "${CYAN}"
            cat "$0"
            echo -e "${RESET}"
            read -p "Type 'q' to exit: " response
            [ "$response" == "q" ] && clear
            ;;
	
	3)
	   # Option 3: Show Sources page
clear
echo -e "$resources_ascii_art"
echo -e "	   
${GREEN}WhiteSur-gtk:${RESET}
${BLUE}->${RESET} ${CYAN}$WHITE_SUR_THEME_REPO${RESET}
	
${GREEN}Nordzy Icons:${RESET}
${BLUE}->${RESET} ${CYAN}$NORDZY_ICON_REPO${RESET}
	
${GREEN}Nordzy Cursors:${RESET}
${BLUE}->${RESET} ${CYAN}$NORDZY_CURSOR_REPO${RESET}
	
${GREEN}Spicetify:${RESET}
${BLUE}->${RESET} ${CYAN}$SPICETIFY_URL${RESET}
	
${GREEN}Vencord:${RESET}
${BLUE}->${RESET} ${CYAN}$VENCORD_URL${RESET}
					${MAGENTA}Made by ImDuck42${RESET}
					${BLUE}->${RESET} ${CYAN}$GITHUB_PROFILE_URL${RESET}
					${BLUE}->${RESET} ${CYAN}$DISCORD_SERVER_URL${RESET}"

     
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
            echo -e "${RED}Invalid option. Please select 1, 2, 3 or 4."
            sleep 2
            clear
            ;;
    esac
done
