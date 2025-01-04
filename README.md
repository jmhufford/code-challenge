# Code Challenge
A simple, efficent, and reproducible build system using cmake and conan

## System Dependencies
This Project is designed to be built on Ubuntu 22.04 and requires the following system packages installed using
the apt package manager:

- python3.10-venv
- build-essential

## Quick start
To run a full build of the project, including testing the conan package and the creation of a Debian package:
`./full-build-and-package.sh`

Once done, install the Debian Package: `sudo apt install ./_packages/hivemindsdk_0.0.1_amd64.deb`

Finally run the `hivemind` executable! 

## Optimizations
The setup and build scripts are optimized to avoid redundant operations by checking for existing virtual environments,
dependencies, and build artifacts before running installation or build commands.

### Stats
#### Setup Script
`time ./setup.sh`

**First run:**

- real    0m7.213s
- user    0m5.531s
- sys     0m0.825s

**Second run:**

- real    0m7.213s
- user    0m5.531s
- sys     0m0.825s

#### Full Build and Package Script
`time ./full-build-and-package.sh`


**First run:**

- real    0m11.309s
- user    0m9.125s
- sys     0m1.296s

**Second run:**

- real    0m2.575s
- user    0m2.220s
- sys     0m0.257s

## Setup
To set up the build envrionment run `./setup.sh` to generate the python virtual environment, install python
dependencies, and cmake.

Once the virtual environment is created activate it by running `. .venv/bin/activate`

## Building
### Building for Debug
To build this project for debug run the following commands:

- `conan install . -s build_type=Debug --build=missing`
- `cmake --preset conan-debug`
- `cmake --build --preset conan-debug`

### Building for Release
To build this project for Release run the following commands:

- `conan install . --build=missing`
- `cmake --preset conan-release`
- `cmake --build --preset conan-release`

## Packaging
### Conan
To export the conan recipe to the local cache: `conan export .`

To export the recipe and to build and test the binaies: `conan create .`

To manually run the package tests: `conan test test_package/ hivemind/0.0.1`

### Debian
To build a Debian package the project must first be built for release. See Building for Release above.

Next call CPack by running `cd build/Release && cpack -G DEB && cd -`

The built package will be stored in `_packages` directory

## Installing
### Conan
To install the Conan package: `conan install --requires=hivemind/0.0.1`

If just the recipe has been exported or binaies for your configuration are not availible:
`conan install --requires=hivemind/0.0.1 --build=missing`

### Debian
To install the built Debian package to your system run `sudo apt install ./_packages/hivemindsdk_0.0.1_amd64.deb`

## Running
### Conan
With the conan package installed source the generated conanrun.sh script by runnning `. conanrun.sh`

Now you should be able to run the `hivemind` executable

### Debian
If the Debian package has been installed simply run the executable `hivemind` assumind the installed location
`/usr/local/bin/` is on your path

## Uninstalling
### Conan
To uninstall the conan package from the cache: `conan remove hivemind/0.0.1 -c`

### Debian
To uninstall the Debian package: `sudo apt remove hivemindsdk`
