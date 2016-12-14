call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'

Plug 'NickeZ/epics.vim'

call plug#end()

" Enable Neomake to run asynchronously on save
autocmd! BufWritePost * Neomake

if has("gui_running")
  "set guifont=Inconsolata\ Medium\ 10
  set guifont=Hack\ 10
  set guioptions=aeR
  "colorscheme wombat
  set background=light
  colorscheme base16-solarized-light
else
  "set background=dark
  let base16colorspace=256  " Access colors present in 256 colorspace
  colorscheme base16-solarized-dark
endif

" Use spaces instead of tabs
set expandtab
" Ruler and line numbers
set ruler
set number

" Define indentation different per source
autocmd FileType sh set expandtab!
autocmd FileType sh set tabstop=4

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Display trailing characters
set list
set listchars=nbsp:¬,tab:»·,trail:·

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
    \ execute("normal `\"") |
  \ endif
