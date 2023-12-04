#!/bin/bash


export __local="$HOME/__local"
export __archive="$HOME/__archive/archive"
export __sensitive="$HOME/__archive/sensitive"
export __distro=$(<"$__local/distro.txt")
export __distro_storage="$__archive/storage-linux/$__distro"

PATH="$__archive/tool-linux/bin:$PATH"
PATH="$__archive/tool-linux/build_bin:$PATH"

export TIME_NAME="time-linux"



# "strategic micro update"
svn update "$__archive/hi5"
svn update "$__archive/lemon"
svn update "$__operating-system/operating-system-linux"
svn update "$__archive/storage-linux"
svn update "$__archive/tool-linux"

sleep 1s


watch_build &



