" Poss plugins - check to see if they have vim-airline compatibility when
" adding ad see if the status-line information is helpful.
"   scrooloose/nerdtree
"   majutshushi/tagbar
"   tpope/vim-fugitive
"   tpope/vim-git
"   autoclose
"   SirVer/ultisnips
"   vim-snippets
"   vim-surround
"   kien/ctrlp
"   jcf/vim-latex
"   scrooloose/syntastic
"   nelstrom/vim-visual-star-search
"   chrisbra/csv.vim - eases handling of comma (or equiv) separated tabular data in vim
"

call plug#begin()
" Informational display:
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace (nominally not in insert mode).
Plug 'airblade/vim-gitgutter' " git diff in the gutter; stage/revert hunks.
Plug 'bling/vim-airline' " Status line.

" Syntax
Plug 'PotatoesMaster/i3-vim-syntax' " Vim syntax file for i3 config file.

" Not working/untested:
Plug 'nathanaelkane/vim-indent-guides' " Highlight syntactic indent levels in alternating colors.
Plug 'vim-scripts/EasyColour' " Alternate color scheme syntax, with in-config coloring and automatic fallback on nearest color.
call plug#end()

" Configure status-line.

" hunks gives a summary of changed hunks under soure control by integrating
" with vim-gitgutter. It displays +, ~, and - and a count for each.
"
" branch integrates with fugitive/lawrencium to display the current branch
"  - you can configure no-branch text, truncate name, and custom formatting
" %f Path to the file in the buffer, as typed or relative to current directory.
" %r - readonly flag, text is "[RO]"
" %c - column number
" %p - percentage through file in lines
"%h - help buffer flag?
call airline#parts#define_raw('column_number', '%c')
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', 'paste'])
    let g:airline_section_b = airline#section#create(['hunks'])
    let g:airline_section_c = airline#section#create(['%.100f']) " 100 characters max.
    let g:airline_section_gutter = airline#section#create(['readonly'])
    let g:airline_section_x = airline#section#create(['%h'])
    let g:airline_section_z = airline#section#create(['%p%%', ' ', 'column_number'])
    let g:airline_section_warning = airline#section#create(['whitespace'])
endfunction
autocmd User AirlineAfterInit call AirlineInit() " After plugin loads, but before it replaces statusline

" TODO - concealing text? (conceallevel, concealcursor)
" consider changing the complete settings string to specify how keyword
" completion works
" same with completeopt

" TODO sync custom dictionary?

" Set the length of time vim waits before it updates the gitgutter.
set updatetime=250 " milliseconds

set undofile " Create <FILENAME>.un that persists undo information across close/reopen.

set cursorline cursorcolumn " Turn on cursor cross-hairs.

" Highlight everything past column 100 (-1 allows search highlighting to overwrite).
call matchadd('ColorColumn', '\%>99v', -1)

" consider modifying path to include directories to search for files

" TODO set autowrap width properly or turn off.
" if leaving wrap on, consider breakindent which causes lines to be visually
" indented the same amount as the beginning of that line to preserve blocks of
" text
" also, linebreak and showbreak
set nowrap " Don't wrap lines longer than the window width.

" consider adding to matchpairs to update the set of characters that form
" pairs

" Replace whitespace characters (list) with a specified set of alternates (listchars).
"   eol:c      - Char to show at the end of each line: c=<unused>.
"   tab:xy     - Characters used to show a tab: x=u25b8 (▸), y=u0bb (»).
"                The first is used once.
"                The second is repreated to fill the space a tab normally occupies.
"   space:c    - Character used to show a space: c=a0 (۰).
"   trail:c    - Character used for trailing spaces c=<unused> (handled by vim-better-whitespace).
"                Overrides space for relevant spaces.
"   extends:c  - Characters to show in the last column, when 'wrap' is off
"                and the line extends beyond the right of the screen: c=u276d (❭).
"   precedes:c - Character to show in the first column, when 'wrap' is off and there is text
"                preceding the character visible in the first column: c=u276c (❬).
"   conceal:c  - Character to show in place of concealed text, when 'conceallevel'
"                is set to 1: c=u250a (┊).
"   nbsp:c     - Character used to show for a non-breaking space character (0xA0): c=u23b5 (⎵).
"                Non-breaking space characters generally prevent automatic line breaks
"                and collapsing of consecutive whitespace characters at their position.
set list listchars=tab:▸»,space:·,extends:❭,precedes:❬,conceal:┊,nbsp:⎵

" Set completion mode for wildmenu command-line completion.
" First press of <TAB> completes the longest common string and shows options in wildmenu.
" Subsequent <TAB>s complete matches in turn.
set wildmode=longest:full,full
set wildignorecase " Ignore case when completing file names and directories.

set mouse-=a " Disable the mouse.

"TODO delete individual spaces instead of softtabstop many?
"
" Setup indentation to use spaces by default.
"   When expandtab is not set, tabstop-many consecutive spaces are collapsed
"     into a single tab character and <BS>/(auto)indentation deletes softtabstop
"     many spaces (breaking tabs into spaces as needed).
"   When expandtab is set, spaces are not collapsed, <BS> deletes either
"     softtabstop spaces or an entire tab character (without breaking it into
"     spaces), and (auto)indentation replaces tabs on the line with
"     tabstop-many spaces and then inserts/deletes spaces appropriately.
set expandtab
set shiftwidth=4 " (Auto)indentation will insert/delete shiftwidth spaces.
set shiftround " In/outdent to the next multiple of shiftwidth
               " (instead of strictly shiftwidth characters).
set softtabstop=4 " Pressing <TAB> will always insert softtabstop many spaces.
set tabstop=4 " Set the display width of the tab character ('\t') in spaces.

" Enable file type detection and load the filetype's syntax highlighting,
" indent, and plugin files if they exist.
"
" Plugins generally define an indentexpr to compute the indent of a line. When
" defined and active, such an expression overrides all other indent methods
" (obviating autoindent and smartindent). When not defined, plugins generally
" append to cinoptions.
filetype plugin indent on

" Override some default cinoptions that control auto-indentation:
"   L0 - Don't indent labels (prevents auto-indent of '::' operator.
"   l1 - Align with a case label instead of the statement after it on same line.
"   (0 - When in unclosed parentheses, align subsequent lines with the first non-whitespace char.
"   u0 - Same as (0, but for one level deeper. TODO - this necessary?
"   w1 - Align with the character after the unclosed parenthesis, even if it is whitespace.
"   Ws - If the unclosed ( is the last char in its line, indent the next line softtabstop spaces.
"   ks - Overide (0 and indent following if/for/while to keep inner indentation distinct.
"   j1 - Properly indent Java anonymous classes.
set cinoptions=L0,l1,(0,u0,w1,Ws,ks,j1

" TODO investigate cursorbind and scrollbind

colors petetay

" Informational display
set number relativenumber " Display absolute number on current line and relative on the rest.
set showcmd " Display an incomplete command in the lower-right corner.
set laststatus=2 " Always have status bar

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

" TODO map such that <BS> also removes the last digit when entering a number
" as part of a command (currently only <DEL> does this)
" suggested mapping :map CTRL-V <BS> CTRL-V <Del> doesn't appear to work

autocmd BufNewFile,BufRead *.tpp  set syntax=cpp

" TODO examine equalalways for splits
" also, splitbelow, splitright to set default location of new window
" also consider fillchars if the default fill characters aren't appropriate

" folding
" consider foldclose, foldcolumn, foldmethod

" formatprg - specify program to format the lines selected by gq
set hidden " buffers become hidden when abandoned

"syntax on        " Syntax highlighting! Yay! TODO needed? ON vs on?

" Scrolling
set scrolloff=1 " Minimum number of screen lines to keep above and below the cursor.
set sidescroll=1 " Scroll one column horizontally at a time when moving the cursor off the screen.
set sidescrolloff=1 " Never allow the cursor to move into the "extends"


"set showmatch " When a bracket is inserted, jump to the matching one for matchtime


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
"autocmd BufWritePre * : :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""
"" Background
""""""""""""""""""""""""""""""""""""""""
"TODO command to resource vimrc
"modify "include" and "includeexpr" per language?

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
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

set nojoinspaces " Only insert one space after [.?!] when the join command is used.

""""""""""""""""""""""""""""""""""""""""
"" Search
""""""""""""""""""""""""""""""""""""""""
set smartcase " Ignore case in search patterns unless one or more characters is uppercase
" TODO try out infercase to change insertion based on case of search
set gdefault              " applies substitutions globally on lines (reverse with g)
"au FocusLost * :wa " Save on losing focus?
