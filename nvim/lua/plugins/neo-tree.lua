return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        mappings = {
          -- Your existing keymaps if any
        },
      },
      -- Set highlights for transparency
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', fg = '#d6c3a5' })
            vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', fg = '#d6c3a5' })
            vim.opt_local.fillchars:append { eob = " " }  -- Hide end-of-buffer tildes
          end,
        },
      },
    })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
  end,
}
