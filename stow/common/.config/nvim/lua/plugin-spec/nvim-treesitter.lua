local function install_treesitter_parsers()
    -- Neither of these are sync, but that shouldn't matter as there is no
    -- intersection in the parsers they will touch
    vim.cmd.TSUpdate()
    -- In practice TSInstall may not install new parsers until after NeoVim is
    -- restarted. I don't consider that a major problem, just means we might lag
    -- behind a bit.
    vim.cmd.TSInstall("all")
end

local function lsp_supports_rename(bufnr)
    for _, client in pairs(vim.lsp.buf_get_clients(bufnr)) do
        if client.server_capabilities.renameProvider then
            return true
        end
    end

    return false
end

local function on_attach()
    local TREESITTER_RENAME_INEFFECTIVE = { "latex" }

    if
        not lsp_supports_rename(0)
        and not vim.tbl_contains(
            TREESITTER_RENAME_INEFFECTIVE,
            vim.opt.filetype
        )
    then
        vim.keymap.set("n", "cxr", function()
            require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
        end, {
            buffer = true,
            desc = "Rename identifier using Treesitter rename",
        })
    end
end

local configure = function()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            disable = function()
                return require("utils").is_large_file()
            end,
        },
        refactor = { smart_rename = { enable = true } },
        indent = { enable = true },
        endwise = { enable = true },
    })

    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        desc = "Treesitter on_attach simulation",
        pattern = "*",
        group = vim.api.nvim_create_augroup("BufReadPost_treesitter.lua", {}),
        callback = function()
            if require("nvim-treesitter.parsers").has_parser() then
                on_attach()
            end
        end,
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = install_treesitter_parsers,
    config = configure,
    -- Re-enable once on NeoVim 0.10
    -- version = "*",
}