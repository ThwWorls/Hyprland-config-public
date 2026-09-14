vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "grayscale"
vim.opt.background = "dark"

local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local c = {
    bg       = "#0a0a0a",
    bg_alt   = "#111111",
    surface  = "#1a1a1a",
    line     = "#1e1e1e",
    border   = "#333333",
    comment  = "#555555",
    dim      = "#777777",
    muted    = "#999999",
    text     = "#c0c0c0",
    fg       = "#e0e0e0",
    bright   = "#f0f0f0",
    white    = "#ffffff",
}

-- Editor
hi("Normal",       { fg = c.fg, bg = c.bg })
hi("NormalFloat",  { fg = c.fg, bg = c.bg_alt })
hi("FloatBorder",  { fg = c.border, bg = c.bg_alt })
hi("Cursor",       { fg = c.bg, bg = c.fg })
hi("CursorLine",   { bg = c.surface })
hi("CursorLineNr", { fg = c.bright, bg = c.surface, bold = true })
hi("LineNr",       { fg = c.border })
hi("SignColumn",   { bg = c.bg })
hi("ColorColumn",  { bg = c.surface })
hi("VertSplit",    { fg = c.border })
hi("WinSeparator", { fg = c.border })
hi("StatusLine",   { fg = c.fg, bg = c.surface })
hi("StatusLineNC", { fg = c.comment, bg = c.bg_alt })
hi("TabLine",      { fg = c.dim, bg = c.bg_alt })
hi("TabLineFill",  { bg = c.bg })
hi("TabLineSel",   { fg = c.white, bg = c.surface, bold = true })
hi("Folded",       { fg = c.comment, bg = c.bg_alt })
hi("FoldColumn",   { fg = c.border, bg = c.bg })
hi("NonText",      { fg = c.border })
hi("SpecialKey",   { fg = c.border })
hi("EndOfBuffer",  { fg = c.bg })

-- Search
hi("Search",       { fg = c.bg, bg = c.muted })
hi("IncSearch",    { fg = c.bg, bg = c.white })
hi("CurSearch",    { fg = c.bg, bg = c.white, bold = true })

-- Selection
hi("Visual",       { bg = "#2a2a2a" })
hi("VisualNOS",    { bg = "#2a2a2a" })

-- Popup
hi("Pmenu",        { fg = c.fg, bg = c.bg_alt })
hi("PmenuSel",     { fg = c.white, bg = c.surface, bold = true })
hi("PmenuSbar",    { bg = c.surface })
hi("PmenuThumb",   { bg = c.border })

-- Messages
hi("ErrorMsg",     { fg = c.white, bold = true })
hi("WarningMsg",   { fg = c.muted, bold = true })
hi("MoreMsg",      { fg = c.dim })
hi("Question",     { fg = c.fg })
hi("Title",        { fg = c.white, bold = true })
hi("Directory",    { fg = c.bright })
hi("ModeMsg",      { fg = c.fg, bold = true })

-- Diff
hi("DiffAdd",      { bg = "#1a1f1a" })
hi("DiffChange",   { bg = "#1a1a1f" })
hi("DiffDelete",   { fg = c.border, bg = "#1f1a1a" })
hi("DiffText",     { bg = "#2a2a35" })

-- Diagnostics
hi("DiagnosticError",      { fg = c.bright })
hi("DiagnosticWarn",       { fg = c.muted })
hi("DiagnosticInfo",       { fg = c.dim })
hi("DiagnosticHint",       { fg = c.comment })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.bright })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.muted })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.dim })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.comment })

-- Syntax (matching target screenshot: keywords bright, strings dimmer, comments gray)
hi("Comment",      { fg = c.comment, italic = true })
hi("Constant",     { fg = c.bright })
hi("String",       { fg = c.muted })
hi("Character",    { fg = c.muted })
hi("Number",       { fg = c.text })
hi("Boolean",      { fg = c.bright })
hi("Float",        { fg = c.text })

hi("Identifier",   { fg = c.fg })
hi("Function",     { fg = c.white })

hi("Statement",    { fg = c.white, bold = true })
hi("Conditional",  { fg = c.white, bold = true })
hi("Repeat",       { fg = c.white, bold = true })
hi("Label",        { fg = c.bright })
hi("Operator",     { fg = c.fg })
hi("Keyword",      { fg = c.white, bold = true })
hi("Exception",    { fg = c.white, bold = true })

hi("PreProc",      { fg = c.bright })
hi("Include",      { fg = c.bright })
hi("Define",       { fg = c.bright })
hi("Macro",        { fg = c.bright })
hi("PreCondit",    { fg = c.bright })

hi("Type",         { fg = c.bright })
hi("StorageClass", { fg = c.white })
hi("Structure",    { fg = c.white })
hi("Typedef",      { fg = c.bright })

hi("Special",      { fg = c.text })
hi("SpecialChar",  { fg = c.text })
hi("Tag",          { fg = c.bright })
hi("Delimiter",    { fg = c.dim })
hi("Debug",        { fg = c.muted })

hi("Underlined",   { fg = c.fg, underline = true })
hi("Error",        { fg = c.white, bg = c.surface, bold = true })
hi("Todo",         { fg = c.white, bg = c.bg_alt, bold = true })

-- Treesitter
hi("@variable",              { fg = c.fg })
hi("@variable.builtin",      { fg = c.text })
hi("@variable.parameter",    { fg = c.text })
hi("@constant",              { fg = c.bright })
hi("@constant.builtin",      { fg = c.bright })
hi("@module",                { fg = c.text })
hi("@string",                { fg = c.muted })
hi("@string.escape",         { fg = c.text })
hi("@string.special",        { fg = c.text })
hi("@character",             { fg = c.muted })
hi("@number",                { fg = c.text })
hi("@boolean",               { fg = c.bright })
hi("@type",                  { fg = c.bright })
hi("@type.builtin",          { fg = c.text })
hi("@type.definition",       { fg = c.bright })
hi("@attribute",             { fg = c.text })
hi("@property",              { fg = c.fg })
hi("@function",              { fg = c.white })
hi("@function.builtin",      { fg = c.bright })
hi("@function.call",         { fg = c.fg })
hi("@function.method",       { fg = c.white })
hi("@function.method.call",  { fg = c.fg })
hi("@constructor",           { fg = c.bright })
hi("@operator",              { fg = c.fg })
hi("@keyword",               { fg = c.white, bold = true })
hi("@keyword.function",      { fg = c.white, bold = true })
hi("@keyword.return",        { fg = c.white, bold = true })
hi("@keyword.operator",      { fg = c.white })
hi("@keyword.import",        { fg = c.bright })
hi("@keyword.conditional",   { fg = c.white, bold = true })
hi("@keyword.repeat",        { fg = c.white, bold = true })
hi("@keyword.exception",     { fg = c.white, bold = true })
hi("@punctuation.bracket",   { fg = c.dim })
hi("@punctuation.delimiter", { fg = c.dim })
hi("@punctuation.special",   { fg = c.text })
hi("@comment",               { fg = c.comment, italic = true })
hi("@tag",                   { fg = c.bright })
hi("@tag.attribute",         { fg = c.text })
hi("@tag.delimiter",         { fg = c.dim })
hi("@markup.heading",        { fg = c.white, bold = true })
hi("@markup.italic",         { italic = true })
hi("@markup.strong",         { bold = true })
hi("@markup.link",           { fg = c.text, underline = true })
hi("@markup.raw",            { fg = c.muted })

-- LSP semantic tokens
hi("@lsp.type.class",         { fg = c.bright })
hi("@lsp.type.decorator",     { fg = c.text })
hi("@lsp.type.enum",          { fg = c.bright })
hi("@lsp.type.enumMember",    { fg = c.text })
hi("@lsp.type.function",      { fg = c.white })
hi("@lsp.type.interface",     { fg = c.bright })
hi("@lsp.type.macro",         { fg = c.bright })
hi("@lsp.type.method",        { fg = c.white })
hi("@lsp.type.namespace",     { fg = c.text })
hi("@lsp.type.parameter",     { fg = c.text })
hi("@lsp.type.property",      { fg = c.fg })
hi("@lsp.type.struct",        { fg = c.bright })
hi("@lsp.type.type",          { fg = c.bright })
hi("@lsp.type.variable",      { fg = c.fg })

-- Git signs
hi("GitSignsAdd",    { fg = c.dim })
hi("GitSignsChange", { fg = c.comment })
hi("GitSignsDelete", { fg = c.muted })

-- Telescope
hi("TelescopeNormal",       { fg = c.fg, bg = c.bg })
hi("TelescopeBorder",       { fg = c.border, bg = c.bg })
hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg_alt })
hi("TelescopePromptBorder", { fg = c.border, bg = c.bg_alt })
hi("TelescopeSelection",    { bg = c.surface })
hi("TelescopeMatching",     { fg = c.white, bold = true })

-- Indent
hi("IndentBlanklineChar",        { fg = c.line })
hi("IblIndent",                  { fg = c.line })
hi("IblScope",                   { fg = c.border })

-- Which-key
hi("WhichKey",          { fg = c.white })
hi("WhichKeyDesc",      { fg = c.fg })
hi("WhichKeyGroup",     { fg = c.muted })
hi("WhichKeySeparator", { fg = c.comment })

-- Lazy
hi("LazyButton",       { fg = c.fg, bg = c.surface })
hi("LazyButtonActive", { fg = c.white, bg = c.border, bold = true })
hi("LazyH1",           { fg = c.white, bold = true })
