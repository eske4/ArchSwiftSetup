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
    ufw
    git
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
)

custom_packages_pacman=(
    #this are packages from pacman, add your own
    firefox
    steam
    discord
    neofetch
    code
    blender
    krita
    python
    vlc
)

custom_packages_yay=(
    #this are packages from aur, add your own
    skypeforlinux-stable-bin
    github-desktop-bin
    code-marketplace
)

# ANSI escape codes for bright pink text
BRIGHT_PINK='\e[95m'
RESET_COLOR='\e[0m'

# Function to echo with bright pink color
pink_echo() {
    echo -e "${BRIGHT_PINK}$1${RESET_COLOR}"
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
pink_echo  "Installing essential packages"
sudo pacman -S --noconfirm "${essential_packages[@]}"
pink_echo  "Installing custom packages for pacman"
sudo pacman -S --noconfirm "${custom_packages_pacman[@]}"

# Load Bluetooth module and enable the service
pink_echo "Setting up Bluetooth..."
sudo modprobe btusb
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Install yay using git
pink_echo  "Installing yay package manager"
yay_dir="/tmp/yay"
git clone https://aur.archlinux.org/yay.git "$yay_dir"
cd "$yay_dir"
makepkg -si --noconfirm

# Install AUR packages using ya
pink_echo "Installing essentials through yay"
yay -S --noconfirm "${aur_packages[@]}"

# Install custom packages using yay
pink_echo "Installing custom packages for yay"
yay -S --noconfirm "${custom_packages_yay[@]}"

# Remove downloaded files
rm -rf "$yay_dir"

# Start Guake
guake &

# Set up a C++ development environment if desired
read -p "Do you want to set up a C++ development environment? (yes[Y]/no[N]): " response
response="${response,,}"  # Convert to lowercase for case-insensitive comparison
if [[ "$response" == "yes" || "$response" == "y" ]]; then
    sudo pacman -S --noconfirm "${cplusplus_packages[@]}"
    pink_echo "C++ development environment set up."
else
    pink_echo "C++ development environment not set up."
fi

# Install microcode for Intel CPUs if desired
read -p "Do you have an Intel CPU? (yes[Y]/no[N]): " response
response="${response,,}"
if [[ "$response" == "yes" || "$response" == "y" ]]; then
    sudo pacman -S --noconfirm intel-ucode
fi

# Install microcode for AMD CPUs if desired
read -p "Do you have an AMD CPU? (yes[Y]/no[N]): " response
response="${response,,}"
if [[ "$response" == "yes" || "$response" == "y" ]]; then
    sudo pacman -S --noconfirm amd-ucode
fi

cd "$current_dir"

# Update GRUB configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Enable UFW and Preload services
sudo systemctl enable ufw
sudo systemctl enable preload
sudo systemctl start preload
