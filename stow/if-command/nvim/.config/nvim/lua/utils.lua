local M = {}

---@return string
M.visual_selection_range = function()
    -- See https://github.com/neovim/neovim/pull/13896#issuecomment-1621702052
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] =
            string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, "\n")
end

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

---@param method string
---@return boolean
M.lsp_supports_method = function(method)
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.supports_method(method) then
            return true
        end
    end

    return false
end

---@return string
M.get_neovim_symbol = function()
    if vim.uv.os_uname().sysname == "Darwin" then
        return "nvim"
    else
        return ""
    end
end

return M
