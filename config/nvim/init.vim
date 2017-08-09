call plug#begin()

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'NickeZ/base16-vim', { 'branch': 'improve-highlight-readability' }
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'

Plug 'NickeZ/epics.vim'

call plug#end()

" Required for operations modifying multiple buffers like rls rename
set hidden

" Simple template support (template.h would be loaded for new *.h files)
au BufNewFile * silent! 0r ~/.vim/skeleton/template.%:e

" Python support
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3.5'

" Enable Neomake to run asynchronously on open and save
autocmd! BufWinEnter,BufWritePost * Neomake

" Neomake configuration
" Enable messages
"let g:neomake_verbose = 3
" Open the list of errors without moving the cursor
let g:neomake_open_list = 2
let $NEOMAKE_CARGO = 1

" Default to GCC instead of clang
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_cpp_enabled_makers = ['gcc']

" Enable cargo for rust files (Not needed if RLS works)
"let g:neomake_rust_enabled_makers = []
"let g:neomake_enabled_makers = ['cargo']
"let g:neomake_cargo_args = [ 'check' ]

let g:neomake_python_python_exe = 'python3'

" Sample configuration to put in .local.vimrc
"let g:neomake_c_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']
"let g:neomake_cpp_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++0x', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" Enable debugging for LC
"autocmd! FileType rust :call LanguageClient_setLoggingLevel('DEBUG')

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enable clang format for c/c++
" TODO(nc): Only enablef or c/c++
" map <C-K> :pyf /usr/share/clang/clang-format-3.9/clang-format.py<cr>
" imap <C-K> <c-o>:pyf /usr/share/clang/clang-format-3.9/clang-format.py<cr>

let g:deoplete#enable_at_startup = 1

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
  " Enable beam as cursor
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
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
