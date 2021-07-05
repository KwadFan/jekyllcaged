#!/usr/bin/env bash
# 
# Setup a Docker Container to locally test Jekyll sites.
## Copyright 2021 - KwadFan
## This File may distributed under GPLv3


### Error Handling ( LEAVE THIS IN PLACE!)
set -e

### Source config
source $PWD/config

### import func.sh
source $PWD/lib/func.sh

#### Main Application
### Check for DEBUG Option
enable_debugging

### Apt Update
apt_update

# Install ENV Deps
install_env_deps

# Install Jekyll Deps
install_jekyll_deps

# Install RubyGems
install_gems

# Setup Workspace
gitclone
setup_workspace

# Start local Jekyll Server
start_jekyll