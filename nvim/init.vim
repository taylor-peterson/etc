call plug#begin()
Plug 'nathanaelkane/vim-indent-guides' " Highlight syntactic indent levels in alternating colors.
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace.

Plug 'PotatoesMaster/i3-vim-syntax' " Vim syntax file for i3 config file.
call plug#end()


" TODO cursor crosshairs, with second vertical line for where wants to be
" TODO hi ExtraWhitespace ctermbg=red '' default?

" TODO - does putting these before the rest of the highlighting fix cursor hilighting?
" Highlight 'eol', 'extends' and 'preceeds'
hi NonText ctermfg=3

" Highlight 'nbsp', 'space', 'tab', and 'trail'
hi SpecialKey ctermfg=0


" Replace whitespace characters (list) with a specified set of alternates (listchars).
"     eol:c      - Char to show at the end of each line: c=<unused>.
"     tab:xy     - Characters used to show a tab: x=y=u25b8 (▸).
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
set list listchars=tab:▸▸,space:·,extends:❭,precedes:❬,conceal:┊,nbsp:⎵

" Don't wrap lines longer than the window width.
set nowrap

" add to colorscheme file:
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
