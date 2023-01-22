local function install_treesitter_parsers()
    -- Neither of these are sync, but that shouldn't matter as there is no
    -- intersection in the parsers they will touch
    vim.cmd.TSUpdate()
    -- In practice TSInstall may not install new parsers until after NeoVim is
    -- restarted. I don't consider that a major problem, just means we might lag
    -- behind a bit.
    vim.cmd.TSInstall("all")
end

local function on_attach()
    local OPTS = { buffer = true, silent = true }

    vim.keymap.set("o", "m", ':<C-U>lua require("tsht").nodes()<CR>', OPTS)
    vim.keymap.set("x", "m", ':lua require("tsht").nodes()<CR>', OPTS)

    local TREESITTER_RENAME_INEFFECTIVE = { "latex" }

    if
        not require("plugin-config.lsp.attach").lsp_supports_rename(0)
        and not vim.tbl_contains(
            TREESITTER_RENAME_INEFFECTIVE,
            vim.opt.filetype
        )
    then
        vim.keymap.set("n", "cxr", function()
            require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
        end, {
            buffer = true,
        })
    end

    if vim.fn.has("nvim-0.9.0") == 1 then
        vim.api.nvim_create_user_command("TSTree", function()
            vim.treesitter.show_tree({ command = "botright 60vnew" })
        end, {})
    end
end

local setup_object = {
    highlight = {
        enable = true,
        disable = function()
            return require("large_file").is_large_file()
        end,
    },
    refactor = { smart_rename = { enable = true } },
    indent = { enable = true, disable = { "python" } }, -- See https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
    endwise = { enable = true },
}

local configure = function()
    require("nvim-treesitter.configs").setup(setup_object)

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
}
