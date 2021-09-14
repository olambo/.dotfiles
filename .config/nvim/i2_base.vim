" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> g, b                      -> <pagedown>, <pageup>
"   <hyp> (, )                      -> <home>, <end>

" insert mode no movement
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" move down and up a bit more than normal
nnoremap <up> 5k
nnoremap <down> 5j
vnoremap <up> 5k
vnoremap <down> 5j

" next previous paragraph, start of text
nnoremap <left> {{E^
nnoremap <right> }E^
vnoremap <left> k{
vnoremap <right> j}gE

" yank until end of line (ie. work like C, D)
nnoremap Y y$

" down when number given: j, otherwise gj. (similar with k)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" various bats and bits
set ignorecase
set smartcase
set splitbelow splitright
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#
set ruler
set expandtab
set nu

let mapleader="\<space>"

" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

" go to next split
nmap <leader><leader> <c-w><c-w>

" toggle numbers
noremap <leader>n :set number!<cr>:se norelativenumber<cr>

" used in ideavim
" noremap g- <nop>

" noremap gd <nop>
noremap gi <nop>

noremap gu <nop>
noremap gt <nop>

noremap gs <nop>
noremap gr <nop>

noremap gh <nop>
noremap gl <nop>

noremap gk <nop>
noremap gj <nop>

noremap ge <nop>
noremap gE <nop>

noremap gm <nop>
noremap gM <nop>

noremap gb <nop>
noremap gB <nop>

noremap gf <nop>
noremap go <nop>

if exists('g:vscode')
   noremap - <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
   " noremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>
   noremap gf <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
 
    
   noremap gu <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
   noremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

   noremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

   noremap gh <Cmd>call VSCodeNotify('workbench.action.navigateToLastEditLocation')<CR>
   noremap gl <Cmd>call VSCodeNotify('workbench.action.navigateToNextEditLocation')<CR>

   noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
   noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

   noremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
   noremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

   noremap go <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>
endif
