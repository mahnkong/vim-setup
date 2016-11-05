#!/bin/bash

mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cp $(dirname $0)/_vimrc $HOME/.vimrc

for plugin in tpope/vim-endwise yegappan/mru scrooloose/syntastic ervandew/supertab Raimondi/delimitMate majutsushi/tagbar fatih/vim-go scrooloose/nerdtree jistr/vim-nerdtree-tabs vim-scripts/YankRing.vim fatih/vim-go.git Shougo/neocomplete.vim rodjek/vim-puppet.git; do
    rm -rf $HOME/.vim/bundle/$(basename $plugin)
    git clone --depth 1 https://github.com/$plugin $HOME/.vim/bundle/$(basename $plugin)
done
