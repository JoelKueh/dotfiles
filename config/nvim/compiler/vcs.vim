" Vim compiler file
" Compiler:     Synopsys VCS (Verilog / SystemVerilog)
" Usage:        :compiler vcs

if exists("current_compiler")
  finish
endif
let current_compiler = "vcs"

let s:cpo_save = &cpo
set cpo-=C

" Only set makeprg if explicitly overridden via g:vcs_makeprg
if exists("g:vcs_makeprg")
  let &l:makeprg = g:vcs_makeprg
endif

" NOTE: Because we assign to &l:errorformat via single-quoted strings:
"   - Commas in patterns are escaped once: \,
"   - Spaces are NOT escaped
"   - Regex items like \[ and \+ use single backslashes
let s:efm = [
      \ '%EError-\[%.%\+\] %m',
      \ '%WWarning-\[%.%\+\] %m',
      \ '%WWarning-\[%.%\+\]$',
      \ '%ILint-\[%.%\+\] %m',
      \ '%C%f\, %l',
      \ '%C%\s%\+\"%f\"\, %l%.%#',
      \ '%Z%p^',
      \ '%Z',
      \ '%C%\s%\+%m',
      \ '%C%m',
      \ ]

let &l:errorformat = join(s:efm, ',')

let &cpo = s:cpo_save
unlet s:cpo_save
