return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.nixfmt,
      null_ls.builtins.diagnostics.rubocop,
      null_ls.builtins.formatting.rubocop,
    }

    if vim.fn.executable("erb_lint") == 1 then
      table.insert(sources, null_ls.builtins.diagnostics.erb_lint)
    end

    null_ls.setup({
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", function()
      local null_ls_clients = vim.lsp.get_clients({
        bufnr = 0,
        name = "null-ls",
      })

      vim.lsp.buf.format({
        filter = function(client)
          return #null_ls_clients == 0 or client.name == "null-ls"
        end,
      })
    end, { desc = "LSP: format buffer" })
  end,
}

