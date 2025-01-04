#!/usr/bin/env bash

# Exit on error
set -e

# Source setup script
if [ -f "setup.sh" ]; then
    . setup.sh
else
    echo "Error: setup.sh not found."
    exit 1
fi

# Build project only if necessary
echo "Checking for Conan dependencies"
if [ ! -d "build/Release/generators" ]; then
    echo "Installing Conan dependencies"
    conan install . --build=missing
else
    echo "Conan dependencies already installed"
fi

echo "Configuring project with CMake"
if [ ! -f "build/Release/CMakeCache.txt" ]; then
    cmake --preset conan-release
else
    echo "CMake project already configured"
fi

echo "Building project"
cmake --build --preset conan-release

echo "Creating Conan package"
conan create .

# Create .deb package only if not already created
echo "Checking for .deb package"
DEB_PACKAGE="_packages/hivemindsdk_*.deb"
if ls $DEB_PACKAGE >/dev/null 2>&1; then
    echo ".deb package already exists"
else
    echo "Creating .deb package"
    (cd build/Release && cpack -G DEB)
fi

echo "Build and packaging complete"
