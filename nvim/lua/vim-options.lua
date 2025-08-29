-- Basic indentation
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Leader
vim.g.mapleader = " "

-- Background (dark for Red Sands maroon base)
vim.opt.background = 'dark'

-- No swapfile
vim.opt.swapfile = false

-- Window navigation with redraw
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>:redrawstatus!<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>:redrawstatus!<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>:redrawstatus!<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>:redrawstatus!<CR>')
vim.keymap.set('n', '$', '$l', { noremap = true })
-- Misc
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
vim.opt.termguicolors = true

-- Clipboard sync
vim.opt.clipboard = "unnamedplus"

-- Mac-specific keymaps for copy/paste/select
-- Command+A: Select all in current buffer (buffer-specific)
vim.keymap.set('n', '<D-a>', 'ggVG', { desc = 'Select all text in current buffer' })

-- Command+C: Copy selection to system clipboard
vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy selection to system clipboard' })

-- Command+V: Paste from system clipboard
vim.keymap.set('n', '<D-v>', '"+p', { desc = 'Paste from system clipboard after cursor' })
vim.keymap.set('v', '<D-v>', '"+p', { desc = 'Paste from system clipboard over selection' })
vim.keymap.set('i', '<D-v>', '<C-o>"+p', { desc = 'Paste from system clipboard in insert' })

-- Autocmd to exit visual mode on window leave (prevents selection in inactive panes)
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function()
    if vim.fn.mode() == "v" then
      vim.cmd("normal! \\<Esc>")
    end
  end,
})

-- Global highlight for inactive windows transparency
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })

vim.opt.fillchars:append { eob = " " }

vim.opt.virtualedit:append('onemore')
