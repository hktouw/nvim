# Notes

https://lazyvim-ambitious-devs.phillips.codes/course/chapter-5/#_lazy_extras

## Shell tools

```
BurntSushi/ripgrep
rg

sharkdp/fd
fd

jesseduffield/lazygit
```

## Editing

<leader>cs SymbolOutline # bring out AST
<C-w>R # swap panes

```
https://github.com/tpope/vim-abolish
crc - camel case
cr_ - snake case
cru - uppercase
cr- - dash case
cr. - dot case
cr<space> - space
crt - title case


vim-visual-multi
https://github.com/mg979/vim-visual-multi/wiki/Mappings

visual mode
  \\c toggle to colume of cursors in visual mode
  highlight blocks + \\a to create region
  \\/ regex of anything in region
normal mode
  ctrl-j add cursor down
  ctrl-k add cursor up
  \\A select all occurrences of word
  \\/ regex search for occurances
  <C-n> find word or subword under cursor
cursor mode
  (text can be tags or ", [, {, etc)
  cs' change surrounding text
  ds' delete surrounding text
  yss' surround whole line with text
  visual mode + S + text to surround text
  si"y copy text in character
tab toggles between cursor and extend mode
extend mode:
  S + character to surround
  \\C case conversion menu
  \\t cycles selections
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_maps["Add Cursor Up"]   = '<C-k>'




VS Code
https://github.com/VSCodeVim/Vim#input-method

CTRL+b toggle side bar
CMD+P file search
CMD+J close terminal
CMD+Shift+P search vscode settings
CMD+SHIFT+F search files
CMD+D multicursor
CTRL+o / CTRL+i move cursor back and forth
CMD+T search all symbols / functions
CMD+Shift+e open file tree
CMD+Shift+enter open copilot
CMD+Shift+[ cycle through terminal windows
CMD+Enter open copilot autocomplete



Gmail
o - open email
u - back to inbox
j / k - navigate
shift i - mark as read
shift u - mark as unread
n - navigate up in thread
p - navigate down in thread
; - open all thread
space - move down thread
shift space - move up thread
* -> n - unselect all conversations


treesitter
vib - highlight inside of block
vif - highlight inside of method
vii - highlight inside of an indent


tablemode
:TableModeToggle
| name | addres
||
| hellow | 



https://github.com/AndrewRadev/splitjoin.vim
gS - split block
gJ - join block


https://github.com/junegunn/gv.vim

:GV - show commit history
:GV! - show commit history containing this file
o - show commit (highlight multiple commits to diff in range)
O - open in new tab
gb - git browse
. - to start command-line with :Git [CURSOR] SHA à la fugitive

Lazyvim
\\ - live grep
<leader>ca - show code actions
ge - show errors under cursor
<leader>xx - show all diagnostics
s - search without moving
:messages - read vim output
:checkhealth - read health of lazyvim
<leader>l - read health of lazyvim
:LazyExtra - read health of extras
:Mason - read health of lsps

https://github.com/lewis6991/gitsigns.nvim
<leader>hp - preview hunk
<leader>hs - toggle stage hunk
<leader>hd - diff
<leader>td - toggle deleted diff
<leader>hb - show blame on line



grugfar
<leader>sr - grug far search and replace
```

## 12/24/2024 practice


```
yss" - surround line with "
cs' change surrounding text
ds' delete surrounding text
gS / gJ - split join
GV! - commit history (O to open in new tab)
vib / vif / vii - block selection
<leader>cs SymbolOutline # bring out AST
<C-w>R # swap panes
<leader>sna - show all errors
<leader>cl - show lsp errors
\\ - live grep
<leader>ca - show code actions
ge - show errors under cursor
<leader>xx - show all diagnostics
s - search without moving
:messages - read vim output
:checkhealth - read health of lazyvim
<leader>l - read health of lazyvim
:LazyExtra - read health of extras
:Mason - read health of lsps
<leader>hp - preview hunk
<leader>hs - toggle stage hunk
<leader>hd - diff
<leader>td - toggle deleted diff
<leader>hb - show blame on line
<leader>sr - grug far search and replace
```










