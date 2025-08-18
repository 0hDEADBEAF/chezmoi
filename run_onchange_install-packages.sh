#!/bin/bash

# Update packages/system
sudo pacman -Syu

# Install yay
mkdir -p ~/src
cd ~/src
if [ ! -d "yay" ]; then
	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay-git ~/src/yay
	cd yay
	makepkg -si
fi

# Update yay packages
yay

# Install packages
# git: Of course!
# kitty: My favorite terminal
# nvim: The best editor
# librewolf-bin: The best browser (compiling from source takes hours so using the bin only)
# mold: The best linker
# bat: A better 'cat' command
# ripgrep: A better 'grep' command
# fd: A better 'find' command
# zoxide: A better 'cd' command
# eza: A better 'ls' command
# yazi: My favorite file manager
# zsh: My favorite shell
# fzf: A very nice tool :D
# xcursor-hackneyed-light: My favorite cursor
# rustup: To manage Rust toolchains & all
# python: All my homies love Python!
# python-pip: Python's package manager
# python-requests: requests package (used to communicate with Youtube Music API server)
# ags-hyprpanel-git: A nice tool for status bar & widgets
# youtube-music-bin: A Youtube Music client with an ad blocker, downloader & a lot of plugins
# less: A nice command to have!
# otf-departure-mono: A nice looking old school font!
# hyprlock: A nice lock screen software
# wofi: An application launcher for wayland
# btop: To get a nice overview of the system performance 
# fastfetch: Just to make sure I'm using arch
# chafa: Image output as ascii art
# ddcutil: Brightness detection of external displays
# directx-headers: GPU detection in WSL
# imagemagick: Image output using sixel or kitty graphics protocol
# torbrowser-launcher: Privacy at its best
# wlr-randr: Used to fetch monitors resolution & physical size
yay -Sy \
    kitty \
    nvim \
    librewolf-bin \
    mold \
    bat \
    ripgrep \
    fd \
    zoxide \
    eza \
    yazi \
	zsh \
	fzf \
    xcursor-hackneyed-light \
    rustup \
    python \
	python-pip \
	python-requests \
	ags-hyprpanel-git \
	youtube-music-bin \
	less \
	otf-departure-mono \
	hyprlock \
	wofi \
	btop \
	fastfetch \
	chafa \
	ddcutil \
	imagemagick \
	torbrowser-launcher \
	wlr-randr

# Setting default Rust toolchain to stable
rustup default stable

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup fzf for zsh
zsh -c "source <(fzf --zsh)"

# Enabling required services
sudo systemctl enable bluetooth.service

