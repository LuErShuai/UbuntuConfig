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
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set encoding=utf-8
set autoindent
set ts=4 sts=4 sw=4
set expandtab
set guifont=Monospace\ 18 
set mouse=a
colorscheme koehler 
syntax on


call plug#begin('~/.vim/plugged')

" Plug 'ervandew/supertab'
Plug 'lervag/vimtex'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
Plug 'jmcantrell/vim-virtualenv'
" Plug 'preservim/nerdcommenter'
Plug 'puremourning/vimspector'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"coc configuration
set shortmess=c
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-vimlsp',
            \ 'coc-jedi'
            \]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

inoremap <silent><expr> <TAB>
		  \ pumvisible() ? "\<C-n>" :
		  \ <SID>check_back_space() ? "\<TAB>" :
		  \ coc#refresh()


inoremap <silent><expr> <leader><space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader> h to show documentation in preview window.
nnoremap <silent> <leader>h :call <sid>show_documentation()<cr>
function! s:show_documentation()
  if index(['vim', 'help'], &filetype) >= 0
    execute 'help ' . expand('<cword>')
  elseif &filetype ==# 'tex'
    VimtexDocPackage
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)




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
let g:vimtex_toc_enabled=1
  augroup vimtex_customization
    autocmd!
    autocmd FileType tex call CreateTocs()
  augroup END

  function CreateTocs()
    let g:custom_toc1 = vimtex#toc#new({
        \ 'layers' : ['label', 'todo'],
        \ 'todo_sorted' : 0,
        \ 'show_help' : 0,
        \ 'show_numbers' : 0,
        \ 'mode' : 1,
        \})
    nnoremap <silent> \la :call g:custom_toc1.open()<cr>

    let g:custom_toc2 = vimtex#toc#new({
        \ 'layers' : ['include'],
        \ 'show_help' : 0,
        \})
    nnoremap <silent> \lY :call g:custom_toc2.open()<cr>

    let g:custom_toc3 = vimtex#toc#new({
        \ 'layers' : ['content'],
        \ 'show_help' : 0,
        \ 'mode' : 1,
        \})
    nnoremap <silent> \t :call g:custom_toc3.open()<cr>
  endfunction

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

"shortcut for <c-w>
nmap ww <C-w>

"shortcut to open TagBar
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

"shortcut to vimspector
nnoremap <leader>w  :VimspectorWatch 
nnoremap <leader>q  :call vimspector#Reset() <CR>
" Set the basic sizes
let g:vimspector_sidebar_width = 50 
let g:vimspector_code_minwidth = 84 
let g:vimspector_terminal_minwidth = 64 
let g:vimspector_terminal_maxwidth = 130
let g:vimspector_bottombar_height  = 50 
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

function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })
noremap <leader>c :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
