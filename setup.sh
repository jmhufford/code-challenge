#!/usr/bin/env bash

# Exit on error
set -e

# Check if virtual environment already exists
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    echo "Virtual environment created"
else
    echo "Virtual environment already exists"
fi

# Activate the virtual environment
. .venv/bin/activate
echo "Virtual environment activated"

# Upgrade pip if needed 
echo "Upgrading Pip"
pip install --upgrade pip

# Check if CMake is already installed in the virtual environment
if [ ! -f ".venv/bin/cmake" ]; then
    echo "Installing CMake in virtual environment"
    cd .venv
    if [ ! -f "cmake-3.31.2-linux-x86_64.tar.gz" ]; then
        wget https://github.com/Kitware/CMake/releases/download/v3.31.2/cmake-3.31.2-linux-x86_64.tar.gz
    fi
    tar --strip-components=1 -xf cmake-3.31.2-linux-x86_64.tar.gz
    rm cmake-3.31.2-linux-x86_64.tar.gz
    cd ..
else
    echo "CMake is already installed in the virtual environment"
fi

# Check if Conan is installed and available
if ! command -v conan &>/dev/null; then
    echo "Conan is not installed. Installing Conan"
    pip install conan
else
    echo "Conan is already installed"
fi

# Set Conan profile if not already set
if [ ! -f "$HOME/.conan2/profiles/default" ]; then
    echo "Setting Conan profile"
    conan profile detect
else
    echo "Conan profile already set"
fi

# Final message
echo "Setup complete. Activate the environment by running '. .venv/bin/activate'"

