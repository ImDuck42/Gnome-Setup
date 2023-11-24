#!/bin/bash
set -e 

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
${MAGENTA}                       |_|  Garuda  V_2.0${RESET}
"

continuing_page_ascii_art="
${MAGENTA}  ______    _ _               _                 ____ _                  ${RESET}
${MAGENTA} |  ____|  | | |             (_)              / ____| |                 ${RESET}
${MAGENTA} | |__ ___ | | | _____      ___ _ __   __ _  | (___ | |_ ___ _ __  ___  ${RESET}
${MAGENTA} |  __/ _ \| | |/ _ \ \ /\ / / | '_ \ / _' |  \___ \| __/ _ \ '_ \/ __| ${RESET}
${MAGENTA} | | | (_) | | | (_) \ V  V /| | | | | (_| |  ____) |  |  __/ |_) \__ \ ${RESET}
${MAGENTA} |_|  \___/|_|_|\___/ \_/\_/ |_|_| |_|\__, | |_____/ \__\___| .__/|___/ ${RESET}
${MAGENTA}                                       __/ |                | |         ${RESET}
${MAGENTA}                                      |___/                 |_|         ${RESET}
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
${MAGENTA}						                             | |         ${RESET}
${MAGENTA}						                             |_|         ${RESET}
"

# ------------------------------------------------//External Reverences//----------------------------------------------------

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

USER=$(whoami)

# ------------------------------------------------//Predefining Packages//----------------------------------------------------

# Pacman Install list
PACKAGES_TO_INSTALL=(
    appimagelauncher
    discord
    spotify
    spicetify-cli
    totem
    gimp
    obs-studio
    telegram-desktop
    stacer
    lollypop
    libreoffice-fresh
    yuzu-mainline-git
    citra
    dconf-editor
    qbittorrent
    gnome-boxes
    visual-studio-code-bin
    steam
    wine
    bottles
    opera
    cups
)

# Pacman Uninstall list 
PACKAGES_TO_UNINSTALL=(
    htop
    firedragon
    geary
    gestures
    mpv
)

# ------------------------------------------------//Some Stuff//----------------------------------------------------

# sudo chmod -R a+rw /opt/spotify/
# sudo chmod -R a+rw /opt/discord/

# ------------------------------------------------//All Used Functions//----------------------------------------------------

# Function to check if the script is run on an Arch-based distro with Gnome DE and root privileges // If not then exit
check_if_root() {
# Check if it has root permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}This script requires root privileges. Please run with sudo.${RESET}"
    sleep 2
    main_screen
fi

# Check if its on Gnome DE
if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
    echo -e "${RED}This script is intended for GNOME desktop environment.${RESET}"
    exit 1
fi

# Check if its run on an Arch-based Distro
if [ "$(awk -F= '/^ID=/ {print $2}' /etc/os-release)" != "arch" ] && \
   [ "$(awk -F= '/^ID_LIKE=/ {print $2}' /etc/os-release)" != "arch" ]; then
    echo -e "${RED}This script is intended for Arch-based distributions.${RESET}"
    exit 1
fi
}

# Funktion to check if the device has a connection to the Internet
check_for_internet() {
    echo -e "${YELLOW}Checking for Internet connection...${RESET}"
    sleep 1
    if ip route | grep default >/dev/null; then
            echo -e "${GREEN}Internet is reachable. Continuing...${RESET}"
            sleep 2
    else
        echo -e "${RED}No internet connectivity... Exiting Setup...${RESET}"
        sleep 2
        exit 1
    fi
}

# Funciton for showing all steps  # In development # 2nd conect from 1) in main screen 
show_all_steps() {
    echo -e "
${BLUE}--> Check for root acces, Gnome and Distrobution
--> Check for internet connection${RESET}

    ${MAGENTA}Stage 1)${RESET}
     ${CYAN}-> Updating the system
     -> Uninstalling packages
     -> Installing packages${RESET}
    ${MAGENTA}Stage 2)${RESET}
     ${CYAN}-> Creating Directories
     -> Git cloning necesary files${RESET}  ${RED}Can take a bit${RESET}
     ${CYAN}-> Copying "Dark_Moon.png" to Pictures folder
     -> Installing cloned themes${RESET}
    ${MAGENTA}Stage 3)${RESET}
     ${CYAN}-> Instaling Vencord${RESET}    ${RED}Userinput required${RESET}
     ${CYAN}-> Installing Spicetify${RESET}
    ${MAGENTA}Stage 4)${RESET}
     ${CYAN}-> Changing default shell to fish if not allready
     -> Deleting working Folder (Gnome-Setup)${RESET}

${RED}IMPORTANT: This script will EXIT on any kind of ERROR${RESET}
    "
    echo -e "${MAGENTA}Do you want to continue ?${RESET}"
    echo -e "${RED}Press ANYTHING to go back${RESET}
${GREEN}Type: I AGREE to continue${RESET}"
    read -s user_input

    case "$user_input" in
        "I AGREE")
            echo -e "${GREEN}Starting the Setup ...${RESET}"
            clear
            echo -e "$settingup_ascii_art"
            check_if_root
            check_for_internet
            update_install_dependencies
            install_themes
            install_vencord_spicetify
            other_tasks
            display_manual_steps
            ;;
        *)
            echo -e "${RED}Exiting Setup...${RESET}"
            sleep 2
            clear
            main_screen
            ;;
    esac
}

# Function to update, uninstall, and install packages
update_install_dependencies() {
    echo -e "${YELLOW}Updating...${RESET}"
    sleep 2
    garuda-update --noconfirm

    echo -e "${YELLOW}Uninstalling packages${RESET}"
    sleep 2
    pacman -Rs "${PACKAGES_TO_UNINSTALL[@]}" --noconfirm

    echo -e "${YELLOW}Installing packages${RESET}"
    sleep 2
    pacman -S "${PACKAGES_TO_INSTALL[@]}" --noconfirm
}

# Function to install themes
install_themes() {
    echo -e "${GREEN}Stage 2) Installing Themes (This can take a bit)${RESET}"
    sleep 5

    # Creating Directories
    echo -e "${CYAN}Creating directories${RESET}"
    sleep 1
    mkdir -p $HOME/.Applications $HOME/Stuff $HOME/Games/{Citra,Yuzu}

    # Clone all repositories
    echo -e "${YELLOW}Git cloning Theme Iconpack and Cursor${RESET}"
    for repo in "$WHITE_SUR_THEME_REPO" "$NORDZY_ICON_REPO" "$NORDZY_CURSOR_REPO"; do
        while ! git clone "$repo" 2>/dev/null; do
            sleep 1
        done
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Successfully cloned $repo${RESET}"
        else
            echo -e "${RED}Warning: Unable to clone $repo. Exiting Script${RESET}"
            exit 1
        fi
    done

    # Change Ownership
    sudo chown -R $USER:$USER WhiteSur-gtk-theme Nordzy-icon Nordzy-cursors

    # Copying Dark_Moon to Pictures Folder
    echo -e "${YELLOW}Copying Dark_Moon to Pictures Folder${RESET}"
    sleep 1
    cp Dark_Moon.png "$HOME/Pictures"

    # Install the WhiteSur gtk/GDM theme and tweaks
    echo -e "${YELLOW}Installing WhiteSur-gtk and Tweaks${RESET}"
    sleep 1
    cp Dark_Moon.png "$HOME/Pictures"
    cd WhiteSur-gtk-theme
    ./install.sh --nord -l -c Dark -m -p 60 -P bigger --normal
    sudo ./tweaks.sh -g -n -b "$HOME/Pictures/Dark_Moon.png"
    sudo ./tweaks.sh -F -d
    cd ..

    # Install the Iconpack and Cursor
    echo -e "${YELLOW}Installing Nordzy Iconpack and Cursor${RESET}"
    sleep 1
    cd Nordzy-icon
    ./install.sh -t default -c -p
    cd ..

    cd Nordzy-cursors
    ./install.sh
    cd ..

    # Apply Theme, Iconpack and Cursor
    echo -e "${YELLOW}Apllying GTK-Theme, Iconpack and Cursor${RESET}"
    sleep 1
    cd WhiteSur-gtk-theme
    gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/Dark_Moon.png"
    gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-nord'
    gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-solid-nord'
    gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark--light_panel'
    gsettings set org.gnome.desktop.interface cursor-theme 'Nordzy-cursors'

    echo -e "${BLUE}Stage 2) completed ..${RESET}"
    sleep 2
}

# Function to install Vencord and Spicetify
install_vencord_spicetify() {
    echo -e "${GREEN}Stage 3) Installing Vencord and Spicetify${RESET}"
    sleep 5

    # Install Vencord
    echo -e "${YELLOW}Installing and applying Vencord${RESET}"
    sleep 1
    discord &
    sleep 15
    echo "Y" | sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
    killall Discord

    # Apply Spicetify and Marketplace and the Nord theme
    echo -e "${YELLOW}Installing Spicetify with Nord Theme${RESET}"
    spotify &
    while ! pgrep -x "spotify" &> /dev/null; do
        sleep 1
    done

    killall spotify
    curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
    curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
    spicetify backup apply
    echo "1" | curl -fsSL https://raw.githubusercontent.com/Tetrax-10/Nord-Spotify/master/install-scripts/install.sh | sh

    echo -e "${BLUE}Stage 3) completed${RESET}"
    sleep 2
}

# Function for other tasks
other_tasks() {
    echo -e "${GREEN}Stage 4) Others${RESET}"
    sleep 5

    # Change default shell to Fish if it's not already
    echo -e "${YELLOW}Set fish as default shell if not allready${RESET}"
    [ "$(echo $SHELL)" != "/usr/bin/fish" ] && chsh -s /usr/bin/fish

    echo -e "${BLUE}Stage 4) completed${RESET}"
    sleep 2
    echo -e "${MAGENTA}Setup finished, please wait ...${RESET}"
    sleep 10
}

# Function to display manual steps
display_manual_steps() {
    clear
    echo -e "$manualsteps_ascii_art"
    echo -e "${GREEN}1) Sort your Application Menu${RESET}

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

    ${GREEN}6) You should also go into your apps and set them up to your liking${RESET}
    "

    read -p "Type 'q' to exit: " response
    [ "$response" == "q" ] && clear
}

# Function to print the script
print_script() {
    echo -e "${YELLOW}Printing the script...${RESET}"
    sleep 2
    clear
    echo -e "${CYAN}"
    cat "$0"
    echo -e "${RESET}"
    read -p "Type 'q' to exit: " response
    [ "$response" == "q" ] && clear
}

# Function to show sources
show_sources() {
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
}

# ------------------------------------------------//Main Menu/Sreeen//----------------------------------------------------

# Function to display the main menu
main_screen() {
    while true; do
    	clear
        echo -e "$setupsh_ascii_art"

        # Display menu options
        echo -e "${GREEN}1) Set up the PC"
        echo -e "2) Print the script"
        echo -e "3) Show Sources page"
        echo -e "4) Restart your Device"
        echo -e "5) Exit the script${RESET}"

        # Prompt user for input
        read -p "Select an option: " option
        
        case $option in
            1)  
                echo -e "${BLUE}Continuing to steps page..."
                sleep 5
                clear
                echo -e "$continuing_page_ascii_art"
                show_all_steps
                ;;

            2) 
                print_script 
                ;;

            3) 
                show_sources 
                ;;

            4)
                reboot
                ;;

            5)  
                echo -e "${RED}Exiting the script. Goodbye!"
                exit 0
                ;;

            *)  
                echo -e "${RED}Invalid option. Please select 1, 2, 3, 4 or 5"
                sleep 2
                clear
                ;;
        esac
    done
}

# Call the main screen function
main_screen
