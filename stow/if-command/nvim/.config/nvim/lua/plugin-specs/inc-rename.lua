-- selene: allow(mixed_table)
return {
    "smjonas/inc-rename.nvim",
    opts = { cmd_name = "LspRename" },
    event = "LspAttach",
}
