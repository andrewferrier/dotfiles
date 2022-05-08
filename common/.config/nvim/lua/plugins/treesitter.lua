-- luacheck: globals vim

-- Renaming can be done with LSP, but we are doing it with treesitter instead
-- because it seems to be more reliable and supported by more filetypes.

local function treesitter_on_attach(_, _)
    vim.cmd("omap <buffer> <silent> m :<C-U>lua require('tsht').nodes()<CR>")
    vim.cmd("vnoremap <buffer> <silent> m :lua require('tsht').nodes()<CR>")
end

local function disable_other(filetype, bufnr)
    if vim.b.treesitter_enabled == nil then
        local enable = not require("large_file").is_large_file(bufnr)
        vim.b.treesitter_enabled = enable

        if enable then
            treesitter_on_attach(filetype, bufnr)
        end
    end

    return not vim.b.treesitter_enabled
end

local function disable_indent(filetype, bufnr)
    if filetype == 'python' then
        -- See https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
        return true
    else
        return disable_other(filetype, bufnr)
    end
end

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = disable_other,
    },
    refactor = {
        smart_rename = {
            enable = true,
            disable = disable_other,
            keymaps = { smart_rename = "cxr" },
        },
    },
    indent = { enable = true, disable = disable_indent },
    endwise = { enable = true, disable = disable_other },
    matchup = { enable = true, disable = disable_other },
    textobjects = {
        select = {
            enable = true,
            disable = disable_other,
            lookahead = true,
            keymaps = {
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
            },
        },
    },
})
