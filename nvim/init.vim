" =======
" Plugins
" =======

call plug#begin()
" Informational display
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace (but not in insert mode).
Plug 'airblade/vim-gitgutter' " git diff in the gutter; stage/revert hunks.
Plug 'bling/vim-airline' " Status line.

" Extra commands
Plug 'tpope/vim-eunuch' " Syntactic sugar for unix shell commands inside vim.
Plug 'junegunn/vim-easy-align' " Alignment commands

" Syntax
Plug 'PotatoesMaster/i3-vim-syntax' " Vim syntax file for i3 config file.
Plug 'sheerun/vim-polyglot' " A collection of language packs.

" Not working/untested
Plug 'nathanaelkane/vim-indent-guides' " Highlight syntactic indent levels in alternating colors.
Plug 'vim-scripts/EasyColour' " Alternate color scheme syntax.
call plug#end()

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" =======
" Display
" =======

call matchadd('ColorColumn', '\%>100v', -1) " Highlight (low-priority) column 100+.
colors petetay " Use my custom colorscheme.
set cursorline cursorcolumn " Turn on cursor cross-hairs.
set laststatus=2 " Always display the status bar.
set number relativenumber " Display absolute number on current line and relative on the rest.
set showcmd " Display an incomplete command in the lower-right corner.
set updatetime=500 " Milliseconds vim waits before updating gitgutter and swap file.
set nowrap " Don't wrap lines longer than the window width.

" Paren-matching
set showmatch " When a paren/bracket is inserted, jump to the matching one for matchtime
set matchtime=1 " Tenths of a second to show a match for.

" Configure status-line.
"   branch integrates with fugitive to display the current branch
"    - you can configure no-branch text, truncate name, and custom formatting
"   %f Path to the file in the buffer, as typed or relative to current directory.
"   %r - readonly flag, text is "[RO]"
"   %c - column number
"   %p - percentage through file in lines
call airline#parts#define_raw('column_number', '%c')
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', 'paste'])
    let g:airline_section_b = airline#section#create(['hunks'])
    let g:airline_section_c = airline#section#create(['%.100f']) " 100 characters max.
    let g:airline_section_gutter = airline#section#create(['readonly'])
    let g:airline_section_z = airline#section#create(['%p%%', ' ', 'column_number'])
    let g:airline_section_warning = airline#section#create(['whitespace'])
endfunction
autocmd User AirlineAfterInit call AirlineInit() " After plugin loads, but before it replaces statusline

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

" ===============
" Auto-formatting
" ===============

set nojoinspaces " Only insert one space after [.?!] when the join command is used.

" Setup indentation to use spaces by default.
set tabstop=4 " Set the display width of the tab character ('\t') in spaces.
set shiftwidth=0 " Indentation (<, >, cindent, etc) will insert/delete tabstop-many spaces.
set softtabstop=-1 " Pressing <TAB> (or <BS> on a tab) will insert (delete) shiftwidth-many spaces.
set shiftround " Round indent (<, >) to the next multiple of shiftwidth
               " (instead of strictly shiftwidth characters).
set expandtab " Insert spaces instead of tab characters.
              " Note that indenting will replace all tab characters on affected lines with spaces.

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

" =======
" Backend - affects how vim behaves
" =======

set mouse-=a " Disable the mouse.
set undofile " Create <FILENAME>.un that persists undo information across close/reopen.
set hidden " buffers become hidden when abandoned
autocmd BufNewFile,BufRead *.tpp  set syntax=cpp

" Set completion mode for wildmenu command-line completion.
" First press of <TAB> completes the longest common string and shows options in wildmenu.
" Subsequent <TAB>s complete matches in turn.
set wildmode=longest:full,full
set wildignorecase " Ignore case when completing file names and directories.

" Scrolling
set scrolloff=1 " Minimum number of screen lines to keep above and below the cursor.
set sidescroll=1 " Scroll one column horizontally at a time when moving the cursor off the screen.
set sidescrolloff=1 " Never allow the cursor to move into the "extends" indicator.

" Search
set ignorecase " Ignore case in search patterns.
set smartcase " Override ignorecase if the search pattern contains upper-case characters.
set gdefault " Apply substitutions globally on lines (reverse with g)

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

" =========
" Functions
" =========

" Disable key in Normal, Visual, Select, Operator-pending, and Insert modes.
function! Disable(key)
    execute 'noremap' a:key '<Nop>'
    execute 'inoremap' a:key '<Nop>'
endfunction

" ========
" Mappings
" ========

"" Disable the arrow keys (forced immersion learning)
call Disable('<Up>')
call Disable('<Down>')
call Disable('<Left>')
call Disable('<Right>')

:map <BS> <Del> " Allow <BS> to remove the last digit when entering a number (i.e. in 55G).

" Correct common capitalization errors in commands, forwarding arguments as needed.
command! -bang -nargs=? -complete=file E edit<bang> <args>
command! -bang -nargs=? -complete=file W write<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang Wa wall<bang>
command! -bang WA wall<bang>
command! -bang Q quit<bang>
command! -bang QA qall<bang>
command! -bang Qa qall<bang>

" ====
" TODO
" ====
set textwidth=0 " Don't automatically break lines.
" TODO toggle textwidth reasonable in appropriate filetypyes
" if leaving wrap on, consider breakindent which causes lines to be visually
" indented the same amount as the beginning of that line to preserve blocks of
" text
" also, linebreak and showbreak
