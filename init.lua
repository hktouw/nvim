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

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.ruby" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.ui.mini-starter" },
    { 'projekt0n/github-nvim-theme', name = 'github-theme' },
    { "folke/flash.nvim", enabled = false },
    { "echasnovski/mini.pairs", enabled = false },
    { "akinsho/bufferline.nvim", enabled = false },
    { "Saghen/blink.cmp", enabled = false },
    { "Saghen/blink.cmp", enabled = false },
    { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
    { "mfussenegger/nvim-lint", enabled = false },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-git" },
    { "junegunn/gv.vim" }, -- Automatically add `end` to blocks
    { "tpope/vim-endwise" }, -- Repeat plugin commands with `.`
    { "tpope/vim-repeat" }, -- Easily surround text with delimiters
    { "tpope/vim-surround" }, -- Delimiters
    { "tpope/vim-abolish" }, -- Multi-cursor editing
    { "mg979/vim-visual-multi", branch = "master" }, -- Markdown-style table editing
    { "dhruvasagar/vim-table-mode" }, -- Easily split and join lines
    { "AndrewRadev/splitjoin.vim" },
    { "folke/trouble.nvim", opts = { use_diagnostic_signs = true } },
    { "folke/snacks.nvim", opts = { scroll = { enabled = false } } },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "github_dark_default",
        background = "dark",
      },
    },

    {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
      config = true,
    },
    {
      "ibhagwan/fzf-lua",
      opts = function()
        local fzf_actions = require("fzf-lua.actions")
        return {
          winopts = {
            width = 0.99, -- Set the width (90% of the screen width)
            height = 0.99, -- Optionally, set the height as well
            preview = {
              layout = "vertical", -- Default is "horizontal"
            },
          },
          actions = {
            files = {
              ["default"] = fzf_actions.file_edit, -- Open in the current window
              ["ctrl-t"] = fzf_actions.file_tabedit, -- Open in a vertical split
              ["ctrl-v"] = fzf_actions.file_vsplit, -- Open in a vertical split
              ["ctrl-x"] = fzf_actions.file_split,  -- Open in a horizontal split
            },
          },
        }
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      opts = function(_, opts)
        opts.filters = {
          dotfiles = false, -- Set to false to show dotfiles
        }
        return opts
      end
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = function(_, opts)
        opts.filesystem = {
          filtered_items = {
            hide_dotfiles = false, -- Show dotfiles
          },
        }
        return opts
      end,
    },
    -- add more treesitter parsers
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "graphql",
          "html",
          "javascript",
          "json",
          "go",
          "lua",
          -- "markdown",
          -- "markdown_inline",
          "python",
          "query",
          "regex",
          "ruby",
          "terraform",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        highlight = {
          enable = true,
          disable = { "markdown", "markdown_inline" }, -- Disable for Markdown
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
        },
      },
    },

    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "omnisharp",
          "stylua",
          "shellcheck",
          "shfmt",
          "flake8",
          "typescript-language-server",
          "sorbet",
        },
      },
    },
    -- Use <tab> for completion and snippets (supertab)
    -- setup supertab in cmp
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-emoji",
      },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- this way you will only jump inside the snippet region
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        })
      end,
    },

    {
      "folke/noice.nvim",
      opts = {
        messages = { enabled = false },
        presets = {
          lsp_doc_border = true,
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = function(_, opts)
        -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        -- change a keymap
        keys[#keys + 1] = { "gr", "<cmd>FzfLua lsp_references <cr>" }

        opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
          virtual_text = false,
          underline = false,
          float = { border = "rounded" },
        })
        opts.servers = {
          -- Ensure mason installs the server
          omnisharp = {},
          marksman = false,
          vtsls = false,
          ltex = {          -- Optional: Disable ltex for Markdown
            enabled = false,
            filetypes = {}, -- Prevent it from attaching to Markdown files
          },
        }
        -- Configure server-specific setup
        opts.setup = {
          marksman = function(_, _)
            return false -- Ensure marksman doesn't start
          end,
          omnisharp = function(_, _)
            require("lazyvim.util").lsp.on_attach(function(client, _)
              if client.name == "omnisharp" then
                ---@type string[]
                local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
                for i, v in ipairs(tokenModifiers) do
                  tokenModifiers[i] = v:gsub(" ", "_")
                end
                ---@type string[]
                local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
                for i, v in ipairs(tokenTypes) do
                  tokenTypes[i] = v:gsub(" ", "_")
                end
              end
            end)
            return false
          end,
        }
        return opts
      end,
    },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})



--------------------
---Autocommands-----
--------------------

-- Autocommands
vim.api.nvim_create_augroup("vimrcEx", { clear = true })
-- Restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "vimrcEx",
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "gitcommit" and vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})
-- Set filetypes for specific patterns
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = "vimrcEx",
  pattern = "Appraisals",
  command = "set filetype=ruby"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = "vimrcEx",
  pattern = "*.md",
  command = "set filetype=markdown"
})
vim.api.nvim_create_user_command("SR", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  require("lazy").sync()
end, {})

-- Disable spell check
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = false
  end,
})



---------------
---Options-----
---------------

vim.o.compatible = false
vim.scriptencoding = "utf-8"     -- Fix encoding issues
vim.o.encoding = "utf-8"
vim.g.mapleader = " "
vim.o.backspace = "2"           -- Allow backspace to delete indents, EOLs, etc.
vim.o.backup = false            -- Disable backup file creation
vim.o.writebackup = false       -- Disable write backup creation
vim.o.swapfile = false          -- Disable swap file creation
vim.o.history = 50              -- Number of commands to remember in history
vim.o.showcmd = true            -- Display incomplete commands
vim.o.incsearch = true          -- Incrementally highlight search matches
vim.o.laststatus = 2            -- Always show the status line
vim.o.autowrite = true          -- Automatically save before running commands
vim.opt.relativenumber = false  -- Disable relative line numbering
vim.opt.wrap = true             -- Enable line wrapping
vim.diagnostic.config({ virtual_text = false }) -- Disable inline diagnostic messages
vim.g.autoformat = false        -- Disable automatic code formatting
vim.g.root_spec = { ".git" }    -- Define project root as a directory containing ".git"
vim.o.conceallevel = 0          -- Display all characters without concealment
vim.o.tabstop = 2               -- Number of spaces per tab
vim.o.shiftwidth = 2            -- Spaces to use for each level of indentation
vim.o.shiftround = true         -- Round indentation to the nearest multiple of shiftwidth
vim.o.expandtab = true          -- Convert tabs to spaces
vim.o.list = true               -- Display whitespace characters
vim.o.listchars = "tab:»·,trail:·,nbsp:·" -- Define symbols for whitespace display
vim.o.background = "dark"       -- Set the background to dark mode
vim.o.number = true             -- Enable line numbers
vim.o.numberwidth = 5           -- Set the width of the line number column
vim.g.NumberToggleTrigger = "<Leader>b" -- Set keybinding for toggling line numbering
vim.g.PreserveNoEOL = 1         -- Preserve files with no trailing newline
vim.opt.textwidth = 0           -- Disable automatic line wrapping at a specific width
vim.opt.shiftwidth = 2          -- Set indentation width to 2 spaces (duplicate entry)
vim.opt.cursorline = false      -- Disable highlighting of the current line


---------------
---KeyMaps-----
---------------

local Util = require("lazyvim.util")
vim.keymap.set("n", "\\", Util.pick("live_grep"))
vim.keymap.set("n", "<C-p>", "<leader>ff", { desc = "Search Files", remap = true })
vim.keymap.set("n", "ge", "<leader>cd", { desc = "Run diagnostics", remap = true })
vim.api.nvim_set_keymap('n', '-', ':Explore<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "c*", "*Ncgn")
vim.keymap.set('n', 'gt', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gT', ':tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'te', ':tabedit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tc', ':tabclose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tm', ':tabmove<CR>', { noremap = true, silent = true })

-- vimrc local
-- Resize windows with <Leader> shortcuts
vim.api.nvim_set_keymap("n", "<Leader>-", ":vertical resize +5<CR>", { noremap = true, silent = true }) -- Increase width of vertical split
vim.api.nvim_set_keymap("n", "<Leader>=", ":vertical resize -5<CR>", { noremap = true, silent = true }) -- Decrease width of vertical split
vim.api.nvim_set_keymap("n", "<Leader>k", ":horizontal resize +5<CR>", { noremap = true, silent = true }) -- Increase height of horizontal split
vim.api.nvim_set_keymap("n", "<Leader>j", ":horizontal resize -5<CR>", { noremap = true, silent = true }) -- Decrease height of horizontal split
vim.api.nvim_set_keymap("v", "y", "y`]", { noremap = true, silent = true }) -- Jump to the end of the copied text in visual mode
vim.api.nvim_set_keymap("v", "p", "p`]", { noremap = true, silent = true }) -- Jump to the end of the pasted text in visual mode
vim.api.nvim_set_keymap("n", "p", "p`]", { noremap = true, silent = true }) -- Jump to the end of the pasted text in normal mode
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true }) -- Move down by visual line
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true }) -- Move up by visual line
vim.api.nvim_set_keymap("n", ",cs", [[:let @*=expand("%")<CR>]], { noremap = true, silent = true }) -- Copy relative path for non-Windows
vim.api.nvim_set_keymap("n", ",cl", [[:let @*=expand("%:p")<CR>]], { noremap = true, silent = true }) -- Copy full path for non-Windows

-- Delete mapping that appears to be created asynchronously after the init is loaded
local autocmd_id
autocmnd_id = vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    if vim.fn.mapcheck("<M-k>", "v") ~= "" then
      pcall(vim.keymap.del, { "i", "n", "v" }, "<M-k>")
      pcall(vim.keymap.del, { "i", "n", "v" }, "<M-j>")
    else
      if autocmd_id then
        vim.api.nvim_del_autocmd(autocmd_id)
      end
    end
  end,
})
