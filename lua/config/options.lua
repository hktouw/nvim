-- Options are automatically loaded before lazy.nvim startup
-- Add any additional options here
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
vim.opt.relativenumber = false
vim.opt.wrap = true

vim.diagnostic.config({
  virtual_text = false,
})

vim.g.autoformat = false
vim.g.root_spec = { ".git" }
vim.o.conceallevel = 0
