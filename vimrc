"Icke VI kompatibel (måste vara först, ändrar inställningar)
set nocompatible

"Custom statusline
set statusline="%f%< %y[%{&fileencoding}/%{&encoding}/%{&termencoding}][%{&fileformat}](%n)%m%r%w %a%=%b 0x%B  L:%l/%L, C:%-7(%c%V%) %P"

"GVim
if has("gui_running")
  set guifont=Inconsolata\ Medium\ 10
  set guioptions=aeR
  colorscheme wombat
else
  colorscheme desert
endif

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
"set tabstop=4
set softtabstop=4 
set expandtab

"Cool completion
set wildmenu

"indentering
set autoindent
set shiftwidth=4

"linjaler och radräknare
set ruler
set number

"höjd på kommandoraden
set cmdheight=2

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
autocmd FileType c,cpp set tabstop=8
autocmd FileType c,cpp set softtabstop=8 
autocmd FileType c,cpp set shiftwidth=8

"JSON
"autocmd FileType json set smartindent
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd FileType javascript,json set tabstop=2
autocmd FileType javascript,json set softtabstop=2
autocmd FileType javascript,json set shiftwidth=2

"VHDL
autocmd Filetype vhdl call FT_vhdl()

"{{{TeX configuration
let g:Tex_Flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_UseMakefile=0
autocmd FileType tex,rst set textwidth=76
autocmd FileType tex,rst setlocal spell spelllang=en_gb
autocmd FileType tex,rst set tabstop=2
autocmd FileType tex,rst set softtabstop=2
autocmd FileType tex,rst set shiftwidth=2
"}}}

"netrw
let g:netrw_browse_split = 3
let g:netrw_list_hide = '^\..*'
let g:netrw_altv = 1
let g:netrw_winsize = 100

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

"My aliases
nnoremap Q gq

"Använd F11 för att toggla mellan paste, no-paste
set pastetoggle=<F10>
" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

"EPICS db
au BufRead,BufNewFile *.db setfiletype db

" Enable backup
set backup
set backupdir=~/.vim/backup
" Put swapfiles in tmpfolder
set directory=~/.vim/tmp

"Functions
function FT_vhdl()
    setlocal tabstop=2
    setlocal shiftwidth=2
    if exists("+omnifunc")
        setlocal omnifunc=syntaxcomplete#Complete
    endif
    setlocal makeprg=gmake
    setlocal errorformat=**\ Error:\ %f(%l):\ %m
    let g:vhdl_indent_genportmap=0
    map <buffer> <F4> :execute ':!vsim -c -do "run -all;exit" '.expand("%:t:r")<CR>
    " for taglist
    let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'
    " command mappings for perl scripts
    :command! -nargs=1 -complete=file VHDLcomp r! ~/.vhdl/vhdl_comp.pl <args>
    :command! -nargs=1 -complete=file VHDLinst r! ~/.vhdl/vhdl_inst.pl <args>
    " environments
    imap <buffer> <C-e>e <Esc>bdwientity <Esc>pa is<CR>end entity ;<Esc>POport (<CR>);<Esc>O
    imap <buffer> <C-e>a <Esc>b"zdwiarchitecture <Esc>pa of <Esc>mz?entity<CR>wyw`zpa is<CR>begin<CR>end architecture ;<Esc>"zPO
    imap <buffer> <C-e>p <Esc>bywA : process ()<CR>begin<CR>end process ;<Esc>PO<+process body+><Esc>?)<CR>i
    imap <buffer> <C-e>g <Esc>bdwipackage <Esc>pa is<CR><BS>end package ;<Esc>PO    
    imap <buffer> <C-e>c case  is<CR>when <+state1+> =><CR><+action1+><CR>when <+state2+> =><CR><+action2+><CR>when others => null;<CR>end case;<Esc>6k$2hi
    imap <buffer> <C-e>i if  then<CR><+do_something+>;<CR>elsif <+condition2+> then<CR><+do_something_else+>;<CR>else<CR><+do_something_else+>;<CR>end if;<Esc>6k$4hi
    " shortcuts
    imap <buffer> ,, <= 
    imap <buffer> .. => 
    imap <buffer> <C-s>i <Esc>:VHDLinst 
    imap <buffer> <C-s>c <Esc>:VHDLcomp
    " visual mappings
    vmap <C-a> :!~/.vhdl/vhdl_align.py<CR>
    vmap <C-d> :!~/.vhdl/vhdl_align_comments.py<CR>
    " alt key mappings
    imap <buffer> <M-i> <Esc>owhen 
    " abbreviations
    iabbr dt downto
    iabbr sig signal
    iabbr gen generate
    iabbr ot others
    iabbr sl std_logic
    iabbr slv std_logic_vector
    iabbr uns unsigned
    iabbr toi to_integer
    iabbr tos to_unsigned
    iabbr tou to_unsigned
    imap <buffer> I: I : in 
    imap <buffer> O: O : out 
    " emacs vhdl mode
    " warning: the following is dangerous, becase the file is written and then opened again, which means, the undo history is lost; if someting goes wrong, you may loose your file
    "command! EVMUpdateSensitivityList :w|:execute "!emacs --no-init-file --no-site-file -l ~/.vhdl/vhdl-mode.el -batch % --eval '(vhdl-update-sensitivity-list-buffer)' -f save-buffer" | :e
    "map <F12> :EVMUpdateSensitivityList<CR>
endfunction
