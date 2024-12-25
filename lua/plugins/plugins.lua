-- stylua: ignore
if true then return {
  { "folke/flash.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { "Saghen/blink.cmp", enabled = false },
  { "Saghen/blink.cmp", enabled = false },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-git" },
  { "junegunn/gv.vim" },
  -- Automatically add `end` to blocks
  { "tpope/vim-endwise" },
  -- Repeat plugin commands with `.`
  { "tpope/vim-repeat" },
  -- Easily surround text with delimiters
  { "tpope/vim-surround" },
  -- Delimiters
  { "tpope/vim-abolish" },
  -- Multi-cursor editing
  { "mg979/vim-visual-multi", branch = "master" },
  -- Markdown-style table editing
  { "dhruvasagar/vim-table-mode" },
  -- Easily split and join lines
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
    opts = {
      winopts = {
        width = 0.99, -- Set the width (90% of the screen width)
        height = 0.99, -- Optionally, set the height as well
        preview = {
          layout = "vertical", -- Default is "horizontal"
        },
      },
      actions = {
        files = {
          ["default"] = require("fzf-lua.actions").file_edit, -- Open in the current window
          ["ctrl-t"] = require("fzf-lua.actions").file_tabedit, -- Open in a vertical split
          ["ctrl-v"] = require("fzf-lua.actions").file_vsplit, -- Open in a vertical split
          ["ctrl-x"] = require("fzf-lua.actions").file_split,  -- Open in a horizontal split
        },
      },
    },
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

      opts.diagnostics = {
        virtual_text = false,
        underline = false,
        float = { border = "rounded" },
      }
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
} end

