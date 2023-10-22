# ArchSwiftSetup

## Overview

**ArchSwiftSetup** is a convenient script designed to simplify the process of installing packages on Arch Linux. With just a few simple steps, you can quickly set up your system with the necessary software packages.

## Getting Started

To run this script, follow these easy steps:

1. **Make the Script Executable**: Open your terminal and navigate to the directory where the script is located. Then, make the script executable by running the following command:

sudo chmod +x InstallPackages.sh


2. **Run the Script**: Once the script is executable, you can execute it by running:

./InstallPackages.sh

## Customizing the Package List

You can customize the list of packages you want to install by editing the following sections in the `InstallPackages.sh` script:

```bash
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
 #this is packages from aur, add your own
 skypeforlinux-stable-bin
 github-desktop-bin
 code-marketplace
)
```




## What does the script do?

The script automates the package installation process on your Arch Linux system, saving you time and effort. It's a convenient tool for system setup and maintenance.

Please ensure that you are running this script with superuser privileges, as some packages may require elevated permissions for installation.

Enjoy your streamlined package installation process with **ArchSwiftSetup**!


