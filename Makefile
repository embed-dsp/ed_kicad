
# Copyright (c) 2018-2019 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


PACKAGE_NAME = kicad

# Package version number (git master branch / git tag)
# PACKAGE_VERSION = master
# PACKAGE_VERSION = 5.0.2
PACKAGE_VERSION = 5.1.0

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

all:


.PHONY: pull
pull:
	# Discard any local changes
	# cd $(PACKAGE_NAME) && git checkout -- .
	cd $(PACKAGE_NAME) && git reset --hard
	
	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master
	
	# ...
	cd $(PACKAGE_NAME) && git pull


.PHONY: prepare
prepare:
	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE_VERSION)

	
.PHONY: configure
configure:
	mkdir -p build/release
	cd build/release && cmake -DCMAKE_INSTALL_PREFIX=/opt/$(PACKAGE_NAME)/$(PACKAGE) -DCMAKE_BUILD_TYPE=Release ../../$(PACKAGE_NAME)

	
.PHONY: compile
compile:
	cd build/release && make -j16


.PHONY: install
install:
	cd build/release && make -j8 install


.PHONY: clean
clean:
#	cd build/release && make -j4 clean
	-rm -rf build/release/*
