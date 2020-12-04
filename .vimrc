if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

source ~/.config/nvim/init.vim
set t_Co=256
