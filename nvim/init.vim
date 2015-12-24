" set nocompatible by default, right?
" Poss plugins:
"   scrooloose/nerdtree
"   majutshushi/tagbar
"   tpope/vim-fugitive
"   tpope/vim-git
"   autoclose
"   SirVer/ultisnips
"   vim-snippets
"   vim-surround
"   Lokaltog/vim-powerline
"   kien/ctrlp
"   jcf/vim-latex
"   scrooloose/syntastic
"   nelstrom/vim-visual-star-search
" 


call plug#begin()
" Informational display:
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace (nominally not in insert mode).
Plug 'airblade/vim-gitgutter' " git diff in the gutter; stage/revert hunks.

" Syntax
Plug 'PotatoesMaster/i3-vim-syntax' " Vim syntax file for i3 config file.

" Not working/untested:
Plug 'nathanaelkane/vim-indent-guides' " Highlight syntactic indent levels in alternating colors.
Plug 'vim-scripts/EasyColour' " Alternate color scheme syntax, with in-config coloring and automatic fallback on nearest color.
call plug#end()

" Set the length of time vim waits before it updates the gitgutter.
set updatetime=250 " milliseconds

" Turn on cursor cross-hairs.
set cursorline cursorcolumn

" Make the gutter 6 columns wide.
set numberwidth=6

" Highlight everything past column 100 (-1 allows search highlighting to overwrite).
call matchadd('ColorColumn', '\%>99v', -1)

" TODO set autowrap width properly or turn off.

" Replace whitespace characters (list) with a specified set of alternates (listchars).
"     eol:c      - Char to show at the end of each line: c=<unused>.
"     tab:xy     - Characters used to show a tab: x=u25b8 (▸), y=u0bb (»).
"                  The first is used once.
"                  The second is repreated to fill the space a tab normally occupies.
"     space:c    - Character used to show a space: c=a0 (۰).
"     trail:c    - Character used for trailing spaces c=<unused> (handled by vim-better-whitespace).
"                  Overrides space for relevant spaces.
"     extends:c  - Characters to show in the last column, when 'wrap' is off
"                  and the line extends beyond the right of the screen: c=u276d (❭).
"     precedes:c - Character to show in the first column, when 'wrap' is off
"                  and there is text preceding the character visible in the first column: c=u276c (❬).
"     conceal:c  - Character to show in place of concealed text, when 'conceallevel' is set to 1: c=u250a (┊).
"     nbsp:c     - Character used to show for a non-breaking space character (0xA0): c=u23b5 (⎵).
"                  Non-breaking space characters generally prevent automatic line breaks
"                  and collapsing of consecutive whitespace characters at their position.
set list listchars=tab:▸»,space:·,extends:❭,precedes:❬,conceal:┊,nbsp:⎵

" Don't wrap lines longer than the window width.
set nowrap

" Set completion mode for wildmenu command-line completion.
" First press of <TAB> completes the longest common string and shows options in wildmenu.
" Subsequent <TAB>s complete matches in turn.
set wildmode=longest:full,full

" Disable the mouse.
set mouse-=a

" Setup indentation to use spaces by default.
set expandtab " Use spaces instead of tabs.
set shiftwidth=4 " Affects what happens when you press >>, <<, or ==; affects auto-indentation.
set softtabstop=4 " Affects what happens when you press< TAB> or <BS>; should be same as shiftwidth.

" If tabs do show up, make them a reasonable width by default.
set tabstop=4 " Set the width of the tab character in spaces.

" Enable file type detection and load the filetype's indent and plugin files if they exists.
filetype plugin indent on

"colors bandit
colors petetay

" When both relative and absolute line numbering are turned on,
" the current line displays the absolute number and the rest
" use relative numbers.
set relativenumber " Turn on relative line numbering.
set number " Turn on line numbering.

if &diff
    " diff mode
    " Ignore whitespaces.
    set diffopt+=iwhite
    set diffexpr=DiffW()

    function DiffW()
      let opt = ""
       if &diffopt =~ "icase"
         let opt = opt . "-i "
       endif
       if &diffopt =~ "iwhite"
         let opt = opt . "-w " " vim uses -b by default which doesn't ignore leading whitespace
       endif
       silent execute "!diff -a --binary " . opt .
         \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
    endfunction
endif

autocmd BufNewFile,BufRead *.tpp  set syntax=cpp



"syntax on                 " Syntax highlighting! Yay!
"set laststatus=2          " Always have status bar
"set scrolloff=1           " Dont let the curser get too close to the edge
"set showcmd               " Show (partial) command in status line
"set showmatch             " Show matching brackets
"set bsdir=last            " Last accessed directory is default working directory
"match Todo /\s\+$/        " Highlight trailing whitespace
"
"
"
"" Vim Buffer
""""""""""""""""""""""""""""""""""""""""
"" This allows copying to and pasting from system clipboard.
"noremap ty "+y            " Select desired contents then press ty
"noremap tY "+Y            " Just press tY to yank entire line to clipboard
"noremap td "+d            " Select desired contents then press td
"noremap tD "+D            " Just press tY to delete entire line to clipboard
"noremap tp "+p            " Put the text from clipboard after the cursor
"noremap tP "+P            " Put the text from clipboard before the cursor
"
"
""""""""""""""""""""""""""""""""""""""""
"" Tabs and Indenting
""""""""""""""""""""""""""""""""""""""""
"set backspace=2           " Allow backspacing over everything in insert mode
"set shiftround            " Always indent/outdent to nearest tabstop
"set nowrap                " Don't wrap text
"set smarttab
"set cinoptions=l1,(0,u0,j1
"autocmd BufWritePre * : :%s/\s\+$//e
"
"
""""""""""""""""""""""""""""""""""""""""
"" Background
""""""""""""""""""""""""""""""""""""""""
"set diffopt=filler,iwhite " Keep files synced and ignore whitespace
"set nobackup              " Don't keep a backup file
"
"
""""""""""""""""""""""""""""""""""""""""
"" Mappings
""""""""""""""""""""""""""""""""""""""""
"" Ex mode is annoying, disable it
"map Q <Nop>
"
"" U is useless, make it a redo instead
"map U <C-r>
"
"" Use :W to sudo-write the current buffer
"command! W w !sudo dd of=%
"
"" Disable the arrow keys (forced immersion learning)
"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>
"vnoremap <Up> <Nop>
"vnoremap <Down> <Nop>
"vnoremap <Left> <Nop>
"vnoremap <Right> <Nop>
"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>
"
"
""""""""""""""""""""""""""""""""""""""""
"" Search
""""""""""""""""""""""""""""""""""""""""
"set ignorecase            " Do case insensitive matching
"set incsearch             " Incremental search
"
