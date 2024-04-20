local spec = {
    url = "git@github.com:andrewferrier/debugprint.nvim",
    opts = {},
    -- Don't use 'keys'; won't work if visual mode is used first
}

if vim.fn.has("nvim-0.10.0") ~= 1 then
    spec.dependencies = {
        "echasnovski/mini.nvim",
    }
end

return spec
