-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")
vim.keymap.set("n", "\\", Util.pick("live_grep"))
vim.keymap.set("n", "<C-p>", "<leader>ff", { desc = "Search Files", remap = true })
vim.keymap.set("n", "ge", "<leader>cd", { desc = "Run diagnostics", remap = true })

-- vim.keymap.set("n", "-", "<leader>fe", { desc = "Explorer NeoTree (cwd)", remap = true })
vim.api.nvim_set_keymap('n', '-', ':Explore<CR>', { noremap = true, silent = true })
vim.keymap.del({ "i", "n", "v" }, "<A-j>")
vim.keymap.del({ "i", "n", "v" }, "<A-k>")
vim.keymap.set("n", "c*", "*Ncgn")

-- Use native tab commands
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

-- Move to the end of what was copied or pasted
vim.api.nvim_set_keymap("v", "y", "y`]", { noremap = true, silent = true }) -- Jump to the end of the copied text in visual mode
vim.api.nvim_set_keymap("v", "p", "p`]", { noremap = true, silent = true }) -- Jump to the end of the pasted text in visual mode
vim.api.nvim_set_keymap("n", "p", "p`]", { noremap = true, silent = true }) -- Jump to the end of the pasted text in normal mode


-- Move vertically by visual lines instead of logical lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true }) -- Move down by visual line
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true }) -- Move up by visual line

-- Convert slashes to backslashes for Windows paths
if vim.fn.has("win32") == 1 then
  vim.api.nvim_set_keymap("n", ",cs", [[:let @*=substitute(expand("%"), "/", "\\", "g")<CR>]], { noremap = true, silent = true }) -- Copy relative path with backslashes
  vim.api.nvim_set_keymap("n", ",cl", [[:let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>]], { noremap = true, silent = true }) -- Copy full path with backslashes
  vim.api.nvim_set_keymap("n", ",c8", [[:let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>]], { noremap = true, silent = true }) -- Copy DOS 8.3 short format path
else
  vim.api.nvim_set_keymap("n", ",cs", [[:let @*=expand("%")<CR>]], { noremap = true, silent = true }) -- Copy relative path for non-Windows
  vim.api.nvim_set_keymap("n", ",cl", [[:let @*=expand("%:p")<CR>]], { noremap = true, silent = true }) -- Copy full path for non-Windows
end
