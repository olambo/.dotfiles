" install node
" install python for coc
" python3 -m pip install --user --upgrade pynvim
"
" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  autocmd VimEnter * PlugInstall                                                                                                      
endif

if exists('g:vscode')
	source ~/.config/nvim/i1_plug.vim
	source ~/.config/nvim/i2_base.vim
else
	source ~/.config/nvim/i1_plug.vim
	source ~/.config/nvim/i2_base.vim
	source ~/.config/nvim/i3_extra.vim
	source ~/.config/nvim/i4_fzf.vim
	source ~/.config/nvim/i5_coc.vim
	source ~/.config/nvim/i6_statusline.vim
	let g:loaded_python_provider='/usr/bin/python2' 
	let g:python3_host_prog='/usr/local/bin/python3'
	" on <cr> dont hide closing bracket. don't need . repeat here!
	let g:pear_tree_repeatable_expand = 0
	" override coc
	set cmdheight=1
	" dont need a preview
	let g:fzf_preview_window = []
endif

" sneak with very bright lables!
let g:sneak#label = 1
map <c-j> <Plug>Sneak_s
map <c-k> <Plug>Sneak_S

