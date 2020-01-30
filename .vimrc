set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Theme
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'christoomey/vim-sort-motion'
Plugin 'christoomey/vim-system-copy'
Plugin 'arzg/vim-substrata'

Plugin 'elixir-editors/vim-elixir'
Plugin 'slashmili/alchemist.vim'

Plugin 'vim-scripts/ReplaceWithRegister'

Plugin 'benmills/vimux'

" Stat
" Plugin 'wakatime/vim-wakatime'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype on

" Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

syntax enable
set background=dark
colorscheme substrata
let g:solarized_termcolors=256

set encoding=utf-8
set completeopt+=menuone

" Display all matching files when we use tab complete
set wildmenu
set wildcharm=<Tab>	" Needed to open the wildmenu from shortcuts

" Display tabs
set showtabline=2

" Search down into subfolders
" Provides tab-completion for all file-related task
" usecase:
" :b<tab>
" :find<tab>
set path+=**

" Completion
" - Use ^] to jump to tag under cursor
" - Use g^] for ambigious tags
" - Use ^t to jump back up the tag stack
set tags=tags
" !command Maketags !ctags -R .

" Disable bell
set belloff+=ctrlg 
set noerrorbells
set visualbell
set t_vb=

set noswapfile
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
set hlsearch

set ruler       " Show ruler (line information etc..c
set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " AUtomatically save before commands like :next and :make

" Show invisibles
set listchars=eol:¬,tab:▸\ ,trail:·
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set splitright
set cursorline
set mouse=
set ttymouse=

set autoread " read file when modified outside of vim

let g:netrw_liststyle=3		" 0=thin; 1=long; 2=wide; 3=tree

" VIMUX
let mapleader = ","
map <Leader>vm :VimuxPromptCommand<CR>

if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif

