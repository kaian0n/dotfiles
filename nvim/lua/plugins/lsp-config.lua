local servers = {
  ts_ls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
  solargraph = {},
  html = {
    filetypes = { "html" },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
  nil_ls = {},
}

local function setup_lsp_keymaps(bufnr)
  local function opts(desc)
    return { buffer = bufnr, silent = true, desc = desc }
  end

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP: hover"))
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts("LSP: go to definition"))
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("LSP: references"))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("LSP: code action"))
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end

          setup_lsp_keymaps(args.buf)
        end,
      })

      for server, config in pairs(servers) do
        local server_config = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(server, server_config)
        vim.lsp.enable(server)
      end
    end,
  },
}

