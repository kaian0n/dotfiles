return {
   "tinted-theming/tinted-nvim",
   lazy = false,
   priority = 1000, -- Load early for colorscheme
   config = function()
   -- Ensure truecolor
   vim.opt.termguicolors = true
   vim.opt.syntax = "off" -- Disable legacy Vim syntax to prevent conflicts with Treesitter
   require("tinted-colorscheme").setup("base24-red-sands", { -- Base scheme, overridden below
   supports = {
      tinty = true,
      tinted_shell = false,
      live_reload = false,
   },
   highlights = {
      telescope = true,
      indentblankline = true,
      notify = true,
      ts_rainbow = true, -- Re-enabled for nesting-based bracket/paren discernment
      cmp = true,
      illuminate = true,
      lsp_semantic = true,
      mini_completion = true,
      dapui = true,
   },
   })
   vim.cmd.colorscheme("base24-red-sands") -- Apply base
   -- Function to apply all overrides
   local function apply_overrides()
   -- Clear groups to break unwanted linkages/inheritances
   local clears = {
      "TSConstructor", "TSKeyword", "@constructor.lua", "@keyword.vim",
      "TSString", "TSComment", "@string", "@comment", "Special",
      "TSType", "TSFunction", "TSInclude", "TSPreProc", "TSTypeBuiltin",
      "TSRepeat", "Repeat", "@string.special.path.c", "TSStringSpecial",
      "@attribute.html", "@property.html", "@string.special.url.html", "TSTagAttribute",
      "@punctuation.delimiter.nix", "@punctuation.special.nix", "@punctuation.nix", "@operator.nix",
   }
   for _, group in ipairs(clears) do
      vim.cmd('hi clear ' .. group)
   end
   -- Set highlights (grouped for clarity)
   local highlights = {
      -- Transparency and UI basics
      ["Normal"] = { bg = "NONE", ctermbg = "NONE" },
      ["NormalFloat"] = { bg = "NONE" },
      ["NeoTreeNormal"] = { bg = "NONE" },
      ["NeoTreeNormalNC"] = { bg = "NONE" },
      ["SignColumn"] = { bg = "NONE" },
      ["FoldColumn"] = { bg = "NONE" },
      ["LineNr"] = { fg = "#E9B489", bg = "NONE" },
      -- Generic syntax
      ["Comment"] = { fg = "#C7522A", bg = "NONE" },
      ["TSComment"] = { fg = "#C7522A", bg = "NONE" },
      ["@comment"] = { fg = "#C7522A", bg = "NONE" },
      ["String"] = { fg = "#E9B489", bg = "NONE" },
      ["TSString"] = { fg = "#E9B489", bg = "NONE" },
      ["@string"] = { fg = "#E9B489", bg = "NONE" },
      ["Function"] = { fg = "#E9B489", bg = "NONE" },
      ["Keyword"] = { fg = "#E9B489", bg = "NONE" },
      ["Identifier"] = { fg = "#FDF0D5", bg = "NONE" },
      ["Constant"] = { fg = "#C7522A", bg = "NONE" },
      ["Number"] = { fg = "#C7522A", bg = "NONE" },
      ["Operator"] = { fg = "#C7522A", bg = "NONE" },
      ["Type"] = { fg = "#E9B489", bg = "NONE" },
      ["Conditional"] = { fg = "#E9B489", bg = "NONE" },
      ["Delimiter"] = { fg = "#C7522A", bg = "NONE" },
      ["Punctuation"] = { fg = "#C7522A", bg = "NONE" },
      ["@punctuation"] = { fg = "#C7522A", bg = "NONE" },
      ["@punctuation.bracket"] = { fg = "#C7522A", bg = "NONE" },
      ["TSRepeat"] = { fg = "#FDF0D5", bg = "NONE" },
      ["Repeat"] = { fg = "#FDF0D5", bg = "NONE" },
      -- Lua-specific
      ["@comment.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@string.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["TSConstructor"] = { fg = "#C7522A", bg = "NONE" },
      ["@constructor.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["TSKeyword"] = { fg = "#E9B489", bg = "NONE" },
      ["@keyword.vim"] = { fg = "#E9B489", bg = "NONE" },
      ["@function.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@function.call.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@function.builtin.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@method.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@variable.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@variable.member.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@parameter.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@field.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@property.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@string.escape.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@keyword.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@keyword.operator.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@keyword.return.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@keyword.function.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@operator.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@punctuation.bracket.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@punctuation.special.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@punctuation.delimiter.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@constant.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@namespace.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@lsp.type.variable.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@lsp.type.function.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@lsp.type.string.lua"] = { fg = "#E9B489", bg = "NONE" },
      ["@lsp.type.punctuation.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@lsp.typemod.punctuation.bracket.lua"] = { fg = "#C7522A", bg = "NONE" },
      ["@repeat.lua"] = { fg = "#FDF0D5", bg = "NONE" },
      -- C-specific
      ["@type.c"] = { fg = "#E9B489", bg = "NONE" },
      ["@function.c"] = { fg = "#E9B489", bg = "NONE" },
      ["@keyword.directive.c"] = { fg = "#C7522A", bg = "NONE" },
      ["@include.c"] = { fg = "#C7522A", bg = "NONE" },
      ["@keyword.c"] = { fg = "#E9B489", bg = "NONE" },
      ["TSInclude"] = { fg = "#C7522A", bg = "NONE" },
      ["TSPreProc"] = { fg = "#C7522A", bg = "NONE" },
      ["TSTypeBuiltin"] = { fg = "#E9B489", bg = "NONE" },
      ["@repeat.c"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@string.special.path.c"] = { fg = "#FDF0D5", bg = "NONE" },
      ["TSStringSpecial"] = { fg = "#FDF0D5", bg = "NONE" },
      -- HTML-specific
      ["@attribute.html"] = { fg = "#E9B489", bg = "NONE" },
      ["@property.html"] = { fg = "#E9B489", bg = "NONE" },
      ["@string.special.url.html"] = { fg = "#FDF0D5", bg = "NONE" },
      -- Nix-specific
      ["@punctuation.delimiter.nix"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@punctuation.special.nix"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@punctuation.nix"] = { fg = "#FDF0D5", bg = "NONE" },
      ["@operator.nix"] = { fg = "#FDF0D5", bg = "NONE" },
      -- Rainbow delimiters
      ["RainbowDelimiter1"] = { fg = "#C7522A" },
      ["RainbowDelimiter2"] = { fg = "#E9B489" },
      ["RainbowDelimiter3"] = { fg = "#FDF0D5" },
      ["RainbowDelimiter4"] = { fg = "#C7522A" },
      -- Neo-tree
      ["NeoTreeDirectoryName"] = { fg = "#E9B489", bg = "NONE" },
      ["NeoTreeDirectoryIcon"] = { fg = "#E9B489", bg = "NONE" },
      ["NeoTreeFileName"] = { fg = "#FDF0D5", bg = "NONE" },
      ["NeoTreeGitModified"] = { fg = "#C7522A", bg = "NONE" },
      ["NeoTreeGitAdded"] = { fg = "#E9B489", bg = "NONE" },
      ["NeoTreeGitDeleted"] = { fg = "#C7522A", bg = "NONE" },
      -- UI prompts
      ["MoreMsg"] = { fg = "#FDF0D5", bold = true },
      ["Question"] = { fg = "#FDF0D5", bold = true },
      ["MsgArea"] = { fg = "#FDF0D5", bg = "NONE" },
      -- Other
      ["MatchParen"] = { bg = "NONE", underline = true },
      ["Visual"] = { bg = "#242322" },
      ["Search"] = { bg = "#C7522A", fg = "#FDF0D5" },
   }
   for group, val in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, val)
   end
   end
   -- Reapply on BufEnter, LspAttach, ColorScheme, and Syntax to win priority races
   vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach", "ColorScheme", "Syntax" }, {
   pattern = {"*.lua", "*.c", "*.h", "*.html", "*.nix"},
   callback = apply_overrides,
   })
   -- Initial apply
   apply_overrides()
   end,
}
