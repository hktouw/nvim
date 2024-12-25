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
    { import = "plugins" },
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



-- Thoughtbot

-- Disable Vi compatibility mode to enable more features
vim.o.compatible = false

-- Fix encoding issues
vim.scriptencoding = "utf-8"
vim.o.encoding = "utf-8"

-- Set the leader key to space
vim.g.mapleader = " "

-- General settings
vim.o.backspace = "2"            -- Allow backspace to delete indents, EOLs, etc.
vim.o.backup = false             -- Disable backup file creation
vim.o.writebackup = false        -- Disable write backup creation
vim.o.swapfile = false           -- Disable swap file creation
vim.o.history = 50               -- Number of commands to remember in history
vim.o.showcmd = true             -- Display incomplete commands
vim.o.incsearch = true           -- Incrementally highlight search matches
vim.o.laststatus = 2             -- Always show the status line
vim.o.autowrite = true           -- Automatically save before running commands

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


-- Indentation settings
vim.o.tabstop = 2                -- Number of spaces per tab
vim.o.shiftwidth = 2             -- Spaces to use for auto-indent
vim.o.shiftround = true          -- Round indentation to multiples of shiftwidth
vim.o.expandtab = true           -- Use spaces instead of tabs

-- Display extra whitespace characters
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·,nbsp:·"

-- Colors and highlighting
vim.o.background = "dark"        -- Use dark background

-- Line numbers
vim.o.number = true              -- Enable line numbers
vim.o.numberwidth = 5            -- Set line number column width

-- Personal vimrc.local
vim.g.NumberToggleTrigger = "<Leader>b" -- Bind <Leader>b to NumberToggleTrigger
-- Preserve no end-of-line (EOL) behavior for specific use cases
vim.g.PreserveNoEOL = 1
-- General editor settings
vim.opt.textwidth = 0 -- Disable automatic line wrapping
vim.opt.shiftwidth = 2 -- Set indentation width to 2 spaces
vim.opt.cursorline = false
