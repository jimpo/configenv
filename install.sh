#!/bin/sh

# emacs 24
add-apt-repository ppa:cassou/emacs
apt-get update
apt-get install emacs24 emacs24-el emacs24-common-non-dfsg

# zsh, git, curl
apt-get install zsh git-core, curl
