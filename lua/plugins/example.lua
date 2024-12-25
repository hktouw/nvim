
if true then return { } end



-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "graphql",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
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
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    -- change some options, from NvChad
    --return {
    opts = function(_, opts)
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          layout_config = {
            width = 0.9, -- Set the width to 90% of the editor width
            height = 0.8, -- Optional: Adjust height as well
          },
        },
      })

      -- opts = vim.tbl_deep_extend("force", opts or {}, {
      --   -- Custom options
      --   defaults = {
      --     vimgrep_arguments = {
      --       "rg",
      --       -- "-L",
      --       "--color=never",
      --       "--no-heading",
      --       "--with-filename",
      --       "--line-number",
      --       "--column",
      --       "--smart-case",
      --     },
      --     prompt_prefix = "   ",
      --     selection_caret = "  ",
      --     entry_prefix = "  ",
      --     initial_mode = "insert",
      --     selection_strategy = "reset",
      --     sorting_strategy = "ascending",
      --     -- layout_strategy = "horizontal",
      --     layout_config = {
      --       horizontal = {
      --         prompt_position = "top",
      --         preview_width = 0.60,
      --         results_width = 0.90,
      --       },
      --       vertical = {
      --         mirror = false,
      --       },
      --       width = 0.99,
      --       height = 0.80,
      --       preview_cutoff = 120,
      --     },
      --     -- file_sorter = require("telescope.sorters").get_fuzzy_file,
      --     file_ignore_patterns = { "node_modules" },
      --     pickers = {
      --       find_files = {
      --         find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
      --       },
      --     },
      --     -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      --     -- file_sorter = require("telescope").extensions.fzf.get_fuzzy_file, -- Use FZF sorter for files
      --     -- generic_sorter = require("telescope").extensions.fzf.get_generic_fuzzy_sorter,
      --     file_sorter = require("telescope").extensions.fzf.file_sorter,
      --     generic_sorter = require("telescope").extensions.fzf.generic_sorter,
      --     path_display = { "truncate" },
      --     winblend = 0,
      --     border = {},
      --     borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --     color_devicons = true,
      --     set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      --     file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      --     grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      --     qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      --     -- Developer configurations: Not meant for general override
      --     buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      --     mappings = {
      --       n = {
      --         ["q"] = require("telescope.actions").close,
      --         ["<C-t>"] = require("telescope.actions").select_tab, -- Open file in new tab
      --       },
      --       i = {
      --         ["<C-t>"] = require("telescope.actions").select_tab, -- Open file in new tab
      --       },
      --     },
      --   },
      --   dependencies = {
      --     { 'nvim-lua/plenary.nvim' },
      --     {
      --       "nvim-telescope/telescope-fzf-native.nvim",
      --       build = "make",
      --       config = function()
      --         require("telescope").load_extension("fzf")
      --       end,
      --     }
      --   },
      --   extensions_list = { "themes", "terms" },
      --   extensions = {
      --     fzf = {
      --       fuzzy = true,                    -- false will only do exact matching
      --       override_generic_sorter = true,  -- override the generic sorter
      --       override_file_sorter = true,     -- override the file sorter
      --       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      --       -- the default case_mode is "smart_case"
      --     }
      --   }
      -- })
      --
      -- require("telescope").load_extension("fzf")

      return opts
    end,
  }
}
