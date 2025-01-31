return {
    -- selene: allow(mixed_table)
    "okuuva/auto-save.nvim",
    version = "*",
    event = { "InsertLeave", "TextChanged" },
    opts = {
        condition = function(bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if vim.fs.root(filename, ".git") then
                return true
            else
                return false
            end
        end,
        debounce_delay = 200,
    },
}
