  return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      pcall(telescope.load_extension, "ui-select")

      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope: find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: live grep" })
    end,
  },
}
