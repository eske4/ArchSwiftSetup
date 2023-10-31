# ArchSwiftSetup

## Overview

**ArchSwiftSetup** is a versatile script designed to simplify the process of setting up an Arch Linux system with essential software packages and configurations. With just a few simple steps, you can quickly configure your system, including Bluetooth support, C++ development tools, and more.

## Requirements

- **Arch Linux**: ArchSwiftSetup is intended for use on systems running Arch Linux. It is specifically designed and tested for Arch Linux, and while it may work on other Linux distributions, it's recommended to use it on Arch Linux for the best experience.
- **KDE Desktop Environment**: This script is optimized for Arch Linux systems with the KDE desktop environment. While it may work on other desktop environments, it's recommended to use it with KDE for the best experience.

## Key Features

- **Bluetooth Support**: ArchSwiftSetup includes configuration for Bluetooth, allowing you to easily enable and manage Bluetooth devices on your system.

- **C++ Development Environment**: If desired, you can set up a C++ development environment with a single prompt. The script installs essential C++ development tools and libraries, making it convenient for software development.

- **Preload Integration**: ArchSwiftSetup integrates with Preload, a program that helps improve system responsiveness by preloading often-used applications into memory.

- **Customizable Package List**: You can easily customize the list of packages you want to install by editing the script to fit your specific requirements.


## Getting Started

To run this script, follow these easy steps:

1. **Make the Script Executable**: Open your terminal and navigate to the directory where the script is located. Then, make the script executable by running the following command:

```
sudo chmod +x InstallPackages.sh
```

2. **Run the Script**: Once the script is executable, you can execute it by running:

```
./InstallPackages.sh
```

## Customizing the Package List

You can customize the list of packages you want to install by editing the following sections in the `InstallPackages.sh` script (located between lines 46 and 64):

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
 #this are packages from aur, add your own
 skypeforlinux-stable-bin
 github-desktop-bin
 code-marketplace
)
```




## What does the script do?

The script automates the package installation process on your Arch Linux system, saving you time and effort. It's a convenient tool for system setup and maintenance.


