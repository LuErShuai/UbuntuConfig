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
set mouse=a
syntax on


call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
" Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'jmcantrell/vim-virtualenv'
Plug 'puremourning/vimspector'
Plug 'preservim/tagbar'

call plug#end()

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

let g:jedi#show_call_signatures=2
set completeopt-=preview

let g:vimspector_enable_mappings = 'HUMAN'

"shortcut to open TagBar
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

"shortcut to vimspector
nnoremap <leader>w  :VimspectorWatch 
nnoremap <leader>q  :call vimspector#Reset() <CR>
" Set the basic sizes
let g:vimspector_sidebar_width = 50 
let g:vimspector_code_minwidth = 125 
let g:vimspector_terminal_minwidth = 75
" Custom Layout {{{

function! s:CustomiseUI()
  call win_gotoid( g:vimspector_session_windows.output )
  q
  call win_gotoid( g:vimspector_session_windows.code )
endfunction

function s:SetUpTerminal()
  call win_gotoid( g:vimspector_session_windows.terminal )
  set norelativenumber nonumber
endfunction

function! s:CustomiseWinBar()
    call win_gotoid( g:vimspector_session_windows.code)
    aunmenu WinBar
    nnoremenu WinBar.▷\ ᶠ⁵ :call vimspector#Continue()<CR>
    nnoremenu WinBar.↷\ ᶠ¹⁰ :call vimspector#StepOver()<CR>
    nnoremenu WinBar.↓\ ᶠ¹¹ :call vimspector#StepInto()<CR>
    nnoremenu WinBar.↑\ ˢᶠ¹¹ :call vimspector#StepOut()<CR>
    nnoremenu WinBar.❘❘\ ᶠ⁶ :call vimspector#Pause()<CR>
    nnoremenu WinBar.□\ ˢᶠ⁵ :call vimspector#Stop()<CR>
    nnoremenu WinBar.⟲\ ᶜˢᶠ⁵ :call vimspector#Restart()<CR>
    nnoremenu WinBar.✕\  :call vimspector#Reset()<CR>
endfunction

augroup TestUICustomistaion
  autocmd!
  autocmd User VimspectorUICreated call s:CustomiseUI()
  "autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
  autocmd User VimspectorUICreated call s:CustomiseWinBar()
augroup END
