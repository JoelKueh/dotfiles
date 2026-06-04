hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "kanagawa_hx"

" ------------------------------------------------------------------
" Palette
" ------------------------------------------------------------------

let s:oldWhite      = "#C8C093"
let s:fujiWhite     = "#DCD7BA"
let s:fujiGray      = "#727169"

let s:sumiInk0      = "#16161D"
let s:sumiInk3      = "#1F1F28"
let s:sumiInk4      = "#2A2A37"
let s:sumiInk5      = "#363646"
let s:sumiInk6      = "#54546D"

let s:waveBlue1     = "#223249"
let s:waveBlue2     = "#2D4F67"

let s:autumnGreen   = "#76946A"
let s:autumnRed     = "#C34043"
let s:autumnYellow  = "#DCA561"

let s:samuraiRed    = "#E82424"
let s:roninYellow   = "#FF9E3B"
let s:waveAqua1     = "#6A9589"
let s:dragonBlue    = "#658594"

let s:oniViolet     = "#957FB8"
let s:oniViolet2    = "#B8B4D0"

let s:crystalBlue   = "#7E9CD8"

let s:springViolet2 = "#9CABCA"
let s:springBlue    = "#7FB4CA"

let s:lightBlue     = "#A3D4D5"

let s:waveAqua2     = "#7AA89F"

let s:springGreen   = "#98BB6C"

let s:boatYellow2   = "#C0A36E"
let s:carpYellow    = "#E6C384"

let s:sakuraPink    = "#D27E99"

let s:waveRed       = "#E46876"
let s:peachRed      = "#FF5D62"

let s:surimiOrange  = "#FFA066"

" ------------------------------------------------------------------
" Helper
" ------------------------------------------------------------------

function! s:Hi(group, fg, bg, attr) abort
  execute printf(
        \ 'highlight %s guifg=%s guibg=%s gui=%s cterm=%s',
        \ a:group,
        \ empty(a:fg) ? 'NONE' : a:fg,
        \ empty(a:bg) ? 'NONE' : a:bg,
        \ empty(a:attr) ? 'NONE' : a:attr,
        \ empty(a:attr) ? 'NONE' : a:attr)
endfunction

" ------------------------------------------------------------------
" UI
" ------------------------------------------------------------------

call s:Hi('Normal',        s:fujiWhite,  s:sumiInk3, '')
call s:Hi('LineNr',        s:sumiInk6,   '', '')
call s:Hi('CursorLineNr',  s:roninYellow,'', 'bold')

call s:Hi('StatusLine',    s:oldWhite,   s:sumiInk0, '')
call s:Hi('StatusLineNC',  s:fujiGray,   s:sumiInk0, '')

call s:Hi('Visual',        '',           s:waveBlue2, '')
call s:Hi('CursorLine',    '',           s:sumiInk5, '')
call s:Hi('CursorColumn',  '',           s:sumiInk5, '')
call s:Hi('ColorColumn',   '',           s:sumiInk4, '')

call s:Hi('VertSplit',     s:sumiInk4,   s:sumiInk3, '')
call s:Hi('WinSeparator',  s:sumiInk4,   s:sumiInk3, '')

call s:Hi('Pmenu',         s:fujiWhite,  s:waveBlue1, '')
call s:Hi('PmenuSel',      s:fujiWhite,  s:waveBlue2, 'bold')
call s:Hi('PmenuSbar',     s:oldWhite,   s:waveBlue1, '')
call s:Hi('PmenuThumb',    s:fujiWhite,  s:waveBlue2, '')

call s:Hi('Search',        s:fujiWhite,  s:waveBlue2, '')
call s:Hi('IncSearch',     s:sumiInk0,   s:crystalBlue, 'bold')

call s:Hi('MatchParen',    s:waveRed,    '', 'bold')

call s:Hi('Folded',        s:sumiInk6,   s:sumiInk4, '')
call s:Hi('SignColumn',    s:sumiInk6,   s:sumiInk3, '')

call s:Hi('Directory',     s:springBlue, '', '')

call s:Hi('ErrorMsg',      s:samuraiRed, '', 'bold')
call s:Hi('WarningMsg',    s:roninYellow,'', 'bold')

" ------------------------------------------------------------------
" Diff
" ------------------------------------------------------------------

call s:Hi('DiffAdd',       s:autumnGreen,  '', '')
call s:Hi('DiffDelete',    s:autumnRed,    '', '')
call s:Hi('DiffChange',    s:autumnYellow, '', '')
call s:Hi('DiffText',      s:oldWhite,     s:waveBlue2, 'bold')

" ------------------------------------------------------------------
" Syntax
" ------------------------------------------------------------------

call s:Hi('Comment',       s:fujiGray,     '', '')
call s:Hi('Constant',      s:surimiOrange, '', '')
call s:Hi('String',        s:springGreen,  '', '')
call s:Hi('Character',     s:springGreen,  '', '')
call s:Hi('Number',        s:sakuraPink,   '', '')
call s:Hi('Boolean',       s:surimiOrange, '', '')
call s:Hi('Float',         s:sakuraPink,   '', '')

call s:Hi('Identifier',    s:fujiWhite,    '', '')
call s:Hi('Function',      s:crystalBlue,  '', '')

call s:Hi('Statement',     s:oniViolet,    '', 'italic')
call s:Hi('Conditional',   s:oniViolet,    '', 'italic')
call s:Hi('Repeat',        s:oniViolet,    '', 'italic')
call s:Hi('Keyword',       s:oniViolet,    '', 'italic')
call s:Hi('Exception',     s:peachRed,     '', '')

call s:Hi('Operator',      s:boatYellow2,  '', '')

call s:Hi('PreProc',       s:waveRed,      '', '')
call s:Hi('Include',       s:surimiOrange, '', '')
call s:Hi('Define',        s:waveRed,      '', '')
call s:Hi('Macro',         s:waveRed,      '', '')

call s:Hi('Type',          s:waveAqua2,    '', '')
call s:Hi('StorageClass',  s:waveAqua2,    '', '')
call s:Hi('Structure',     s:waveAqua2,    '', '')
call s:Hi('Typedef',       s:waveAqua2,    '', '')

call s:Hi('Special',       s:peachRed,     '', '')
call s:Hi('SpecialChar',   s:boatYellow2,  '', 'bold')
call s:Hi('Tag',           s:waveAqua2,    '', '')

call s:Hi('Label',         s:springBlue,   '', '')
call s:Hi('Delimiter',     s:springViolet2,'', '')

call s:Hi('Title',         s:crystalBlue,  '', 'bold')
call s:Hi('Underlined',    s:lightBlue,    '', 'underline')

" ------------------------------------------------------------------
" Diagnostics (LSP)
" ------------------------------------------------------------------

highlight DiagnosticError guifg=#E82424
highlight DiagnosticWarn  guifg=#FF9E3B
highlight DiagnosticInfo  guifg=#658594
highlight DiagnosticHint  guifg=#6A9589

highlight DiagnosticUnderlineError gui=undercurl guisp=#E82424
highlight DiagnosticUnderlineWarn  gui=undercurl guisp=#FF9E3B
highlight DiagnosticUnderlineInfo  gui=undercurl guisp=#658594
highlight DiagnosticUnderlineHint  gui=undercurl guisp=#6A9589

" ------------------------------------------------------------------
" Treesitter (Neovim)
" ------------------------------------------------------------------

highlight @comment           guifg=#727169

highlight @type              guifg=#7AA89F
highlight @type.builtin      guifg=#7FB4CA

highlight @function          guifg=#7E9CD8
highlight @function.builtin  guifg=#7FB4CA
highlight @function.macro    guifg=#E46876

highlight @variable          guifg=#DCD7BA
highlight @variable.builtin  guifg=#E46876
highlight @parameter         guifg=#B8B4D0
highlight @property          guifg=#E6C384

highlight @constant          guifg=#FFA066
highlight @number            guifg=#D27E99

highlight @string            guifg=#98BB6C
highlight @string.regex      guifg=#C0A36E

highlight @keyword           guifg=#957FB8 gui=italic
highlight @operator          guifg=#C0A36E

highlight @tag               guifg=#7AA89F
highlight @namespace         guifg=#FFA066
