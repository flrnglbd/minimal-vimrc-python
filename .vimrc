set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"Bundle 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'alvan/vim-closetag'
Plugin 'dracula/vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'vim-ruby/vim-ruby'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

syntax on
color dracula
set encoding=utf-8

set completeopt+=menuone
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
" start autocomplete at start

set undodir=~/.vimtmp,.
set undofile
set backupdir=~/.vimtmp,.
set directory=~/.vimtmp,. 
set number
set relativenumber
set syntax=on
set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab
set smarttab
set softtabstop=4
set autoindent
set background=dark

filetype plugin indent on

let g:solarized_termcolors=256

" fix color background issue with kitty
let &t_ut=''

