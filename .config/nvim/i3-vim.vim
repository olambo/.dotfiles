" Smart line navigation: move by visual lines (gj/gk) for single moves,
" by logical lines (j/k) when using counts (e.g., 5j)
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'
set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off

" set up replace on current word
noremap <expr> gs ':%s/\<'.expand('<cword>').'\>//gIc<Left><Left><Left><Left>'

" use confim quit
nnoremap <leader>f :conf q<cr>

function! PasteReplaceAllWithConfirm()
    if confirm("Replace entire buffer with clipboard?", "&Yes\n&No", 2) == 1
        %d | put + | 1d
    endif
endfunction
command! PasteReplaceAll call PasteReplaceAllWithConfirm()
nnoremap <F5> :PasteReplaceAll<CR>

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

if $TERM_PROGRAM == "Apple_Terminal"
  if has('nvim')
    let g:colorscheme = "PaperColor"
  else
    colorscheme PaperColor
  endif
  vnoremap <c-x> "+y
else
  if has('nvim')
    let g:colorscheme = "vscode"
  endif
  " Copy selected text to system clipboard
  vnoremap <c-x> "+y
  " Deprecated due to inconsistencies with other apps (e.g. warp)
  vnoremap <c-y> <Esc>:echo "ctrl-y deprecated, use cmd-c instead"<CR>
  " Select all and yank to system clipboard
  command! YankAllToClipboard %y+
  nnoremap <leader>a :YankAllToClipboard<CR>
endif

" ----------------------------------------------------------------------------------------------
set showcmd

autocmd FileType markdown setlocal wrap linebreak nolist
