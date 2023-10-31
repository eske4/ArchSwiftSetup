#!/bin/bash

# Store the current directory in a variable
current_dir=$(pwd)

# Define package lists - change to your likings
essential_packages=(
    gnome-disk-utility
    curl
    gnome-terminal
    guake
    bluez
    blueman
    bluez-utils
    p7zip
    unrar
    tar
    rsync
    htop
    exfat-utils
    fuse-exfat
    ntfs-3g
    flac
    jasper
    aria2
    wget
    base-devel
    libreoffice-fresh
    timeshift
    git
    ufw
)

aur_packages=(
    preload
    auto-cpufreq
)

cplusplus_packages=(
    gcc
    cmake
    make
    base-devel
    zip
    unzip
    ninja
)

custom_packages_pacman=(
    firefox
    steam
    discord
    neofetch
    code
    blender
    krita
    python
    vlc
    gamemode
    wine
    wine-mono
    wine-gecko
)

custom_packages_yay=(
    skypeforlinux-stable-bin
    github-desktop-bin
    code-marketplace
    protonup-qt
)


# ANSI escape codes for colored text
BRIGHT_PINK='\e[95m'
RESET_COLOR='\e[0m'

# Function to echo with colored text
colored_echo() {
    local color="$1"
    local message="$2"
    echo -e "${color}$message${RESET_COLOR}"
}

# Function to install packages with the specified package manager (pacman or yay)
install_packages() {
    local package_manager="$1"
    shift
    local packages=("$@")
    colored_echo "$BRIGHT_PINK" "Installing packages using $package_manager"
    if [ "$package_manager" == "yay" ]; then
        yay -S --noconfirm "${packages[@]}"
    else
        sudo pacman -S --noconfirm "${packages[@]}"
    fi
}

# Function to install microcode if desired
install_microcode() {
    local cpu_type="$1"
    read -p "Do you have an $cpu_type CPU? (yes[Y]/no[N]): " response
    response="${response,,}"
    if [[ "$response" == "yes" || "$response" == "y" ]]; then
        install_packages "pacman" "$cpu_type-ucode"
    fi
}

# Update and upgrade the system
sudo pacman -Syu --noconfirm

# Configure pacman settings
sudo sed -i '/^#Color/s/^#//' /etc/pacman.conf
sudo sed -i '/^#ParallelDownloads = 5/s/^#//' /etc/pacman.conf
if ! grep -q '^ILoveCandy' /etc/pacman.conf; then
    sudo sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
fi
if ! grep -q '^ParallelDownloads=5' /etc/pacman.conf; then
    sudo sed -i '/^#Color/a ParallelDownloads=5' /etc/pacman.conf
fi
sudo pacman -Sy --noconfirm

# Install essential packages using pacman
install_packages "pacman" "${essential_packages[@]}"
colored_echo "$BRIGHT_PINK" "Installing custom packages for pacman"
install_packages "pacman" "${custom_packages_pacman[@]}"

# Load Bluetooth module and enable the service
colored_echo "$BRIGHT_PINK" "Setting up Bluetooth..."
sudo modprobe btusb
sudo systemctl enable --now bluetooth

# Install yay using git
colored_echo "$BRIGHT_PINK" "Installing yay package manager"
yay_dir="/tmp/yay"
git clone https://aur.archlinux.org/yay.git "$yay_dir"
cd "$yay_dir" || exit
makepkg -si --noconfirm

# Install AUR packages using yay
colored_echo "$BRIGHT_PINK" "Installing essentials through yay"
install_packages "yay" "${aur_packages[@]}"

# Install custom packages using yay
colored_echo "$BRIGHT_PINK" "Installing custom packages for yay"
install_packages "yay" "${custom_packages_yay[@]}"

# Remove downloaded files
rm -rf "$yay_dir"

# Set up a C++ development environment if desired
read -p "Do you want to set up a C++ development environment? (yes[Y]/no[N]): " response
response="${response,,}"  # Convert to lowercase for case-insensitive comparison
if [[ "$response" == "yes" || "$response" == "y" ]]; then
    install_packages "pacman" "${cplusplus_packages[@]}"
    colored_echo "$BRIGHT_PINK" "C++ development environment set up."
else
    colored_echo "$BRIGHT_PINK" "C++ development environment not set up."
fi

# Install microcode for Intel and AMD CPUs if desired
install_microcode "intel"
install_microcode "amd"

cd "$current_dir"

# Adding Guake to autostart
colored_echo "$BRIGHT_PINK" "Adding Guake to autostart"
sudo cp /usr/share/guake/autostart-guake.desktop /etc/xdg/autostart/autostart-guake.desktop

# Update GRUB configuration
colored_echo "$BRIGHT_PINK" "Updating GRUB configuration"
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Enable UFW and Preload services
colored_echo "$BRIGHT_PINK" "Enabling UFW and Preload services"
sudo systemctl enable --now ufw
sudo systemctl enable --now preload

guake
