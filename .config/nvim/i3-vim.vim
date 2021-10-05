nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
let g:sneak#use_ic_scs = 1

nnoremap <F5> :UndotreeToggle<CR>
nmap <f7> :lua require('dark_notify').toggle()<cr>

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
local dn = require('dark_notify')
dn.run({
  onchange = function(mode)
    if vim.g.vscode_style ~= mode then
      vim.g.vscode_style = mode 
      vim.cmd('colorscheme ' .. vim.g.colorscheme)
    end
  end,
})
EOF
set guicursor=n-v-c:block-nCursor,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
 " insert mode for terminal
 au TermOpen * startinsert
endif

" ----------------------------------------------------------------------------------------------
" copy to system clipboard. <hyp-y> mapped to <c-x><c-y> via karabiner elements
if $TERM_PROGRAM == "Apple_Terminal"
  vnoremap <c-x><c-y> "+y
  let g:enable_spelunker_vim = 1
  let g:PaperColor_Theme_Options = {
   \   'theme': {
   \     'default': {
   \       'override' : {
   \         'color00' : ['#ffffff', '231'],
   \         'linenumber_bg' : ['#ffffff', '231'],
   \       }
   \     },
   \     'default.dark': {
   \       'override' : {
   \       }
   \     }
   \   }
   \ }
 let g:colorscheme = "PaperColor"
else
  let g:enable_spelunker_vim = 0
  vnoremap <c-x><c-y> :OSCYank<CR>
  nnoremap <c-x><c-y><c-x><c-y> :call YankLine()<CR>
  if has('nvim')
    let g:colorscheme = "vscode"
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
 
noremap <leader>m :exec 'source '.bufname('%')<CR>
xnoremap <right> <Cmd>lua print(_G.expand())<Cr>
xnoremap <left> <Cmd>lua print(_G.contract())<Cr>

lua << EOF
-- https://www.reddit.com/r/neovim/comments/p4u4zy/how_to_pass_visual_selection_range_to_lua_function/
function _G.getVisualSelection()
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cline, ccol = cursor[1], cursor[2]
  local vline, vcol = vim.fn.line('v'), vim.fn.col('v')

  local sline, scol
  local eline, ecol
  if cline == vline then
    if ccol <= vcol then
      sline, scol = cline, ccol
      eline, ecol = vline, vcol
      scol = scol + 1
    else
      sline, scol = vline, vcol
      eline, ecol = cline, ccol
      ecol = ecol + 1
    end
  elseif cline < vline then
    sline, scol = cline, ccol
    eline, ecol = vline, vcol
    scol = scol + 1
  else
    sline, scol = vline, vcol
    eline, ecol = cline, ccol
    ecol = ecol + 1
  end

  if mode == "V" or mode == "CTRL-V" or mode == "\22" then
    scol = 1
    ecol = nil
  end

  local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, 0)
  if #lines == 0 then return end

  local startText, endText
  if #lines == 1 then
    startText = string.sub(lines[1], scol, ecol)
  else
    startText = string.sub(lines[1], scol)
    endText = string.sub(lines[#lines], 1, ecol)
  end

  local tb = {}
  tb["ccol"] = ccol + 1
  tb["sline"] = sline
  tb["scol"] = scol
  tb["ecol"] = ecol
  tb["stext"] = startText
  return tb
end
function _G.expand()
  local tb = getVisualSelection()
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, tb['sline'], tb['scol']-1})
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, tb['sline'], tb['ecol']+1})
end
function _G.contract()
  local tb = getVisualSelection()
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, tb['sline'], tb['scol']+1})
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, tb['sline'], tb['ecol']-1})
  local inspect = require('vim.inspect')
  --print(inspect(tb))
end
EOF
