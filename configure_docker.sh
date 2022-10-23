#!/bin/bash
# Script to configure seccomp & apparmor profiles to run transaction tests in docker-based enterprise agents
#
# (C) 2020 ThousandEyes, Inc.
#

################################################################################
# Terminal output helpers
################################################################################

# echo_title() outputs a title padded by =, in yellow.
echo_title() {
    TITLE=$1
    NCOLS=$(tput cols)
    NEQUALS=$(((NCOLS-${#TITLE})/2-1))
    EQUALS=$(printf '=%.0s' $(seq 1 $NEQUALS))
    tput setaf 3  # 3 = yellow
    echo "$EQUALS $TITLE $EQUALS"
    tput sgr0  # reset terminal
}

# echo_step() outputs a step collored in cyan, without outputing a newline.
echo_step() {
    tput setaf 6  # 6 = cyan
    echo -n "$1"
    tput sgr0  # reset terminal
}

# echo_step_info() outputs additional step info in cyan, without a newline.
echo_step_info() {
    tput setaf 6  # 6 = cyan
    echo -n " ($1)"
    tput sgr0  # reset terminal
}

# echo_right() outputs a string at the rightmost side of the screen.
echo_right() {
    TEXT=$1
    echo
    tput cuu1
    tput cuf "$(tput cols)"
    tput cub ${#TEXT}
    echo "$TEXT"
}

# echo_failure() outputs [ FAILED ] in red, at the rightmost side of the screen.
echo_failure() {
    tput setaf 1  # 1 = red
    echo_right "[ FAILED ]"
    tput sgr0  # reset terminal
}

# echo_success() outputs [ OK ] in green, at the rightmost side of the screen.
echo_success() {
    tput setaf 2  # 2 = green
    echo_right "[ OK ]"
    tput sgr0  # reset terminal
}

echo_warning() {
    tput setaf 3  # 3 = yellow
    echo_right "[ WARNING ]"
    tput sgr0  # reset terminal
    echo "    ($1)"
}

# exit_with_message() outputs and logs a message before exiting the script.
exit_with_message() {
    echo -e "\n$1"
    exit 1
}

# exit_with_failure() calls echo_failure() and exit_with_message().
exit_with_failure() {
    echo_failure
    exit_with_message "FAILURE: $1" 1
}

################################################################################
# System utils
################################################################################

# command_exists() tells if a given command exists.
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

################################################################################
# Installation steps
################################################################################

# verifies if the script is being run as root and exits
# otherwise (i.e. die).
check_if_root_or_die() {
    echo_step "Checking installation privileges"

    if [ "$EUID" -ne 0 ]; then
        exit_with_failure "Installer must be run as root"
    fi
    echo_success
}

# verifies that curl is installed
# otherwise (i.e. die).
check_curl_installed_or_die() {

    if ! command_exists curl; then
        exit_with_failure "The installer requires curl to donwload config files"
    fi
}

# detects if apparmor is installed
detect_apparmor() {
    echo_step "Detecting if apparmor is installed"
    echo $APPARMOR_PARSER_INSTALLED
    if command_exists apparmor_parser; then
        if [ -d "/etc/apparmor.d" ]; then
    	   APPARMOR_INSTALLED=true
    	   echo_step_info "apparmor is installed"
        fi
    fi
    if [ ! APPARMOR_INSTALLED ]; then
      echo_step_info "apparmor is not installed"
    fi
    echo_success
}

# creates a working directory to place seccomp & apparmor config files
create_working_dir() {
    echo_step "Creating working directory [/var/docker/configs]"

    if [ ! -d "/var/docker/configs" ]; then
    	mkdir -p /var/docker/configs
    else
      echo_step_info "Working directory already exists"
    fi
    echo_success
}

# downloads a config files from /bbot resources
check_config_file() {

    if [ ! -f "/var/docker/configs/$1" ]; then
        echo_step_info "downloading $1"
        curl -o "/var/docker/configs/$1" "https://downloads.thousandeyes.com/bbot/$1"
    else
        echo_step_info "$1 already downloaded"
    fi

}

# downloads seccomp & apparmor config files
check_config_files() {
    echo_step "Checking existence of config files"

    check_config_file "te-seccomp.json"

    if [ APPARMOR_INSTALLED ]; then
      check_config_file "te-apparmor.cfg"
      cp -f "/var/docker/configs/te-apparmor.cfg" "/etc/apparmor.d/te-apparmor.cfg"
    fi

    echo_success
}

# apply apparmor profile if exists
apply_apparmor_if_exists() {
    if [ APPARMOR_INSTALLED ]; then
        echo_step "Applying apparmor config"

        apparmor_parser -r -W /etc/apparmor.d/te-apparmor.cfg

        if [[ $(apparmor_status | grep docker_sandbox) ]]; then
            echo_step_info "docker_sandbox successfully applied"
        else
            echo_warning "docker_sandbox config was not applied"
        fi

        echo_success
    fi
}

################################################################################
# Installation execution
################################################################################

echo_title "Welcome to ThousandEyes"
check_if_root_or_die
check_curl_installed_or_die
detect_apparmor
create_working_dir
check_config_files
apply_apparmor_if_exists
echo -e "\n"
