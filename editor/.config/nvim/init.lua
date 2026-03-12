-- Make sure to setup `mapleader` and `maplocalleader` first
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

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
vim.opt.list = true

vim.opt.modeline = false

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
-- Ctrl+h to stop searching
vim.keymap.set('v', '<C-g>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':tp<cr>')
vim.keymap.set('n', '<right>', ':tn<cr>')
-- Jump to next diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)

vim.lsp.set_log_level("off")

-- format c source and headers with clang-format
-- XXX: Replaced with lsp config below
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.c", "*.h"},
--   callback = function()
--     vim.lsp.buf.format({ async = true })
--   end,
-- })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        --if client.supports_method('textDocument/implementation') then
        --  -- Create a keymap for vim.lsp.buf.implementation
        --end
        --if client.supports_method('textDocument/completion') then
        --  -- Enable auto-completion
        --  vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
        --end
        --if client.supports_method('textDocument/formatting') then
        --    -- Format the current buffer on save
        --    vim.api.nvim_create_autocmd('BufWritePre', {
        --        buffer = args.buf,
        --        callback = function()
        --            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        --        end,
        --    })
        --end
    end,
})

-- Plugins!
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- main color scheme
        {
            "wincent/base16-nvim",
            lazy = false,    -- load at start
            priority = 1000, -- load first
            config = function()
                vim.cmd([[colorscheme gruvbox-dark-hard]])
                vim.o.background = 'dark'
                -- XXX: hi Normal ctermbg=NONE
                -- Make comments more prominent -- they are important.
                local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
                vim.api.nvim_set_hl(0, 'Comment', bools)
                -- Make it clearly visible which argument we're at.
                local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
                vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter',
                    { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
                -- XXX
                -- Would be nice to customize the highlighting of warnings and the like to make
                -- them less glaring. But alas
                -- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
                -- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
            end
        },
        'airblade/vim-gitgutter',
        'nvim-treesitter/nvim-treesitter',
        {
            'junegunn/fzf.vim',
            dependencies = {
                { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
            },
            config = function()
                -- stop putting a giant window over my editor
                vim.g.fzf_layout = { down = '~20%' }
                -- when using :Files, pass the file list through
                --
                --   https://github.com/jonhoo/proximity-sort
                --
                -- to prefer files closer to the current file.
                -- function list_cmd()
                --     local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
                --     if base == '.' then
                --         -- if there is no current file,
                --         -- proximity-sort can't do its thing
                --         return 'fd --type file --follow'
                --     else
                --         return vim.fn.printf('fd --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
                --     end
                -- end
                -- vim.api.nvim_create_user_command('Files', function(arg)
                --     vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--tiebreak=index' }, arg.bang)
                -- end, { bang = true, nargs = '?', complete = "dir" })
                -- vim.api.nvim_create_user_command('Files', function(arg)
                --     vim.fn['fzf#vim#files'](arg.qargs, { options = '--tiebreak=length' }, arg.bang)
                -- end, { bang = true, nargs = '?', complete = "dir" })
            end
        },
        'sindrets/diffview.nvim',
        {
            'neovim/nvim-lspconfig',
            event = { "BufReadPre", "BufNewFile" },
            keys = {
                { "gd",         vim.lsp.buf.definition,      desc = "Goto definition" },
                { "gr",         vim.lsp.buf.references,      desc = "References",            nowait = true },
                { "gI",         vim.lsp.buf.implementation,  desc = "Goto Implementations" },
                { "gy",         vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
                { "gD",         vim.lsp.buf.declaration,     desc = "Goto Declaration" },
                { "K",          vim.lsp.buf.hover,           desc = "Hover" },
                { "<leader>ca", vim.lsp.buf.code_action,     desc = "Code Action",           mode = { "n", "x" } },
                { "<leader>f",  vim.lsp.buf.format,          desc = "Format" },
            },
            config = function(_, opts)
                -- C/C++
                vim.lsp.config("clangd", {
                    cmd = { '/opt/clangd/bin/clangd' },
                    filetypes = { 'c', 'cpp' }
                })
                vim.lsp.enable("clangd")

                -- Rust
                vim.lsp.config("rust_analyzer", {
                    -- Server-specific settings. See `:help lspconfig-setup`
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                -- Use a separate build dir for RA
                                targetDir = true,
                                -- allFeatures = true,
                            },
                            -- imports = {
                            --     group = {
                            --         enable = false,
                            --     },
                            -- },
                            completion = {
                                postfix = {
                                    enable = false,
                                },
                            },
                            check = {
                                command = "clippy",
                                -- extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                })
                vim.lsp.enable("rust_analyzer")

                -- Python
                vim.lsp.enable("pyright")

                -- Swift
                vim.lsp.config("sourcekit", {
                    filetypes = { "swift" }
                })
                vim.lsp.enable("sourcekit")

                -- Lua
                vim.lsp.config("lua_ls", {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {
                                    'vim'
                                },
                            },
                        }
                    }
                })
                vim.lsp.enable("lua_ls")

                -- Go
                --lspconfig.gopls.setup {}
                vim.lsp.enable("gopls")

                -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            end
        },
        {
            "christoomey/vim-tmux-navigator",
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
            },
            keys = {
                { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        },
        -- rust
        -- {
        --     'rust-lang/rust.vim',
        --     ft = { "rust" },
        --     config = function()
        --         vim.g.rustfmt_autosave = 1
        --         vim.g.rustfmt_emit_files = 1
        --         vim.g.rustfmt_fail_silently = 0
        --         vim.g.rust_clip_command = 'wl-copy'
        --     end
        -- },
        {
            "f-person/auto-dark-mode.nvim",
            opts = {
                update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option_value("background", "dark", {})
                    vim.cmd("colorscheme gruvbox-dark-hard")
                    -- Make comments more prominent -- they are important.
                    local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
                    vim.api.nvim_set_hl(0, 'Comment', bools)
                    -- Make it clearly visible which argument we're at.
                    local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
                    vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter',
                        { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value("background", "light", {})
                    vim.cmd("colorscheme gruvbox-light-hard")
                    -- Make comments more prominent -- they are important.
                    local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
                    vim.api.nvim_set_hl(0, 'Comment', bools)
                    -- Make it clearly visible which argument we're at.
                    local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
                    vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter',
                        { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
                end,
            },
        },
        {
            "ludovicchabant/vim-gutentags",
            config = function()
                vim.g.gutentags_file_list_command = 'find . -type f -name "*.c"'
            end
        },
    },
})
