local M = {}

---@param out vim.SystemCompleted
M.system_on_exit = function(out)
    vim.schedule(function()
        if out.code ~= 0 then
            vim.notify(out.stderr, vim.log.levels.ERROR)
        end
    end)
end

---@return string
M.get_filename_homedir = function()
    local curfile = vim.fn.expand("%")
    ---@cast curfile string
    return vim.fn.substitute(curfile, "^" .. vim.env.HOME, "~", "")
end

---@return string
M.get_filename_homedir_shortened = function()
    return vim.fn.pathshorten(M.get_filename_homedir())
end

---@return string
M.get_neovim_symbol = function()
    if vim.uv.os_uname().sysname == "Darwin" then
        return "nvim"
    else
        return ""
    end
end

---@param buf integer?
M.buf_set_q_key_to_quit = function(buf)
    if buf == nil then
        buf = 0
    end

    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        ":q<CR>",
        { noremap = true, silent = true }
    )
end

---@param lines string[]
M.show_in_split_window = function(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, { split = "below" })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = "lua"
    vim.bo[buf].bufhidden = "delete"

    M.buf_set_q_key_to_quit()
end

return M
