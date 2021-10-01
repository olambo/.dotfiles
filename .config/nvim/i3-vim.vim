nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
let g:sneak#use_ic_scs = 1

nnoremap <F5> :UndotreeToggle<CR>

" down when number given: j, otherwise gj. (similar with k)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" on <cr> dont hide closing bracket. don't need . repeat here
let g:pear_tree_repeatable_expand = 0
" this stops expansion on <CR> but no mapping in karabiner elements. Probably can remove
imap <c-x><c-e> <Plug>(PearTreeExpand)

" used in ideavim. Probably remove
" noremap g- <nop>

" noremap gd <nop>
noremap gi <nop>

noremap gr <nop>
noremap gR <nop>

noremap gh <nop>
noremap gs <nop>
noremap gS <nop>

noremap ge <nop>
noremap gE <nop>

noremap gm <nop>
noremap gM <nop>

noremap gb <nop>
noremap gB <nop>

noremap gf <nop>
noremap go <nop>

nnoremap gk <c-o>
nnoremap gj <c-i>

set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
set incsearch

" use cmd-/ to comment (mapped from cmd-_ from karabiner elements)
nmap <C-_> gcc
xmap <C-_> gc

" insert mode drop down list selection.
inoremap <down> <c-n>
inoremap <up> <c-p>
inoremap <expr> <left> pumvisible() ? "\<C-e>" : "\<left>"

" for most enviroments don't want tab spacing. But for Go, go fmt uses tabs
autocmd BufEnter *.go set noexpandtab
autocmd BufRead *.go set noexpandtab
autocmd BufLeave * set expandtab

if exists('$TMUX')
    " tmux title to iterm title. todo: working in neovim, not working in vim
    let &t_ts = "\<Esc>]0"
    let &t_fs = "\x7"
endif

" put file path into title, remove laststatus - I'd rather have an extra line!
autocmd BufEnter * let &titlestring = expand("[$USER]") . expand('%:~')
set title
set laststatus=0
 
" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

if has('nvim')
:lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { },               -- List of parsers to ignore installing
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = { },                    -- list of language that will be disabled
    },
  }
EOF
 " insert mode for terminal
 au TermOpen * startinsert
endif

" ----------------------------------------------------------------------------------------------
" copy to system clipboard. <hyp-y> mapped to <c-x><c-y> via karabiner elements
if $TERM_PROGRAM == "Apple_Terminal"
  vnoremap <c-x><c-y> "+y
  let g:enable_spelunker_vim = 1
else
  let g:enable_spelunker_vim = 0
  vnoremap <c-x><c-y> :OSCYank<CR>
  nnoremap <c-x><c-y><c-x><c-y> :call YankLine()<CR>
  if has('nvim')
    let g:vscode_style = "light"
    colorscheme vscode
  endif
endif

function! YankLine()
   let line = getline(".")
   call OSCYankString(line) 
endfunction

" ----------------------------------------------------------------------------------------------
set showcmd
" set up replace on current word
nnoremap <expr> g/ ':%s/'.expand('<cword>').'//gIc<Left><Left><Left><Left>'

let mapleader="\<space>"

if !exists("g:bloop")
  let g:bloop="root"
endif
"go run using vcommand
noremap go :call GoCommand("clear; bloop run " . expand(g:bloop))<CR>
"go test using vcommand
noremap <leader>t :call GoCommand("clear; bloop test " . expand(g:bloop))<CR>
"go individual test using vcommand
noremap <leader>T :call GoCommand("clear; bloop test " . expand(g:bloop) . " -o " . expand(split(getline('1'))[1]) . "." . expand("<cword>"))<CR>

function! GoCommand(cmd)
    if &mod == 1 
        echohl WarningMsg | echo "WARNING, BUFFER NOT WRITTEN!" | echohl None | echo a:cmd
    else
        echo "vcommand: " . a:cmd
    endif
    call writefile([a:cmd], expand("~/.config/nvim/runcache/vcommand.txt"))
endfunction
"----------------------------------------------------------------------------------------------
 

