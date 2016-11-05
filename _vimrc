call pathogen#infect()

filetype plugin indent on

set nocompatible

set undofile
set nobackup

set tabstop=4
set shiftwidth=4
set expandtab
syntax on

set modifiable

map <A-Left> :tabprev<CR>
map <A-Right> :tabnext<CR>
map <A-Down> :NERDTreeFocusToggle<CR>

map <F3> :s/^/#/<CR>
map <F4> :s/#//<CR>
map <F6> :MRU<CR>
map <F7> :SyntasticCheck<CR>
map <F10> :YRShow<CR>
map <F12> :TagbarToggle<CR>

let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_autofind = 1

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_puppet_checkers = ['puppet']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']

autocmd VimEnter ruby nested :call tagbar#autoopen(1)
autocmd FileType ruby nested :call tagbar#autoopen(0)
autocmd VimEnter javascript nested :call tagbar#autoopen(1)
autocmd FileType javascript nested :call tagbar#autoopen(0)

au FileType yaml setl sw=2 sts=2 et

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

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

