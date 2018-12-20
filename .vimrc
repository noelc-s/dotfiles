set number
set tabstop=2
set breakindent
syntax enable

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
Plug 'tjammer/blayu.vim'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:lightline = {'colorscheme': 'blayu'}
colorscheme blayu
