" boot
autocmd!

" NeoBundle
" ---------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

if filereadable(expand('~/.vim/Neobundle'))
  source ~/.vim/Neobundle
endif

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" NeoBundleInstall
if neobundle#exists_not_installed_bundles()
  autocmd VimEnter * NeoBundleInstall
endif


" tab, encoding, etc...
" ------------------
set nobackup
set directory=~/.vim/tmp

" vim-users.jp/hack162
if has('persistent_undo')
  set undodir=~/.vim/undo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

set smartindent
set autoindent

set termencoding=utf-8
set encoding=utf-8
set fileencoding=japan
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
autocmd BufWritePre * :%s/\s\+$//e

set wildmode=list:longest,full
set wildignore+=*.pyc

set backspace=indent,eol,start
set nrformats=hex

set ambiwidth=double

let mapleader = "\<Space>"
inoremap # a<BS>#
set pastetoggle=<F1>
nmap <Leader>l :<C-u>set invnumber<Return>

set laststatus=2
set t_Co=256
syntax enable
"silent! colorscheme molokai
"colorscheme desert
"colorscheme railscasts
set background=dark
colorscheme gruvbox


" Mouse Support
" -------------
" See https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter    * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter    * set ttymouse=xterm2
  endif
endif


" CursorLine
" ----------
"set cursorline
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

highlight TODO ctermfg=red guifg=red


" Search
" ------
set smartcase
set incsearch
set hlsearch
noremap n nzz
noremap N Nzz
noremap * *zz
noremap # #zz
nnoremap <ESC><ESC> :<C-u>nohlsearch<Return><ESC>
noremap <F5> :e<Return>zz


" Tabpage
" -------
set showtabline=2 " Always show tabline
set guioptions-=e

noremap <Leader>c :<C-u>tabnew<Return>
noremap <Leader>d :<C-u>quit<Return>
noremap <Leader>D :<C-u>quit!<Return>
noremap <Leader>n :<C-u>tabnext<Return>
noremap <Leader>p :<C-u>tabprevious<Return>
noremap <Leader>q :<C-u>:quitall<Return>


" vim >= 7.3
noremap <Leader>> :<C-u>tabmove +1<Return>
noremap <Leader>< :<C-u>tabmove -1<Return>

function! s:left_tabnew()
  if tabpagenr() == 1
    0tabnew
  else
    tabprevious
    tabnew
  endif
endfunction
noremap <Leader>C :<C-u>call <SID>left_tabnew()<Return>


" Utility
" -------
imap <silent> <C-d><C-d> <C-r>=strftime("%Y-%m-%d")<Return>

" Ruby
imap <silent> <C-l> <Space>=><Space>
imap <silent> <C-p> require 'pry'; binding.pry

" Easy to edit vimrc (vim-users.jp/hack74)
" ----------------------------------------
nnoremap <silent> <Leader>ev :<C-u>edit $MYVIMRC<Return>

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


" Rename file (vim-users.jp/hack17)
" ---------------------------------
" Usage: :Rename newfilename.txt
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))


" Yank until the end of line (vim-users.jp/hack122)
" -------------------------------------------------
nnoremap Y y$

" http://itchyny.hatenablog.com/entry/2014/12/25/090000
set showmatch
set matchtime=1

" Plugin Configurations
" =====================

" unite.vim
" ---------
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\ })
nnoremap <silent> <C-n>      :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
inoremap <silent> <C-n> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
"nnoremap <silent> <C-p>      :<C-u>Unite file_rec/async<CR>
"inoremap <silent> <C-p> <ESC>:<C-u>Unite file_rec/async<CR>
nnoremap <silent> <C-t>      :<C-u>Unite tab<CR>

nnoremap <silent> ,g         :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg        :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-r><C-w><CR>
nnoremap <silent> ,r         :<C-u>UniteResume search-buffer<CR>

if executable('pt')
  let g:unite_source_rec_async_command  = 'pt --nocolor --nogroup -g .'
  let g:unite_source_grep_command       = 'pt'
  let g:unite_source_grep_default_opts  = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Overwrite settings.
  imap <buffer>         <C-w> <Plug>(unite_delete_backward_path)
  imap <buffer>         '     <Plug>(unite_quick_match_default_action)
  imap <buffer><nowait> <C-g> <Plug>(unite_exit)
endfunction


" neocomplcache
" -------------
let g:neocomplcache_enable_at_startup=1


" neocomplete
let g:neocomplete#enable_at_startup = 1


" vim-airline
" -----------
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" vim-javascript
" --------------
let g:javascript_plugin_flow = 1

" ftdetects
" ---------
augroup MyFileTypeDetect
  autocmd!

  autocmd BufNewFile,BufRead .git_* set filetype=gitconfig
  autocmd BufNewFile,BufRead *.wsgi set filetype=python
  autocmd BufNewFile,BufRead *.zj   set filetype=ruby
  autocmd BufNewFile,BufRead *.gemfile   set filetype=ruby
  autocmd BufNewFile,BufRead *.opal set filetype=ruby
  autocmd BufNewFile,BufRead *.json set filetype=javascript
  autocmd BufNewFile,BufRead *.go   set noexpandtab tabstop=4 shiftwidth=4

  " Markdown
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  " tracwiki
  autocmd BufNewFile,BufRead [tT]icket_*.txt  setfiletype tracwiki
  autocmd BufNewFile,BufRead [tT]icket_*.txt  set shiftwidth=2
  autocmd BufNewFile,BufRead *.wiki           setfiletype tracwiki
  autocmd BufNewFile,BufRead *.wiki           set shiftwidth=2

  " textile
  autocmd! BufNewFile,BufRead [iI]ssue_*.txt    setfiletype textile
  autocmd! BufNewFile,BufRead [rR]edmine_*.txt  setfiletype textile
augroup END


if filereadable(expand('~/.vim/local.vim'))
    source ~/.vim/local.vim
endif

" fix typo
" abbreviate: insert and command line mode
" iabbrev:    insert mode
" cabbrev:    command line mode
iabbrev fitler  filter
iabbrev Usre    User
iabbrev usre    user
iabbrev usre_id user_id

" define commands for typo
" http://vim-jp.org/vimdoc-ja/map.html#user-commands
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Lw w<bang>
command! -bang LW w<bang>

" QuickFix
set grepprg=grep\ -rnH
noremap <Leader>g :<C-u>:copen<Return>

" fugitive
noremap <Leader><Leader>s :<C-u>:Gstatus<Return>
noremap <Leader><Leader>d :<C-u>:Gdiff<Return>

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" increment-activator
let g:increment_activator_filetype_candidates = {
\   'ruby': [
\     ['describe', 'context'],
\     ['should',   'should_not'],
\     ['to',       'not_to'],
\   ],
\}

" vim-altr
nmap <F2> <Plug>altr#forward()
nmap <F3> <Plug>altr#back()
call altr#remove_all()
call altr#define('lib/%.rb',
\                'spec/%_spec.rb')

" vim-gitgutter
noremap <Leader><Leader>g :<C-u>GitGutterToggle<Return>
set signcolumn=yes
" let g:gitgutter_sign_column_always = 1
" vim-gitgutter: please replace "let g:gitgutter_sign_column_always=1" with "set signcolumn=yes"

" caw.vim
nmap <Leader>/ <Plug>(caw:I:toggle)
vmap <Leader>/ <Plug>(caw:I:toggle)
