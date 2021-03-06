call pathogen#infect()

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
    set background=dark
    colorscheme solarized
    set number
endif

set undofile
set nobackup

set tabstop=4
set shiftwidth=4
set expandtab

syntax on
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
let g:syntastic_java_checkers=['']
let g:syntastic_go_checkers=['']
let g:neocomplete#enable_at_startup = 1

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

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Change directory to the current buffer when opening files.
set autochdir

