" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                  " Must come first because it changes other options.

" ### Configure Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
" ##### Syntax
Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
" ##### Completions
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'Rip-Rip/clang_complete'
" ##### Navigate
Plugin 'majutsushi/tagbar'
Plugin 'mbadran/headlights'
" ##### External tool integration
Plugin 'tpope/vim-fugitive'
call vundle#end()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

" UNCOMMENT TO USE
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Or use vividchalk
colorscheme vividchalk

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" map <leader>f :FuzzyFinderTextMate<cr>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set list

" clang_complete settings
let g:clang_debug=1
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_close_preview=1
let g:clang_periodic_quickfix=0
let g:clang_trailing_placeholder=1
let g:clang_snippets=1
let g:clang_snippets_engine="ultisnips"
"let g:clang_conceal_snippets=1
let g:clang_use_library=1
let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
"let g:clang_user_options=""
let g:clang_auto_user_options="compile_commands.json, path, .clang_complete"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
"let g:clang_complete_patterns=0
" show diagnostics
nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>

" ### Headlights
let g:headlights_smart_menus = 1
let g:headlights_show_commands = 1
let g:headlights_show_mappings = 1
let g:headlights_show_abbreviations = 1
let g:headlights_show_functions = 1
let g:headlights_show_highlights = 1

" ### Ultisnips

" Set ultiSnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ### Tagbar
"
" Install new ctags with objc support: $ brew install ctags --HEAD
"
" Add a template definition for Objective-C
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

" Always expand folds by default
set foldlevel=99

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby set foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" Make selection with the shift key work as in any Mac app
if has("gui_macvim")
  let macvim_skip_hig_shift_movement = 1

  " more TextMate/Mac like command mappings
  map <D-/> ,c<Space>
endif

" enable per-directory .vimrc files
set exrc
" disable unsafe commands in local .vimrc files
set secure
