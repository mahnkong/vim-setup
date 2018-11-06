#!/bin/bash

set -e

USERHOME=$(echo $(getent passwd $USER )| cut -d : -f 6)

VIM_DATADIR="$USERHOME/.vim"
VIMRC="$USERHOME/.vimrc"

if [ "$1" != "" ]; then
    VIM_DATADIR="$1/Data/settings/vimfiles"
    VIMRC="$1/Data/settings/_vimrc"
fi

mkdir -p $VIM_DATADIR/autoload $VIM_DATADIR/bundle
curl -LSso $VIM_DATADIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cp $(dirname $0)/_vimrc $VIMRC

for plugin in yegappan/mru scrooloose/syntastic ervandew/supertab Raimondi/delimitMate majutsushi/tagbar fatih/vim-go scrooloose/nerdtree vim-scripts/YankRing.vim Shougo/neocomplete.vim altercation/vim-colors-solarized.git vim-airline/vim-airline rodjek/vim-puppet saltstack/salt-vim; do
    echo "Plugin: $plugin"
    git -C $VIM_DATADIR/bundle/$(basename $plugin) pull || git clone --depth 1 https://github.com/$plugin $VIM_DATADIR/bundle/$(basename $plugin) 
done
