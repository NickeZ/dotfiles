call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'

Plug 'NickeZ/epics.vim'

call plug#end()

"Enable Neomake to run asynchronously on save
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

"Define indentation different per source
autocmd FileType sh set expandtab!
autocmd FileType sh set tabstop=4

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
"
"Display trailing characters
set list
set listchars=nbsp:¬,tab:»·,trail:·
