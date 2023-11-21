#!/bin/bash

set -e

USERHOME=$(echo $(getent passwd $USER )| cut -d : -f 6)

VIM_DATADIR="$USERHOME/.vim"
VIMRC="$USERHOME/.vimrc"

pip3 install pynvim

mkdir -p $VIM_DATADIR/autoload $VIM_DATADIR/bundle
curl -fLo $VIM_DATADIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp $(dirname $0)/_vimrc $VIMRC
