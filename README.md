
# Compile and Install of the KiCad Tool

This repository contains a **make** file for easy compile and install of [KiCad](http://kicad-pcb.org).


# Get Source Code

## ed_kicad

```bash
git clone https://github.com/embed-dsp/ed_kicad.git
```

## KiCad

```bash
# Enter the ed_kicad directory.
cd ed_kicad

# Edit the Makefile for selecting the KiCad source version.
vim Makefile
PACKAGE_VERSION = 7.0.1
```

```bash
# Download KiCad source package into src/ directory.
make download
```


# Build

```bash
# Unpack source code into build/ directory.
make prepare
```

```bash
# Configure source code.
make configure
```

```bash
# Compile source code.
make compile
```


# Install

```bash
# Install build products.
sudo make install
```


# Links

* https://dev-docs.kicad.org/en/build
* https://dev-docs.kicad.org/en/file-formats
