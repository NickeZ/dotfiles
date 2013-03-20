"GVim
if has("gui_running")
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
  set guioptions=aeR
  colorscheme wombat
else
  colorscheme desert
endif

"Icke VI kompatibel
set nocompatible

"Visa alltid tab-raden
set showtabline=2

"Aktivera filtypsidentifiering och inkludera eventuella plugins och indents
filetype plugin indent on

"Syntax highlighting
syntax on
set hlsearch

"Highlight current line
set cursorline

"mus
set mouse=a

"Antal kommando som sparas
set history=50

"spara i utf-8
set encoding=utf-8

"Använd mellanslag för tabbar
set expandtab

"Hur lång en tab ska va...
set tabstop=4
set softtabstop=4 

"indentering
set autoindent
set shiftwidth=4

"linjaler och radräknare
set ruler
set number

">80 column highlight
highlight OverL ctermbg=darkred ctermfg=white guibg=#000000
match OverL /\%>80v.\+/

"Display trailing characters
set list
set listchars=tab:»·,trail:·

"PHP
"autocmd FileType php set smartindent
let g:php_sql_query=0
"let g:php_htmlInStrings=1
let g:php_folding=3
let g:php_smart_members=1
let g:php_alt_properties=1

"CSS,JS
"autocmd FileType css,javascript set smartindent

"C
"autocmd FileType c set cindent
autocmd FileType c set tabstop=8
autocmd FileType c set softtabstop=8 
autocmd FileType c set shiftwidth=8

"JSON
"autocmd FileType json set smartindent
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd FileType javascript,json set tabstop=2
autocmd FileType javascript,json set softtabstop=2
autocmd FileType javascript,json set shiftwidth=2

"TeX
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'
let g:Tex_MultipleCompileFormats='pdf'
autocmd FileType tex set textwidth=76
autocmd FileType tex setlocal spell spelllang=en_gb

"netrw
let g:netrw_browse_split = 3
let g:netrw_list_hide = '^\..*'
let g:netrw_altv = 1
let g:netrw_winsize = 100

"My aliases
nnoremap Q gq
