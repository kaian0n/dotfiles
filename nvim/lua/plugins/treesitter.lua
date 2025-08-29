return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,  -- Disable legacy regex highlights
        disable = function(lang, buf)
          -- Optionally disable for large files if perf issues, but key: block LSP semantics
          return false
        end,
      },
      indent = { enable = true },
    })
    -- Disable LSP semantic tokens globally (or per-buffer via autocmd LspAttach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil  -- Nullify LSP semantics to prevent overrides
      end,
    })
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
  end
}
