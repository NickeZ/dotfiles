"Fixa gvim inställningar
if has("gui_running")
  set guifont=Monospace\ 8
  set guioptions=aeR
endif

"gör den icke vi-kompatibel
set nocompatible

"Syntax highlighting
syntax on
set hlsearch

"mus
set mouse=a

"Antal kommando som sparas
set history=50

"spara i utf-8
set encoding=utf-8

"Hur lång en tab ska va...
set tabstop=4
set softtabstop=4 
set shiftwidth=4
set expandtab

"indentering
set autoindent


"linjaler och radräknare
set ruler
set number

"Lite specialare för php
filetype on
filetype plugin indent on
autocmd FileType css,php set smartindent
autocmd FileType php colorscheme elflord
autocmd FileType python colorscheme desert
autocmd FileType json set tabstop=2
autocmd FileType json set softtabstop=2
autocmd FileType json set shiftwidth=2
autocmd BufNewFile,BufRead *.json set ft=javascript

"phpvariabler
let g:php_sql_query=1
let g:php_folding=3
let g:php_smart_members=1
let g:php_alt_properties=1

"blandat
let g:netrw_browse_split = 3
let g:netrw_list_hide = '^\..*'
let g:netrw_altv = 1
let g:netrw_winsize = 100

"Visa tabbarna
set showtabline=2

"tex-filer
filetype plugin on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
