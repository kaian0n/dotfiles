-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Background (dark for Red Sands maroon base)
vim.opt.background = "dark"

-- No swapfile
vim.opt.swapfile = false

-- UI
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.fillchars:append({ eob = " " })
vim.opt.virtualedit:append("onemore")

-- Clipboard sync
vim.opt.clipboard = "unnamedplus"

-- Window navigation with redraw
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR><cmd>redrawstatus!<CR>", { silent = true, desc = "Move to upper window" })
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR><cmd>redrawstatus!<CR>", { silent = true, desc = "Move to lower window" })
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR><cmd>redrawstatus!<CR>", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR><cmd>redrawstatus!<CR>", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "$", "$l", { noremap = true, desc = "Move one column past end of line" })

-- Misc
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Mac-specific keymaps for copy/paste/select
vim.keymap.set("n", "<D-a>", "ggVG", { desc = "Select all text in current buffer" })
vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from system clipboard after cursor" })
vim.keymap.set("v", "<D-v>", '"+p', { desc = "Paste from system clipboard over selection" })
vim.keymap.set("i", "<D-v>", "<C-r>+", { desc = "Paste from system clipboard in insert mode" })

-- Autocmd to exit visual mode on window leave (prevents selection in inactive panes)
vim.api.nvim_create_autocmd("WinLeave", {
  group = vim.api.nvim_create_augroup("ExitVisualOnWinLeave", { clear = true }),
  pattern = "*",
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local is_visual = mode == "v" or mode == "V" or mode == "\22"

    if is_visual then
      local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "n", false)
    end
  end,
})

-- Global highlight for inactive windows transparency
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
