scriptencoding utf-8

call plug#begin()

Plug 'neovim/nvim-lsp'

Plug 'junegunn/vader.vim'
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'NickeZ/base16-vim', { 'branch': 'improve-highlight-readability' }
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/echodoc.vim'
"Plug 'kana/vim-smartinput'
"Plug 'Rip-Rip/clang_complete'
" Vimfiler depends on unite
"Plug 'Shougo/unite.vim'
"Plug 'Shougo/vimfiler.vim'
Plug 'igankevich/mesonic'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'lifepillar/vim-solarized8'

Plug 'NickeZ/epics.vim'
Plug 'rhysd/vim-clang-format'

Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'

Plug 'embear/vim-localvimrc'
Plug 'dart-lang/dart-vim-plugin'
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 2

call plug#end()

lua require'nvim_lsp'.rust_analyzer.setup({})

" Remove -- INSERT --
set noshowmode
let g:lightline = {
        \'colorscheme': 'solarized',
        \ 'component_function': {
        \   'filename': 'LightlineFilename',
        \ },
        \}

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" sneak config
let g:sneak#s_next = 1

" Required for operations modifying multiple buffers like rls rename
set hidden

set diffopt+=iwhite
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Set filetype of meson.build to python
"au BufNewFile,BufRead meson.build set filetype javascript
augroup filetype_jenkins
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
augroup END

" Simple template support (template.h would be loaded for new *.h files)
augroup templates
  autocmd!
  autocmd BufNewFile * silent! 0r ~/.vim/skeleton/template.%:e
augroup END

" Python support
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" Enable Neomake to run asynchronously on open and save
"autocmd! BufWinEnter,BufWritePost * Neomake
" w - write buffer (never delayed)
" n - normal mode change
" r - reading buffer
" i - changes in insert
call neomake#configure#automake('nrw', 500)

augroup filetype_rust
  autocmd!
  autocmd BufWritePost *.rs :Neomake! clippy
  autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
  autocmd FileType rust nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  autocmd FileType rust nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  autocmd FileType rust nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  autocmd FileType rust nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  autocmd FileType rust nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  autocmd FileType rust nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  autocmd FileType rust nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
augroup END

" Always show signcolumn
set signcolumn=yes:1


" Neomake configuration
" Enable messages
"let g:neomake_verbose = 3
" Open the list of errors without moving the cursor
let g:neomake_open_list = 2

" Default to GCC instead of clang
let g:neomake_c_enabled_makers = []
let g:neomake_c_clangcheck_exe = "clang-check-8"
let g:neomake_cpp_enabled_makers = ['gcc']
" use python lang server instead
let g:neomake_python_enabled_makers = ['pylint', 'mypy']
"let g:neomake_python_enabled_makers = []
" use rust lang server or clippy instead
let g:neomake_rust_enabled_makers = []

let g:neomake_python_mypy_args = ['--check-untyped-defs', '--ignore-missing-imports']
"let g:neomake_python_pylint_args = [
"            \ '--output-format=text',
"            \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
"            \ '--reports=no',
"            \ ''
"            \ ]

" Enable cargo for rust files (Not needed if RLS works)
"let g:neomake_rust_enabled_makers = []
"let g:neomake_enabled_makers = ['cargo']
"let g:neomake_cargo_args = [ 'check' ]

let g:neomake_python_python_exe = 'python3'

augroup filetype_c
  autocmd!
  autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
  autocmd FileType c,cpp setlocal shiftwidth=4
augroup END
"autocmd FileType c,cpp,objc nnoremap <buffer><C-r><C-d> :<C-u>ClangFormat<CR>
"
let g:clang_format#command = 'clang-format-7'

augroup filetype_xml
  autocmd!
  autocmd Filetype xml setlocal shiftwidth=2
augroup END

" Sample configuration to put in .lvimrc
"let g:neomake_c_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']
"let g:neomake_cpp_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++0x', '-I/opt/epics/bases/base-3.14.12.5/include', '-I/opt/epics/bases/base-3.14.12.5/include/os/Linux', '-I/opt/epics/modules/environment/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/asyn/4.27.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/nds3/niklasclaesson/3.14.12.5/include', '-I/opt/epics/modules/devlib2/2.6.0/3.14.12.5/include', '-I/opt/epics/modules/ifcdaqdrv/niklasclaesson/3.14.12.5/include']
"let g:neomake_cpp_gcc_exe = 'neomake-cpp'
let g:neomake_cpp_gcc_args = ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++17']

let g:clang_library_path = '/usr/lib/llvm-4.0/lib/libclang.so.1'
let g:clang_debug = 1

"\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }
let g:LanguageClient_settingsPath = expand('~/.config/nvim/settings.json')

" Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" Enable debugging for LC
"let g:LanguageClient_loggingFile = '/tmp/niklas.log'
"let g:LanguageClient_loggingLevel = 'DEBUG'

" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> <leader>lf :call LanguageClient_textDocument_formatting()<CR>
" nnoremap <silent> <leader>e :call LanguageClient#explainErrorAtPoint()<CR>




inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:rustfmt_autosave = 1
let g:rustfmt_options = '--edition 2018'

" Enable clang format for c/c++
" TODO(nc): Only enablef or c/c++
" map <C-K> :pyf /usr/share/clang/clang-format-3.9/clang-format.py<cr>
" imap <C-K> <c-o>:pyf /usr/share/clang/clang-format-3.9/clang-format.py<cr>

" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)

" Configure vimfiler
"let g:vimfiler_as_default_explorer = 1
"autocmd VimEnter * if !argc() | Explore | endif
"autocmd VimEnter * VimFilerExplorer

if has('gui_running')
  "set guifont=Inconsolata\ Medium\ 10
  set guifont=Hack\ 10
  set guioptions=aeR
  "colorscheme wombat
  set background=light
  "colorscheme base16-solarized-light
  colorscheme solarized8
else
  "set background=dark
  "let base16colorspace=256  " Access colors present in 256 colorspace
  "colorscheme base16-solarized-dark
  "colorscheme base16-solarized-light
  set termguicolors
  set background=dark
  colorscheme solarized8
  " Enable beam as cursor
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

  highlight clear Search
  highlight Search gui=underline
endif

" Use spaces instead of tabs
set expandtab
" Ruler and line numbers
set ruler
set number

" tabstop - number of spaces that <Tab> counts for
" softtabstop - number of spaces that <Tab> counts for while performing editing operations (like
"               inserting a <Tab> or <BS>). -1 means use 'shiftwidth'
" shiftwidth - number of spaces to use after each step of (auto)indent
set softtabstop=-1

" Define indentation different per source
augroup filetype_sh
  autocmd!
  autocmd FileType sh setlocal noexpandtab
  autocmd FileType sh setlocal tabstop=4
  autocmd FileType sh setlocal shiftwidth=4
augroup END

" Use google default for cpp
"autocmd FileType cpp set softtabstop=2
"autocmd FileType cpp set shiftwidth=2

augroup filetype_js
  autocmd!
  autocmd FileType javascript,yaml setlocal shiftwidth=2
augroup END

augroup filetype_python
  autocmd!
  autocmd FileType python setlocal textwidth=99
  autocmd FileType python setlocal colorcolumn=93,+1
augroup END

augroup filetype_php
  autocmd!
  autocmd FileType php setlocal shiftwidth=2
augroup END

augroup filetype_cmake
  autocmd!
  autocmd FileType cmake setlocal shiftwidth=2
  autocmd FileType cmake setlocal textwidth=0
augroup END

augroup filetype_rs
  autocmd!
  autocmd FileType rust noremap <Leader>f :RustFmt<CR>
augroup END

" Indentation for cpp
set cinoptions=N-s,g0,:0,(4

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Display trailing characters
set list
set listchars=nbsp:¬,tab:»·,trail:·

" Wrap at 100 chars by default
set textwidth=99

" Highlight the column after textwidth
set colorcolumn=+1

" Enable mouse by default
set mouse=a

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
augroup filetype_gitcommit
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
      \ execute("normal `\"") |
    \ endif
augroup END

"ino " ""<left>
"ino ' ''<left>
"ino ( ()<left>
"ino [ []<left>
"ino { {}<left>
"ino {<CR> {<CR>}<ESC>O
"ino {;<CR> {<CR>};<ESC>O

"sane splits
set splitright
set splitbelow

" proper search
set incsearch
set ignorecase
set smartcase

set path+=**

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set grepprg=rg\ -n

noremap <Leader>m :make!<CR>
