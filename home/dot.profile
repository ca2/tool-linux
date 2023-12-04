# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi



export __application="$HOME/application"
export __archive_root="$HOME/__archive"
export __archive="$__archive_root/archive"
export __basis="$__archive_root/basis"
export __sensitive="$__archive_root/sensitive"
export __config="$HOME/__config"
export __distro=$(<"$__config/distro.txt")
export __distro_storage="$__archive/storage-linux/$__distro"

PATH="$__archive/tool-linux/bin:$PATH"
PATH="$__archive/tool-linux/build_bin:$PATH"

export TIME_NAME="time-linux"



# "strategic micro update"
svn update "$__operating-system/operating-system-linux"
svn update "$__archive/storage-linux"
svn update "$__archive/tool-linux"

sleep 1s


watch_build &




