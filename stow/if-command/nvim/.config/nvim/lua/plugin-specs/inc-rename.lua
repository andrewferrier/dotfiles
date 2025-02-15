-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "smjonas/inc-rename.nvim",
    opts = { cmd_name = "LspRename" },
    event = "LspAttach",
}
