" set nocompatible              " required

call plug#begin('~/.vim/plugged')

Plug'gmarik/Vundle.vim'

" Theme
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'

Plug 'arzg/vim-substrata'
Plug 'hauleth/blame.vim'
Plug 'arcticicestudio/nord-vim'

Plug 'vim-scripts/ReplaceWithRegister'

" Stat
Plug 'wakatime/vim-wakatime'

Plug 'pangloss/vim-javascript'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }

Plug 'elmcast/elm-vim'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'mattn/emmet-vim'

""""" ELIXIR
Plug 'mhinz/vim-mix-format'
Plug 'elixir-editors/vim-elixir'
" Plug 'slashmili/alchemist.vim'
Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'roman/golden-ratio'

Plug 'andreypopp/vim-colors-plain'

Plug 'srstevenson/vim-picker'

Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()
" " All of your Plugins must be added before the following line
" call vundle#end()            " required
" filetype plugin indent on    " required

" Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

syntax enable
set background=dark
colorscheme nord
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
set expandtab

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

set autoread " read file when modified outside of vim

let g:netrw_liststyle=3		" 0=thin; 1=long; 2=wide; 3=tree

if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
endif


set timeout ttimeoutlen=50

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

if executable('fzf')
    " FZF {{{
    " <C-p> or <C-t> to search files
    nnoremap <silent> <C-t> :FZF -m<cr>
    nnoremap <silent> <C-p> :FZF -m<cr>

    " <M-p> for open buffers
    nnoremap <silent> <M-p> :Buffers<cr>

    " <M-S-p> for MRU
    nnoremap <silent> <M-S-p> :History<cr>

    " Use fuzzy completion relative filepaths across directory
    imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

    " Better command history with q:
    command! CmdHist call fzf#vim#command_history({'right': '40'})
    nnoremap q: :CmdHist<CR>

    " Better search history
    command! QHist call fzf#vim#search_history({'right': '40'})
    nnoremap q/ :QHist<CR>

    command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
    " }}}
else
    " CtrlP fallback
end

set list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1
imap ,t <Esc>:tabnew<CR>
map ,* *<C-O>:%s///gn<CR>

let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic']

let g:ElixirLS = {}
let ElixirLS.path = $HOME."/.vim/plugged/elixir-ls"
let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
let ElixirLS.cmd = join([
            \ 'mix do',
            \ 'local.hex --force --if-missing,',
            \ 'local.rebar --force,',
            \ 'deps.get,',
            \ 'compile,',
            \ 'elixir_ls.release'
            \ ], ' ')

function ElixirLS.on_stdout(_job_id, data, _event)
    let self.output[-1] .= a:data[0]
    call extend(self.output, a:data[1:])
endfunction

let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

function ElixirLS.on_exit(_job_id, exitcode, _event)
    if a:exitcode[0] == 0
        echom '>>> ElixirLS compiled'
    else
        echoerr join(self.output, ' ')
        echoerr '>>> ElixirLS compilation failed'
    endif
endfunction

function ElixirLS.compile()
    let me = copy(g:ElixirLS)
    let me.output = ['']
    echom '>>> compiling ElixirLS'
    let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
endfunction

" If you want to wait on the compilation only when running :PlugUpdate
" then have the post-update hook use this function instead:

function ElixirLS.compile_sync()
  echom '>>> compiling ElixirLS'
  silent call system(g:ElixirLS.cmd)
  echom '>>> ElixirLS compiled'
endfunction


" Then, update the Elixir language server
call coc#config('elixir', {
            \ 'command': g:ElixirLS.lsp,
            \ 'filetypes': ['elixir', 'eelixir'],
            \})

call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nmap <unique> <leader>pe <Plug>(PickerEdit)
nmap <unique> <leader>ps <Plug>(PickerSplit)
nmap <unique> <leader>pt <Plug>(PickerTabedit)
nmap <unique> <leader>pv <Plug>(PickerVsplit)
nmap <unique> <leader>pb <Plug>(PickerBuffer)
nmap <unique> <leader>p] <Plug>(PickerTag)
nmap <unique> <leader>pw <Plug>(PickerStag)
nmap <unique> <leader>po <Plug>(PickerBufferTag)
nmap <unique> <leader>ph <Plug>(PickerHelp)

set termguicolors
let g:nord_comment_brightness = 20
