" install node
" install python for coc
" python3 -m pip install --user --upgrade pynvim
"
" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
  autocmd VimEnter * PlugInstall                                                                                                      
endif

if exists('g:vscode')
call plug#begin('~/.config/nvim/plugged')
Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
call plug#end()
source ~/.config/nvim/i2_base.vim
source ~/.config/nvim/i3_extra.vim

else
source ~/.config/nvim/i1_plug.vim
source ~/.config/nvim/i2_base.vim
source ~/.config/nvim/i3_extra.vim
source ~/.config/nvim/i4_fzf.vim
source ~/.config/nvim/i5_coc.vim
source ~/.config/nvim/i6_statusline.vim
let g:loaded_python_provider='/usr/bin/python2' 
let g:python3_host_prog='/usr/local/bin/python3'
set cmdheight=1
endif

map <Leader>em <Plug>(easymotion-prefix)
