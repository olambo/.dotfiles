set belloff=all
set number relativenumber
set nowrap
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
"set noswapfile
"set nobackup
"set undodir=~/.config/nvim/runcache/undodir
"set undofile
set incsearch
let g:dirvish_git_show_icons = 0

" ----------------------------------------------------------------------------------------------
" keyboard maestro assisted key combinations
 
" <hyper-y> yank selection and save it into a file which is monitored
function! It2copy()
    execute "normal! `<v`>y"
    let regInfo = getreg('"')
    call writefile(split(regInfo, "\n"), expand("~/.config/nvim/runcache/vim-clipboard.txt"))
    echo "i2copy"
endfunction
vnoremap <c-\><c-\> :call It2copy()<cr>

" <cmd-/> comment/uncomment
nmap <c-\>/ <Plug>CommentaryLine<cr>
vmap <c-\>/ <Plug>Commentary

" ----------------------------------------------------------------------------------------------
" leader of the pack. 
let mapleader="\<space>"

" magic replace
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>
" toggle number on and off
nnoremap <silent> <leader>nn :set number! relativenumber!<cr> 
" highlight off
nnoremap <leader><leader> :nohlsearch<Bar>:echo<CR>

" these lead to unintended consequences if they are not set to something
nnoremap <leader>i :echoerr 'You typed "<leader>i". Use "i" to insert'<cr>
nnoremap <leader>s :echoerr 'You typed "<leader>s". Use "<leader>w" to write file'<cr>
nnoremap <leader>a :echoerr 'You typed "<leader>a". Use "a" to append'<cr>
nnoremap <leader>d :echoerr 'You typed "<leader>d". Use "d" to delete'<cr>
nnoremap <leader>c :echoerr 'You typed "<leader>c". Use "c" to change'<cr>
nnoremap <leader>o :echoerr 'You typed "<leader>o". Use "o" to open line'<cr>
nnoremap <leader>p :echoerr 'You typed "<leader>p". Use "p" to paste'<cr>
nnoremap <leader>r :echoerr 'You typed "<leader>r". Use "r" to replace'<cr>
nnoremap <leader>u :echoerr 'You typed "<leader>u". Use "u" to undo'<cr>
nnoremap <leader>x :echoerr 'You typed "<leader>x". Use "x" to delete'<cr>
 
" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

" move backup and swap files
set backupdir=~/tmp/nvim-backup
set directory=~/tmp/nvim-backup

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override' : {
  \         'color00' : ['ffffff', '231'],
  \         'linenumber_bg' : ['ffffff', '231'],
  \       }
  \     },
  \     'default.dark': {
  \       'override' : {
  \       }
  \     }
  \   }
  \ }
colorscheme PaperColor
set bg=light

let g:lightline_tealeaves = "src/main/scala:sms, src/main/java:smj, src/main/resources:smr"

" syntax on

function! StorePath()
  :!echo %:p:h |pbcopy -pboard find
endfunction
" todo: is this any use when linux server cant use it - no xwindow
nnoremap <leader>xx1 :call StorePath() <cr>
nnoremap <leader>xx2 :!pbpaste -pboard find <cr>

function! GoFinder()
  :!exec open -a Finder %:p:h
endfunction
" open finder at current directory
nnoremap <silent> <leader>fin :call GoFinder()<cr>

" move to work
nnoremap <silent> <Leader>wrk :e ~/dev/wrk <bar> :cd ~/dev/wrk<cr>
" reset starting path
nnoremap <leader>pcd :cd <c-r>=expand('%:h')<cr><cr>
" goto starting path
nnoremap <leader>ppp :e `pwd`<cr>

function! GoTerm()
    :term
    :set nonumber 
    :set norelativenumber
    :startinsert
endfunction
nnoremap <silent> <leader>tt :call GoTerm()<cr>
