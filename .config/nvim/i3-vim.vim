" down when number given: j, otherwise gj. (similar with k)
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'
set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off

" set up replace on current word
noremap <expr> g/ ':%s/'.expand('<cword>').'//gIc<Left><Left><Left><Left>'

" use confim quit
nnoremap <leader>f :conf q<cr>

" toggle non modifiable
nnoremap <leader>k :set invmodifiable<CR>:echo "View mode: " . (&modifiable ? "OFF" : "ON")<CR>
let g:undotree_SplitWidth = 50
nnoremap <f5> :UndotreeToggle<CR>
nnoremap <f8> :source ~/.config/nvim/init.vim<CR>

" insert mode drop down list selection.
inoremap <down> <c-n>
inoremap <up> <c-p>
inoremap <s-left> <c-h>
inoremap <expr> <s-left> pumvisible() ? "\<C-e>" : "\<c-h>"

if exists('$TMUX')
    " tmux title to iterm title. todo: working in neovim, not working in vim
    let &t_ts = "\<Esc>]0"
    let &t_fs = "\x7"
endif

" put file path into title
autocmd BufEnter * let &titlestring = expand('%:t') . '  ' . expand("[$USER]") 
set title
set laststatus=2
  
" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

if has('nvim')
  " nvim and vim appear incompatible here
  set dir=~/.config/nvim-data/swapfiles
  set backup
  set backupdir=~/.config/nvim-data/backupfiles
  set undofile
  set undodir=~/.config/nvim-data/undofiles
  set guicursor=n-v-c:block-nCursor,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175
    " insert mode for terminal
    au TermOpen * startinsert
endif

" todo: check if vscode can support some of this
" ----------------------------------------------------------------------------------------------
" copy to system clipboard. <hyp-y> mapped to <c-x><c-y> via karabiner elements
if $TERM_PROGRAM == "Apple_Terminal"
  if has('nvim')
    let g:colorscheme = "PaperColor"
  else
    colorscheme PaperColor
  endif
  vnoremap <c-y> "+y
else
  " yank into system clipboard without yanking into vim clipboard/reg0
  vnoremap <c-y> :OSCYankVisual<CR>
  nnoremap <c-y> :call YankLine()<CR>
  if has('nvim')
    let g:colorscheme = "vscode"
  endif
endif

function! YankLine()
  let line = getline(".")
  call OSCYank(line) 
endfunction

" ----------------------------------------------------------------------------------------------
set showcmd

autocmd FileType markdown setlocal wrap linebreak nolist
