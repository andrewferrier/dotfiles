local EXCLUDED_DIRS = { vim.env.HOME, "/private/tmp", "/private/var", "/tmp" }

local function is_excluded(bufname, dirs)
    for _, val in pairs(dirs) do
        if string.sub(bufname, 1, string.len(val)) == val then
            return true
        end
    end

    return false
end

vim.keymap.set("n", "cvr", function()
    require("readonly").make_readonly()
    vim.notify("Effective R/O on.")
end, { desc = "Turn on effective r/o" })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "Make files readonly when outside of home directory",
    pattern = "*",
    group = vim.api.nvim_create_augroup("BufReadPost_readonly.lua", {}),
    callback = function()
        if not is_excluded(vim.api.nvim_buf_get_name(0), EXCLUDED_DIRS) then
            require("readonly").make_readonly()
        end
    end,
})
