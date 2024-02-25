#!/bin/sh


# https://gist.github.com/nicktoumpelis/11214362#file-repo-rinse-sh

git clean -xfd
git submodule foreach --recursive git clean -xfd
git reset --hard
git submodule foreach --recursive git reset --hard
git submodule update --init --recursive



