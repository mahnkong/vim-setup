call plug#begin()
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'yegappan/mru'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/YankRing.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'pearofducks/ansible-vim'


let g:deoplete#enable_at_startup = 1
call plug#end()

filetype plugin indent on

set nocompatible

if has("win32")
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    au GUIEnter * simalt ~x
    let g:tagbar_ctags_bin = "$VIMRUNTIME/../../../ctags.exe"
endif

if has('gui_running')
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    if has("win32")
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    endif

    set number
endif

set background=dark
colorscheme solarized

set undofile
set nobackup

set tabstop=4
set shiftwidth=4
set expandtab

syntax enable
set modifiable
set clipboard=unnamedplus

map <F3> :set paste<CR>
map <F4> :set nopaste<CR>
map <F5> :NERDTreeFocusToggle<CR>
map <F6> :MRU<CR>
map <F7> :SyntasticCheck<CR>
map <F8> :TagbarToggle<CR>
map <F10> :YRShow<CR>

let mapleader = ","

let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_autofind = 1

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
" let g:syntastic_java_checkers=['']
" let g:syntastic_go_checkers=['']

set completeopt-=preview
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd BufWritePre * %s/\s\+$//e

au FileType yaml setl sw=2 sts=2 et


call neomake#configure#automake('nrwi', 500)

" Change directory to the current buffer when opening files.
set autochdir

