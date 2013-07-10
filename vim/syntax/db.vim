" Vim syntax file
" Language:         EPICS db file
" Maintainer:       Niklas Claesson
" Latest Revision:  21 June 2013

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword dbStatement record field

syn match dbComment "#.*$"

syn region dbString start=+"+ skip=+\\"+ end=+"+ extend

hi def link dbComment   Comment
hi def link dbString    String
hi def link dbStatement Continue

let b:current_syntax = "db"

