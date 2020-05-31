" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""Plugins""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'ianva/vim-youdao-translater'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

if has('gui')
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 配置多语言环境,解决中文乱码问题
if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk
    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)'
        set ambiwidth=double
    endif
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Cursor guifg=white guibg=#4040ff
highlight iCursor guifg=#4040ff guibg=steelblue
set autoindent
set autoread
set autowrite
set background=dark
set backspace=2                                                                        " enable backspace
set clipboard+=unnamed                                                                 " cross clipboard
set cmdheight=1
set confirm                                                                            " popup when write a readonly file
set cursorcolumn
set cursorline
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set go=                                                                                " no GUI
set guicursor+=i:blinkon1
set guicursor+=i:blinkwait7
set guicursor+=n-v-c:blinkon0
set helplang=cn
set hidden                                                                             " allow switch buffer when unsaved changes
set history=1000
set hlsearch
set incsearch
set langmenu=zh_CN.UTF-8
set laststatus=1
set list                                                                               " show tab symbol
set listchars=tab:\|\ ,                                                                " show tab as '|'
set matchtime=10
set mouse=a                                                                            " enable mouse
set nobackup
set nocompatible                                                                       " diable compatible mode
set noeb                                                                               " turn off tone
set noexpandtab
set noswapfile
set novisualbell                                                                       " don't blink when hit Esc
set nowrapscan                                                                         " stop search when hit bottom
set number
set selectmode=mouse,key
set shiftwidth=4
set shortmess=atI                                                                      " no start page
set showcmd                                                                            " show cmd
set showmatch                                                                          " show match brackts
set smarttab
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
set syntax=on
set tabstop=4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable 
syntax on 
filetype indent on 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui')
    color solarized             " theme 
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key bindings

" leader key
let mapleader = "\<SPACE>"

" fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" edit my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source my vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" list buffer
nnoremap <leader>b :Buffers<cr>
" format json
nnoremap <leader>fj :%!python -m json.tool<cr>:set syntax=json<cr>
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

"arrow keys
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

" function key
nnoremap <leader>ff :Files<cr>
nnoremap <leader>ft :NERDTreeToggle<cr>

" run python
autocmd FileType python nnoremap <silent> <leader>r <Esc>:w<CR>:!clear;python3 %<CR>
