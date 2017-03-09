call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'NickeZ/base16-vim', { 'branch': 'improve-highlight-readability' }
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'

Plug 'NickeZ/epics.vim'

call plug#end()

" Enable Neomake to run asynchronously on open and save
autocmd! BufWinEnter,BufWritePost * Neomake
autocmd! BufWritePost, *.rs Neomake! cargo

" Neomake configuration
" Enable messages
"let g:neomake_verbose = 3
" Open the list of errors without moving the cursor
let g:neomake_open_list = 2

" Default to GCC instead of clang
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_cpp_enabled_makers = ['gcc']

" Enable cargo for rust files
let g:neomake_rust_enabled_makers = []
let g:neomake_enabled_makers = ['cargo']
"let g:neomake_rust_enabled_makers = ['cargo']

" Sample configuration to put in .local.vimrc
"let g:neomake_c_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']
"let g:neomake_cpp_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++0x', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']

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
