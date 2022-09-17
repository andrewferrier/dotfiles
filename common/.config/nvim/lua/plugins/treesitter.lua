-- Renaming can be done with LSP, but we are doing it with treesitter instead
-- because it seems to be more reliable and supported by more filetypes.

local function on_attach(filetype, bufnr)
    vim.keymap.set(
        "o",
        "m",
        ':<C-U>lua require("tsht").nodes()<CR>',
        { buffer = true, silent = true }
    )

    vim.keymap.set(
        "x",
        "m",
        ':lua require("tsht").nodes()<CR>',
        { buffer = true, silent = true }
    )

    local TREESITTER_RENAME_INEFFECTIVE = { "latex" }

    if
        not require("plugins.lsp.attach").lsp_supports_rename(bufnr)
        and not vim.tbl_contains(TREESITTER_RENAME_INEFFECTIVE, filetype)
    then
        vim.keymap.set("n", "cxr", function()
            require("nvim-treesitter-refactor.smart_rename").smart_rename(bufnr)
        end, {
            buffer = true,
            silent = true,
        })
    end
end

local function disable_other(filetype, bufnr)
    if vim.b.treesitter_enabled == nil then
        local enable = not require("large_file").is_large_file(bufnr)
        vim.b.treesitter_enabled = enable

        if enable then
            on_attach(filetype, bufnr)
        end
    end

    return not vim.b.treesitter_enabled
end

local function disable_indent(filetype, bufnr)
    if filetype == "python" then
        -- See https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
        return true
    else
        return disable_other(filetype, bufnr)
    end
end

local setup_object = {
    -- phpdoc is broken on M1 Mac because of
    -- https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15
    ignore_install = { "phpdoc" },
    highlight = {
        enable = true,
        disable = disable_other,
    },
    refactor = {
        smart_rename = {
            enable = true,
            disable = disable_other,
        },
    },
    indent = { enable = true, disable = disable_indent },
    endwise = { enable = true, disable = disable_other },
}

if vim.fn.has("nvim-0.8.0") == 1 then
    table.insert(setup_object.ignore_install, "c")
    table.insert(setup_object.ignore_install, "lua")
    table.insert(setup_object.ignore_install, "vim")
end

require("nvim-treesitter.configs").setup(setup_object)
