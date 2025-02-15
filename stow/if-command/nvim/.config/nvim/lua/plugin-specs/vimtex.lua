-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "lervag/vimtex",
    init = function()
        vim.g.vimtex_syntax_conceal_disable = 1
        vim.g.vimtex_syntax_enabled = 0
        vim.g.vimtex_toc_config = { show_help = 0 }
        vim.g.vimtex_view_automatic = 0
    end,
    ft = { "latex", "plaintex", "tex" },
    version = "*",
}
