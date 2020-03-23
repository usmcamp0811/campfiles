set nocompatible
set t_Co=256

" give our selves some more colors
" TODO: make check that our terminal supports this
set termguicolors
set clipboard+=unnamedplus
syntax enable
" colorscheme cobalt
" colorscheme solarized8_flat
colorscheme night-owl
" colorscheme one
" colorscheme onedark

let g:lightline = { 'colorscheme': 'nightowl' }

hi SpellBad    ctermfg=9      ctermbg=16     cterm=underline   

let mapleader=","

set backupdir=~/.config/nvim/backups
set directory=~/.config/nvim/swaps
set undodir=~/.config/nvim/undo

source ~/.config/nvim/init.vimrc  


" Color_demo - preview of Vim 256 colors
function! Color_demo() abort
    30 vnew
    setlocal nonumber buftype=nofile bufhidden=hide noswapfile
    setlocal statusline=[%n]
    setlocal statusline+=\ Color\ demo
    let num = 255
    while num >= 0
        execute 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
        execute 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
        call append(0, 'ctermbg='.num.':....')
        let num = num - 1
    endwhile
endfunction


" GrepRename - replace through whole project 
function! s:GrepRename(expr1, expr2) abort
    execute "tabe | vimgrep /\\C\\W".a:expr1."\\W/j ** | cdo s/\\C\\\(\\W\\)".a:expr1."\\\(\\W\\)/\\1".a:expr2."\\2/gc | update" | q
endfunction

