#!/bin/bash

VIM_DATADIR="$HOME/.vim"
VIMRC="$HOME/.vimrc"

if [ "$1" != "" ]; then
    VIM_DATADIR="$1/Data/settings/vimfiles"
    VIMRC="$1/Data/settings/_vimrc"
fi

mkdir -p $VIM_DATADIR/autoload $VIM_DATADIR/bundle
curl -LSso $VIM_DATADIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cp $(dirname $0)/_vimrc $VIMRC

for plugin in tpope/vim-endwise yegappan/mru scrooloose/syntastic ervandew/supertab Raimondi/delimitMate majutsushi/tagbar fatih/vim-go scrooloose/nerdtree jistr/vim-nerdtree-tabs vim-scripts/YankRing.vim fatih/vim-go.git Shougo/neocomplete.vim rodjek/vim-puppet.git tfnico/vim-gradle altercation/vim-colors-solarized.git; do
    echo "Plugin: $plugin"
    git -C $VIM_DATADIR/bundle/$(basename $plugin) pull || git clone --depth 1 https://github.com/$plugin $VIM_DATADIR/bundle/$(basename $plugin) 
done
