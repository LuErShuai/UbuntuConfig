set textwidth=84
set wrap
set formatoptions+=mM
set linebreak         
set wrapmargin=0
set clipboard=unnamedplus
set number
set relativenumber
set cc=90
set cursorline
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set autoindent
set ts=4 sts=4 sw=4
set expandtab
set guifont=Monospace\ 18 
syntax on


call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'jmcantrell/vim-virtualenv'

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}
let g:tex_conceal='abdmg'
let g:vimtex_complete_enabled=1

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

"shortcut to open NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:virtualenv_directory = '/usr/local/anaconda/envs' 
call plug#end()
