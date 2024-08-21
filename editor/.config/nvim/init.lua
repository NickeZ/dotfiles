-- preferences
-- never ever folding
vim.o.foldenable = false
vim.o.foldmethod = 'manual'
vim.o.foldlevelstart = 99
-- keep more context on screen while scrolling
vim.o.scrolloff = 2
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.o.signcolumn = 'yes'
-- sweet sweet relative line numbers
vim.o.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- tabs: go big or go home
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- hotkeys
-- quick-open
vim.keymap.set('', '<C-p>', '<cmd>Files<cr>')
-- search buffers
vim.keymap.set('n', '<leader>;', '<cmd>Buffers<cr>')
-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')



-- Plugins!
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- main color scheme
        {
            "wincent/base16-nvim",
            lazy = false, -- load at start
            priority = 1000, -- load first
            config = function()
                vim.cmd([[colorscheme base16-gruvbox-light-hard]])
                vim.o.background = 'light'
                -- XXX: hi Normal ctermbg=NONE
                -- Make comments more prominent -- they are important.
                local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
                vim.api.nvim_set_hl(0, 'Comment', bools)
                -- Make it clearly visible which argument we're at.
                local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
                vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
                -- XXX
                -- Would be nice to customize the highlighting of warnings and the like to make
                -- them less glaring. But alas
                -- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
                -- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
            end
        },
        'nvim-treesitter/nvim-treesitter',
        'sindrets/diffview.nvim',

        -- add your plugins here
    },
})


--[[
call plug#begin()

Plug 'ellisonleao/gruvbox.nvim'
Plug '', {'do': ':TSUpdate'}
Plug 

call plug#end()

let g:gruvbox_italic=1
autocmd vimenter * ++nested colorscheme gruvbox

set background=dark
--]]
