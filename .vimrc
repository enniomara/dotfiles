let g:mapleader = " " " Set leader key to space

call plug#begin('~/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
" {{{
    nnoremap <silent> <leader><space> :GFiles<CR> 
    nnoremap <silent> <C-p> :FZF<CR>
" }}}
call plug#end()

set autoread

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

set expandtab " Expand tab characters to space characters.
set shiftwidth=4 " One tab is now 4 spaces.
set shiftround " Always round up to the nearest tab.
set tabstop=4 " This one is also needed to achieve the desired effect.
set softtabstop=4 " Enables easy removal of an indentation level.

set autoindent " Automatically copy the previous indent level. Don't use smartindent!!!
set backspace=2 " Used for making backspace work like in most other editors (e.g. removing a single indent).
set wrap " Wrap text. This is also quite optional, replace with textwidth=80 is you don't want this behaviour.
set lazyredraw " Good performance boost when executing macros, redraw the screen only on certain commands.

set ignorecase " Search is not case sensitive, which is usually what we want.
set incsearch " Enables the user to step through each search 'hit', usually what is desired here.
set hlsearch " Will stop highlighting current search 'hits' when another search is performed.

set scrolloff=10 " The screen will only scroll when the cursor is 8 characters from the top/bottom.
set wildmenu " Enable the 'autocomplete' menu when in command mode (':').
set number " Show line numbers on left side
" set cursorline " Highlight line the cursor is currently at
set foldcolumn=1 " Add a bit extra margin to the left

set laststatus=2 " Always show statusline
set updatetime=500 " Set this to 500 milliseconds so that git gutter can update the gutter

set mouse=a

syntax on " The most important feature when coding. Vim please bless us with this option right now!.
colorscheme codedark

" Smart way to move between panes 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

let NERDTreeShowHidden=1

" Remappings
noremap <silent> <leader>d :silent! NERDTreeToggle<cr>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Remap VIM 0 to first non-blank character
map 0 ^ 
