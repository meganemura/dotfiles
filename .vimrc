" Vimrc
" =====

autocmd!

" NeoBundle Configurations
" ========================
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

let g:neobundle_default_git_protocol='https'

if filereadable(expand('~/.vim/Neobundle'))
    source ~/.vim/Neobundle
endif

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' . string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif


" Basic Configurations
" ====================
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

set smartindent
set autoindent

set t_Co=256
syntax enable
set background=dark
silent! colorscheme molokai

set termencoding=utf-8
set encoding=utf-8
set fileencoding=japan
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

set wildmode=list:longest,full
set wildignore+=*.pyc

set nrformats=hex

set nobackup
set directory=~/.vim/tmp

set pastetoggle=<F1>

inoremap # a<BS>#

" Mouse Support
" =============

" See https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" CursorLine
" ----------
set cursorline
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

highlight TODO ctermfg=red guifg=red

" Search Configurations
" ---------------------
set smartcase
set incsearch
set hlsearch
noremap n nzz
noremap N Nzz
noremap * *zz
noremap # #zz
nmap <ESC><ESC> :nohlsearch<Return><ESC>

" Tabpage Configurations
" ----------------------
set showtabline=2 " Always show tabline
set guioptions-=e
noremap <Space>d :quit<Return><C-g>
noremap <Space>n :tabnext<Return><C-g>
noremap <Space>p :tabprevious<Return><C-g>
noremap <Space>c :tabedit<Return><C-g>

function! OpenLeftTab()
    if tabpagenr() == 1
        0tabedit
    else
        tabprevious
        tabedit
    endif
endfunction
noremap <Space>C :call OpenLeftTab()<Return><C-g>
" Open most recent edited tab.
noremap <Space>t :tabedit #<Return><C-g>


" Recently Configurations
" =======================

" vim-users.jp/hack74 
" -------------------
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>

" Set augroup.
augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

" vim-users.jp/hack17
" -------------------
" Usage: :Rename newfilename.txt
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" vim-users.jp/hack122
" --------------------
nnoremap Y y$


" Plugin Configurations
" =====================

" unite.vim
" ---------
let g:unite_enable_start_insert=1
let g:unite_enable_split_vertically=0
let g:unite_source_file_mru_time_format='(%Y/%m/%d %T) '
nnoremap <silent> <C-n>      :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
inoremap <silent> <C-n> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <C-p>      :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-p> <ESC>:<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <C-t>      :<C-u>Unite tab<CR>

" neocomplcache
" -------------
let g:neocomplcache_enable_at_startup=1

" easymotion
" ----------
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm'

" ftdetects
" ---------
augroup MyFileTypeDetect
    autocmd!

    autocmd BufNewFile,BufRead *.wsgi   set filetype=python
    autocmd BufNewFile,BufRead *.zj     set filetype=ruby

    " tracwiki
    autocmd BufNewFile,BufRead [tT]icket_*.txt setfiletype tracwiki
    autocmd BufNewFile,BufRead [tT]icket_*.txt set shiftwidth=2

    " textile
    autocmd! BufNewFile,BufRead [iI]ssue_*.txt setfiletype textile
    autocmd! BufNewFile,BufRead [rR]edmine_*.txt setfiletype textile
augroup END
