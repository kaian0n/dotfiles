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
-- Clear and override linked TS groups to break blue/pink/purple inheritance
vim.cmd('hi clear TSConstructor')
vim.api.nvim_set_hl(0, "TSConstructor", { fg = "#C7522A", bg = "NONE" }) -- Red-orange for constructors/brackets
vim.cmd('hi clear TSKeyword')
vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#E9B489", bg = "NONE" }) -- Sand for keywords like "set"
vim.cmd('hi clear @constructor.lua')
vim.api.nvim_set_hl(0, "@constructor.lua", { fg = "#C7522A", bg = "NONE" }) -- Red-orange for Lua constructors (brackets)
vim.cmd('hi clear @keyword.vim')
vim.api.nvim_set_hl(0, "@keyword.vim", { fg = "#E9B489", bg = "NONE" }) -- Sand for Vim keywords in strings
vim.cmd('hi clear TSString')
vim.cmd('hi clear TSComment')
vim.cmd('hi clear @string')
vim.cmd('hi clear @comment')
vim.cmd('hi clear Special') -- Break potential purple fallback link
vim.cmd('hi clear TSType') -- Clear for types like int in C
vim.cmd('hi clear TSFunction') -- Clear for functions like main in C
vim.cmd('hi clear TSInclude') -- Clear for #include in C
vim.cmd('hi clear TSPreProc') -- Clear for preproc directives in C
vim.cmd('hi clear TSTypeBuiltin') -- Clear builtin types like int in C
vim.cmd('hi clear TSRepeat') -- Clear for loops like for/while
vim.cmd('hi clear Repeat') -- Clear legacy Repeat group
vim.cmd('hi clear @string.special.path.c') -- Clear for paths like stdio.h in C
vim.cmd('hi clear TSStringSpecial') -- Clear special strings
vim.cmd('hi clear @attribute.html') -- Clear for HTML attributes like charset, rel
vim.cmd('hi clear @property.html') -- Clear for HTML properties like href
vim.cmd('hi clear @string.special.url.html') -- Clear for URLs in href
vim.cmd('hi clear TSTagAttribute') -- Clear core TS for tag attributes
-- Transparency: Use NONE for full Ghostty inheritance (max transparency)
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#E9B489", bg = "NONE" }) -- Sand line numbers
-- Generic syntax overrides (strings/fields to sand for readability; comments to red-orange)
vim.api.nvim_set_hl(0, "Comment", { fg = "#C7522A", bg = "NONE" }) -- Red-orange comments
vim.api.nvim_set_hl(0, "TSComment", { fg = "#C7522A", bg = "NONE" }) -- Core TS comments
vim.api.nvim_set_hl(0, "@comment.lua", { fg = "#C7522A", bg = "NONE" }) -- Scoped Lua comments
vim.api.nvim_set_hl(0, "@comment", { fg = "#C7522A", bg = "NONE" }) -- Generic comments
vim.api.nvim_set_hl(0, "String", { fg = "#E9B489", bg = "NONE" }) -- Sand strings (fixes purple fields like TSConstructor)
vim.api.nvim_set_hl(0, "TSString", { fg = "#E9B489", bg = "NONE" }) -- Core TS strings
vim.api.nvim_set_hl(0, "@string.lua", { fg = "#E9B489", bg = "NONE" }) -- Scoped strings
vim.api.nvim_set_hl(0, "@string", { fg = "#E9B489", bg = "NONE" }) -- Generic strings
vim.api.nvim_set_hl(0, "Function", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "Constant", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "Number", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "Operator", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "Type", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "Conditional", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = "#C7522A", bg = "NONE" }) -- Legacy fallback for punctuation
vim.api.nvim_set_hl(0, "Punctuation", { fg = "#C7522A", bg = "NONE" }) -- Broad punctuation override
vim.api.nvim_set_hl(0, "@punctuation", { fg = "#C7522A", bg = "NONE" }) -- Generic punctuation
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#C7522A", bg = "NONE" }) -- Generic brackets
vim.api.nvim_set_hl(0, "TSRepeat", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for loops like for/while (higher contrast than sand for readability)
vim.api.nvim_set_hl(0, "Repeat", { fg = "#FDF0D5", bg = "NONE" }) -- Legacy Repeat
-- Expanded Lua-specific Treesitter overrides
vim.api.nvim_set_hl(0, "@function.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@function.call.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@function.builtin.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@method.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@variable.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@variable.member.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@parameter.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@field.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@property.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@string.escape.lua", { fg = "#E9B489", bg = "NONE" }) -- Sand string escapes
vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@keyword.operator.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@keyword.return.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@keyword.function.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@operator.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@punctuation.bracket.lua", { fg = "#C7522A", bg = "NONE" }) -- Red-orange brackets
vim.api.nvim_set_hl(0, "@punctuation.special.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@constant.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@namespace.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.type.variable.lua", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.type.function.lua", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.type.string.lua", { fg = "#E9B489", bg = "NONE" }) -- Sand LSP strings
vim.api.nvim_set_hl(0, "@lsp.type.punctuation.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.typemod.punctuation.bracket.lua", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "@repeat.lua", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for Lua loops like for
-- C-specific overrides to kill purple on int, main, #include, for
vim.api.nvim_set_hl(0, "@type.c", { fg = "#E9B489", bg = "NONE" }) -- Sand types like int
vim.api.nvim_set_hl(0, "@function.c", { fg = "#E9B489", bg = "NONE" }) -- Sand functions like main
vim.api.nvim_set_hl(0, "@keyword.directive.c", { fg = "#C7522A", bg = "NONE" }) -- Red-orange directives like #include
vim.api.nvim_set_hl(0, "@include.c", { fg = "#C7522A", bg = "NONE" }) -- Red-orange #include
vim.api.nvim_set_hl(0, "@keyword.c", { fg = "#E9B489", bg = "NONE" }) -- Sand keywords in C
vim.api.nvim_set_hl(0, "TSInclude", { fg = "#C7522A", bg = "NONE" }) -- Core TS for #include
vim.api.nvim_set_hl(0, "TSPreProc", { fg = "#C7522A", bg = "NONE" }) -- Core TS preproc
vim.api.nvim_set_hl(0, "TSTypeBuiltin", { fg = "#E9B489", bg = "NONE" }) -- Sand builtin types like int
vim.api.nvim_set_hl(0, "@repeat.c", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for C loops like for
vim.api.nvim_set_hl(0, "@string.special.path.c", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for paths like stdio.h (higher contrast for dots)
vim.api.nvim_set_hl(0, "TSStringSpecial", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white special strings
-- HTML-specific overrides to kill blue on charset, rel, href
vim.api.nvim_set_hl(0, "@attribute.html", { fg = "#E9B489", bg = "NONE" }) -- Sand for attributes like charset, rel
vim.api.nvim_set_hl(0, "@property.html", { fg = "#E9B489", bg = "NONE" }) -- Sand for properties like href
vim.api.nvim_set_hl(0, "@string.special.url.html", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for URLs in href
-- Nix-specific overrides for better punctuation visibility
vim.cmd('hi clear @punctuation.delimiter.nix')
vim.api.nvim_set_hl(0, "@punctuation.delimiter.nix", { fg = "#FDF0D5", bg = "NONE" }) -- Off-white for periods and semicolons
vim.cmd('hi clear @punctuation.special.nix')
vim.api.nvim_set_hl(0, "@punctuation.special.nix", { fg = "#FDF0D5", bg = "NONE" })
vim.cmd('hi clear @punctuation.nix')
vim.api.nvim_set_hl(0, "@punctuation.nix", { fg = "#FDF0D5", bg = "NONE" })
vim.cmd('hi clear @operator.nix')
vim.api.nvim_set_hl(0, "@operator.nix", { fg = "#FDF0D5", bg = "NONE" })
-- Rainbow overrides for discernible brackets/paren (cycle palette for nesting levels)
vim.api.nvim_set_hl(0, "RainbowDelimiter1", { fg = "#C7522A" }) -- Red-orange level 1
vim.api.nvim_set_hl(0, "RainbowDelimiter2", { fg = "#E9B489" }) -- Sand level 2
vim.api.nvim_set_hl(0, "RainbowDelimiter3", { fg = "#FDF0D5" }) -- Off-white level 3
vim.api.nvim_set_hl(0, "RainbowDelimiter4", { fg = "#C7522A" }) -- Cycle back
-- Neo-tree overrides
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#FDF0D5", bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#C7522A", bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#E9B489", bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#C7522A", bg = "NONE" })
-- UI prompt overrides (fixes "Press ENTER" purple/blue)
vim.api.nvim_set_hl(0, "MoreMsg", { fg = "#FDF0D5", bold = true }) -- Off-white for messages
vim.api.nvim_set_hl(0, "Question", { fg = "#FDF0D5", bold = true }) -- Off-white for questions/prompts
vim.api.nvim_set_hl(0, "MsgArea", { fg = "#FDF0D5", bg = "NONE" }) -- Message area
-- Other overrides
vim.api.nvim_set_hl(0, "MatchParen", { bg = "NONE", underline = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#242322" })
vim.api.nvim_set_hl(0, "Search", { bg = "#C7522A", fg = "#FDF0D5" })
end
-- Reapply on BufEnter, LspAttach, ColorScheme, and Syntax to win priority races
vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach", "ColorScheme", "Syntax" }, {
pattern = {".lua", ".c", ".h", ".html", "*.nix"},
callback = apply_overrides,
})
-- Initial apply
apply_overrides()
end,
}
