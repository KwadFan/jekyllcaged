#!/bin/bash
### Needed Functions for prepare.sh
## Copyright 2021 - KwadFan
## This File may distributed under GPLv3


### Colored Messages
function ok_msg() {
    echo -e "\e[32m"
    echo -e $@
    echo -e "\e[0m"
}

function warn_msg() {
    echo -e "\e[33m"
    echo -e $@
    echo -e "\e[0m"
}

function fail_msg() {
    echo -e "\e[31m"
    echo -e $@
    echo -e "\e[0m"
}

function launch_report() {
    ok_msg "Now open up your favorite Browser and navigate to"
    warn_msg "http://127.0.0.1:4000"
    warn_msg "Hit CTRL+C to kill the Instance."
}

### DEBUGGING
# Debugging
function enable_debugging() {
    case $DEBUG in
        
        Y | y | YES | yes) 
            warn_msg "DEBUG ON"
            set -x
        ;;
    esac
}

function health_check() {
    if [ $? -eq 0 ]; then
        ok_msg "... DONE!"
    else
        fail_msg "FAILED!"
        fail_msg "Exiting, turn on Debug to see Details!"
        exit 1
    fi
}

### Apt Update Func
function apt_update() {
    ok_msg "Updating apt database (apt update) ..."
    case $DEBUG in
        Y | y | YES | yes) 
            apt-get update
        ;;
        
        *)
            apt-get update -qq
        ;;
    esac
    health_check
}

### Install ENV Dependencies
function install_env_deps() {
    ok_msg "Installing Environment Dependencies..."
    case $DEBUG in
        Y | y | YES | yes) 
            apt-get install ${ENV_DEPS} -y 
        ;;
        
        *)
            apt-get -qq install ${ENV_DEPS} -y  > /dev/null 2>&1
        ;;
    esac
    health_check
}

### Install Jekyll Dependencies
function install_jekyll_deps() {
    ok_msg "Installing JEKYLL Dependencies..."
    case $DEBUG in
        Y | y | YES | yes) 
            apt-get install ${JEKYLL_DEPS} -y 
        ;;
        
        *)
            apt-get -qq install ${JEKYLL_DEPS} -y  > /dev/null 2>&1
        ;;
    esac
    health_check
}

# Check Clone Option and Clone
function gitclone() {
    case $CLONE_GIT in
        Y | y | YES | yes) 
                ok_msg "Cloning Repo '${MAINSAIL_REPO}'"
                git clone https://github.com/${MAINSAIL_REPO}.git
                health_check
        ;;
        
        *)
            warn_msg "Looking for local Workspace ( ./mainsail/ )"
            if [ -d $PWD/mainsail ]; then
                ok_msg "mainsail Directory found ..."
            else
                fail_msg "No usable Workspace found! Exiting!"
                exit 1
            fi
        ;;
    esac
}

function overide_root() {
    warn_msg "During clone as root, we have to provide rwx permissions ..."
    chmod -R 0766 $PWD/mainsail
    health_check
}

function install_gems() {
    ok_msg "Installing RubyGems ..."
    echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
        case $DEBUG in
        Y | y | YES | yes) 
            gem install jekyll bundler
        ;;
        
        *)
            gem install jekyll bundler  > /dev/null 2>&1
        ;;
    esac
    health_check
}

function setup_workspace() {
    cd $PWD/mainsail/docs
    ok_msg "Setup Jekyll Workspace ..."
    # Make sure Directory is not empty
    if [ -f Gemfile ]; then
            case $DEBUG in
            Y | y | YES | yes) 
                bundler install
            ;;
            
            *)
                bundler install  > /dev/null 2>&1
            ;;
            esac
        else
            fail_msg "Directory mainsail/docs is empty! Exiting!"
            exit 1
    fi
    health_check
}

function start_jekyll() {
    ok_msg "Starting Jekyll Application ..."
    launch_report
    case $DEBUG in
            Y | y | YES | yes) 
                bundler exec jekyll serve --host=0.0.0.0 --livereload \
                --livereload-min-delay 5 --livereload-max-delay 10
            ;;
            
            *)
                bundler exec jekyll serve --host=0.0.0.0 --livereload  \
                --livereload-min-delay 5 --livereload-max-delay 10 > /dev/null 2>&1
            ;;
    esac
}