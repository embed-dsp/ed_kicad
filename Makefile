
# Copyright (c) 2018-2023 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>

# https://dev-docs.kicad.org/en/build

PACKAGE_NAME = kicad

PACKAGE_VERSION = 7.0.1

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
	SYSTEM = mingw32
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif
ifeq ($(findstring CYGWIN, $(shell uname -s)), CYGWIN)
	SYSTEM = cygwin
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# Compiler.
CFLAGS = -Wall -O2
CXXFLAGS = -Wall -O2

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /opt
endif

# Installation directory.
PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)

# ==============================================================================

all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make download"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo ""


.PHONY: download
download:
	-mkdir src
	cd src && wget -nc https://gitlab.com/kicad/code/kicad/-/archive/$(PACKAGE_VERSION)/$(PACKAGE).tar.gz


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(PACKAGE).tar.gz


.PHONY: configure
configure:
# FIXME: -DKICAD_SPICE=ON
	-mkdir -p build/$(PACKAGE)-obj
	cd build/$(PACKAGE)-obj && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$(PREFIX) -DKICAD_SPICE=OFF ../$(PACKAGE)


.PHONY: compile
compile:
	cd build/$(PACKAGE)-obj && make -j$(J)


.PHONY: install
install:
	cd build/$(PACKAGE)-obj && make install


.PHONY: clean
clean:
	-rm -rf build/$(PACKAGE)-obj

# ==============================================================================

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find GLEW (missing: GLEW_INCLUDE_DIR GLEW_LIBRARY)
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   cmake/FindGLEW.cmake:38 (find_package_handle_standard_args)
#   CMakeLists.txt:720 (find_package)
# sudo dnf install glew
# sudo dnf install glew-devel

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find GLM (missing: GLM_INCLUDE_DIR GLM_VERSION) (Required is at
#   least version "0.9.8")
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   cmake/FindGLM.cmake:54 (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
#   CMakeLists.txt:728 (find_package)
# sudo dnf install glm-devel

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find Boost (missing: Boost_INCLUDE_DIR) (Required is at least
#   version "1.71.0")
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   /usr/share/cmake/Modules/FindBoost.cmake:2377 (find_package_handle_standard_args)
#   CMakeLists.txt:756 (find_package)
# sudo dnf install boost
# sudo dnf install boost-devel

# *** NGSPICE library missing ***
# Most of ngspice packages do not provide the required libngspice library.
# You can either compile ngspice configured with --with-ngshared parameter
# or run a script that does the job for you:
#   cd ./tools/build
#   chmod +x get_libngspice_so.sh
#   ./get_libngspice_so.sh
#   sudo ./get_libngspice_so.sh install

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find ngspice (missing: NGSPICE_INCLUDE_DIR)
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   cmake/Findngspice.cmake:162 (find_package_handle_standard_args)
#   CMakeLists.txt:779 (find_package)

# *** OpenCascade library missing ***
# Verify your OpenCascade installation or pass CMake
#   the library directory as '-DOCC_LIBRARY_DIR=<path>'

# CMake Error at cmake/FindOCC.cmake:148 (message):
# Call Stack (most recent call first):
#   CMakeLists.txt:783 (find_package)
# sudo dnf install opencascade-devel

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find SWIG (missing: SWIG_EXECUTABLE SWIG_DIR) (Required is at
#   least version "4.0")
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   cmake/FindSWIG.cmake:93 (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
#   CMakeLists.txt:820 (find_package)
# sudo dnf install swig

# CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
#   Could NOT find wxWidgets (missing: wxWidgets_LIBRARIES
#   wxWidgets_INCLUDE_DIRS) (Required is at least version "3.2.1")
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
#   cmake/FindwxWidgets.cmake:960 (find_package_handle_standard_args)
#   CMakeLists.txt:939 (find_package)
# sudo dnf install wxGTK-devel

# sudo dnf install unixODBC-devel
