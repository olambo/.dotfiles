let g:python3_host_prog = '/usr/bin/python3'

" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

" move backup and swap files
set backupdir=~/tmp/nvim-backup
set directory=~/tmp/nvim-backup

colorscheme PaperColor
set bg=light

let g:lightline_tealeaves = "src/main/scala:sms, src/main/java:smj, src/main/resources:smr"

" syntax on

function! StorePath()
  :!echo %:p:h |pbcopy -pboard find
endfunction

function! GoFinder()
  :!exec open -a Finder %:p:h
endfunction

" finder at current directory
nnoremap <silent> <leader>fin :call GoFinder()<cr>
nnoremap <silent> <leader>con :e ~/.config<cr>
nnoremap <silent> <leader>doc :e ~/Dropbox/doc<cr>
nnoremap <silent> <Leader>wrk :e ~/dev/wrk <bar> :cd ~/dev/wrk<cr>

nnoremap <leader>pcd :cd <c-r>=expand('%:h')<cr><cr>
nnoremap <leader>pcp :call StorePath() <cr>
nnoremap <leader>ppr :!pbpaste -pboard find <cr>
nnoremap <leader>ppp  :e `pwd`<cr>

" why would you want to be in normal mode inside a terminal buffer?
autocmd BufEnter term://* :set nonumber norelativenumber
autocmd BufEnter term://* startinsert
nnoremap <silent> <leader>th :15sp term://zsh<cr>
nnoremap <silent> <leader>tv :vs term://zsh<cr>
nnoremap <silent> <leader>tt :term<cr>i
