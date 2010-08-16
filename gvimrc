" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

set guifont=Monaco:h12            " Font family and font size.
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
"set background=light             " Interferes with a custom colorscheme!
set lines=50 columns=155          " Window dimensions.

" Uncomment to use.
" set guioptions-=r                 " Don't show right scrollbar

" Save all open buffers when MacVim loses focus
au FocusLost * wa

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen
end
