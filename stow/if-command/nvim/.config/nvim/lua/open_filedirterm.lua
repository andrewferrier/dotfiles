local M = {}

---@return string
local select_fileordir = function(fileordir, force_dir, opening_oil)
    local fileordir_t

    if vim.bo.filetype == "oil" and not opening_oil then
        fileordir_t = require("oil").get_current_dir()
            .. "/"
            .. require("oil").get_cursor_entry()["name"]
    elseif vim.bo.buftype == "" then
        fileordir_t = vim.fn.expand(fileordir, true)
    else
        fileordir_t = vim.env.HOME
    end

    ---@cast fileordir_t string

    if vim.fn.isdirectory(fileordir_t) == 1 or not force_dir then
        return fileordir_t
    else
        local dirname = vim.fs.dirname(fileordir_t)
        ---@cast dirname string
        return dirname
    end
end

M.open_terminal = function(command, dir)
    local expanded_dir = select_fileordir(dir, true, false)
    vim.schedule(function()
        vim.cmd.wincmd("n")
        vim.fn.termopen(command, { cwd = expanded_dir })
    end)
end

M.open_file_manager = function(file_or_dir)
    local expanded_ford = select_fileordir(file_or_dir, false, false)
    vim.schedule(function()
        vim.cmd.wincmd("n")
        vim.fn.termopen(
            "lf " .. vim.fn.shellescape(expanded_ford)
        )
    end)
end

M.open_split_oil = function(dir)
    local expanded_dir = select_fileordir(dir, true, true)
    vim.schedule(function()
        vim.cmd.split()
        vim.cmd.Oil(expanded_dir)
    end)
end

return M
