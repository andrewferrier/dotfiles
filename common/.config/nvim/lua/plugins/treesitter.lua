-- luacheck: globals vim

-- Renaming can be done with LSP, but we are doing it with treesitter instead
-- because it seems to be more reliable and supported by more filetypes.

local function treesitter_on_attach(_, _)
    vim.cmd("omap <buffer> <silent> m :<C-U>lua require('tsht').nodes()<CR>")
    vim.cmd("vnoremap <buffer> <silent> m :lua require('tsht').nodes()<CR>")
end

local function disable_function(filetype, bufnr)
    if vim.b.treesitter_enabled == nil then
        local enable = not require("large_file").is_large_file(bufnr)
        vim.b.treesitter_enabled = enable

        if enable then
            treesitter_on_attach(filetype, bufnr)
        end
    end

    return not vim.b.treesitter_enabled
end

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = disable_function,
    },
    refactor = {
        smart_rename = {
            enable = true,
            disable = disable_function,
            keymaps = { smart_rename = "cxr" },
        },
    },
    indent = { enable = true, disable = disable_function },
    endwise = { enable = true, disable = disable_function },
    matchup = { enable = true, disable = disable_function },
    textobjects = {
        select = {
            enable = true,
            disable = disable_function,
            lookahead = true,
            keymaps = {
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
            },
        },
    },
})
