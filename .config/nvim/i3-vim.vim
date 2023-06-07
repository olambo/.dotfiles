" use hyp-m or cmd-/ to comment 
nmap <C-_> gcc
xmap <C-_> gc

let g:undotree_SplitWidth = 50
nnoremap <f5> :UndotreeToggle<CR>
nmap <f7> :lua require('dark_notify').toggle()<cr>
nnoremap <f8> :source $MYVIMRC<CR>
nnoremap <f8> :source ~/.config/nvim/init.vim<CR>

" insert mode drop down list selection.
inoremap <down> <c-n>
inoremap <up> <c-p>
inoremap <expr> <left> pumvisible() ? "\<C-e>" : "\<left>"

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

:lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",           -- one of "all", or a list of languages
    ignore_install = { },               -- List of parsers to ignore installing
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = { },                    -- list of language that will be disabled
    },
  }
  local dn = require('dark_notify')
  dn.run({
    onchange = function(mode)
      if vim.g.vscode_style ~= mode then

        -- force it dark for now
        --vim.g.vscode_style = mode 
        vim.g.vscode_style = 'dark' 
        vim.o.background = 'dark'

        vim.cmd('colorscheme ' .. vim.g.colorscheme)
        vim.cmd('source ' .. '~/.config/nvim/i5-statusline.vim')
      end
    end,
  })
EOF
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
  vnoremap <c-x><c-y> "+y
  nnoremap <c-x><c-y><c-x><c-y> V"+y
else
  " yank into system clipboard without yanking into vim clipboard/reg0
  vnoremap <c-x><c-y> :OSCYankVisual<CR>
  nnoremap <c-x><c-y><c-x><c-y> :call YankLine()<CR>
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
