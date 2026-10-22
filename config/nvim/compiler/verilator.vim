" ~/.vim/compiler/verilator.vim
if exists("b:current_compiler")
  finish
endif
let b:current_compiler = "verilator"

let s:cpo_save = &cpo
set cpo&vim

let s:verilator_efm = join([
    \ '%%%trror-%\w%#: %f:%l:%c: %m',
    \ '%%%trror-%\w%#: %f:%l: %m',
    \ '%%%trror: %f:%l:%c: %m',
    \ '%%%trror: %f:%l: %m',
    \ '%%%tarning-%\w%#: %f:%l:%c: %m',
    \ '%%%tarning-%\w%#: %f:%l: %m',
    \ '%%%tarning: %f:%l:%c: %m',
    \ '%%%tarning: %f:%l: %m',
    \ ], ',')

" Set both global and buffer-local errorformat so :make works across all buffers
let &errorformat = s:verilator_efm
let &l:errorformat = s:verilator_efm

unlet s:verilator_efm
let &cpo = s:cpo_save
unlet s:cpo_save
