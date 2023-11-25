# Makefile for Node.js project

# Variables
NODE_MODULES := node_modules
SRC := src
TEST := test
DIST := dist
PKG_MANAGER := npm

# Targets
.PHONY: install test clean

# Default target
default: install

# Install dependencies
install:
    $(PKG_MANAGER) install

# Run tests
test:
    $(PKG_MANAGER) test

# Clean up
clean:
    rm -rf $(NODE_MODULES) $(DIST)

# Build the application
build: clean
    $(PKG_MANAGER) run build

# Start the application
start:
    $(PKG_MANAGER) start
