" Vim color file
" Based on darkblue.vim by Bohdan Vlasyuk <bohdan@vstu.edu.ua>

hi clear
set bg&
if exists("syntax_on")
	syntax reset
endif

let colors_name = "petetay"

"Highlight trailing text
hi ExtraWhitespace                 ctermbg=darkred
" Highlight 'eol', 'extends' and 'preceeds'
hi NonText	ctermfg=240       ctermbg=none      cterm=none
" Highlight 'nbsp', 'space', 'tab', and 'trail'
hi SpecialKey	ctermfg=238     ctermbg=none      cterm=none

hi IndentGuidesOdd ctermbg=darkgray
hi IndentGuidesEven ctermbg=black

" Text
hi Normal	ctermfg=lightgray      ctermbg=none      cterm=none

" Syntax Groups
hi Comment	ctermfg=darkred        ctermbg=none     cterm=none
hi Constant	ctermfg=darkmagenta    ctermbg=none     cterm=none
hi Identifier	ctermfg=darkcyan       ctermbg=none     cterm=none
hi Statement	ctermfg=darkyellow     ctermbg=none     cterm=none
hi PreProc	ctermfg=darkmagenta    ctermbg=none     cterm=none
hi Type		ctermfg=darkgreen      ctermbg=none     cterm=none
hi Special	ctermfg=brown          ctermbg=none     cterm=none
hi Underlined	ctermfg=none           ctermbg=none     cterm=underline
hi Ignore	ctermfg=none           ctermbg=none     cterm=none
"hi Error
" hack to avoid cursorline overwriting background color
" instead results in it overwriting the text color
" (becuase the colors are reversed...)
" only works if the specified bg color is comporable to the
" cursorline color
hi Todo		ctermfg=yellow	       ctermbg=black  cterm=reverse

" Vim Messages/Prompts
hi ErrorMsg	ctermfg=white          ctermbg=lightblue cterm=none
hi WarningMsg	ctermfg=red            ctermbg=none      cterm=none
  " showmode message (e.g --INSERT--)
hi ModeMsg	ctermfg=lightblue      ctermbg=none      cterm=none
hi MoreMsg	ctermfg=darkgreen      ctermbg=none      cterm=none
hi Question	ctermfg=green          ctermbg=none      cterm=none
hi WildMenu	ctermfg=yellow         ctermbg=black     cterm=none
hi Title	ctermfg=magenta        ctermbg=none      cterm=bold
hi Directory	ctermfg=cyan           ctermbg=none      cterm=none

" Visual Mode Selection
hi Visual	ctermfg=darkblue      ctermbg=fg        cterm=reverse

" Search
hi Search	ctermfg=white          ctermbg=darkblue  cterm=underline
hi IncSearch 	ctermfg=darkblue       ctermbg=gray      cterm=none

" Window seperator lines
hi StatusLine	ctermfg=black          ctermbg=240      cterm=none
hi StatusLineNC	ctermfg=black          ctermbg=240      cterm=none
hi VertSplit	ctermfg=black          ctermbg=240      cterm=none

" Folding - keep different from status lines or splits might be confusing.
hi Folded	ctermfg=darkgrey       ctermbg=black     cterm=bold
hi FoldColumn	ctermfg=darkgrey       ctermbg=black     cterm=bold
hi LineNr	ctermfg=green          ctermbg=none      cterm=none

" Vimdiff
hi DiffAdd	ctermfg=none           ctermbg=darkblue  cterm=none
hi DiffChange	ctermfg=none           ctermbg=magenta   cterm=none
hi DiffDelete	ctermfg=blue           ctermbg=cyan      cterm=none
hi DiffText	ctermfg=none           ctermbg=red       cterm=bold

" Cursor
" Character under the cursor
" If perf issues, turning off line/column highlighting could help
hi Cursor	ctermfg=black          ctermbg=yellow    cterm=none
hi lCursor	ctermfg=black          ctermbg=white     cterm=none
hi CursorLine                      ctermbg=233       cterm=none
hi CursorColumn                    ctermbg=233       cterm=none

hi ColorColumn                     ctermbg=red     cterm=none

" hi LineNr
" hi MatchParen

" Spelling
hi SpellBad    ctermfg=red             ctermbg=white       cterm=none
hi SpellCap    ctermfg=green           ctermbg=white       cterm=none
hi SpellLocal  ctermfg=cyan            ctermbg=white       cterm=none
hi SpellRare   ctermfg=magenta         ctermbg=white       cterm=none
