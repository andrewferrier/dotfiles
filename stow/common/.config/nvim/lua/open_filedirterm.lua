local M = {}

local select_fileordir = function(fileordir, force_dir, opening_dirbuf)
    local fileordir_t

    if vim.bo.filetype == "dirbuf" and not opening_dirbuf then
        fileordir_t = require("dirbuf").get_cursor_path()
    elseif vim.bo.buftype == "" then
        fileordir_t = vim.fn.expand(fileordir, 1)
    else
        fileordir_t = vim.env.HOME
    end

    if vim.fn.isdirectory(fileordir_t) == 1 or not force_dir then
        return fileordir_t
    else
        return vim.fs.dirname(fileordir_t)
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
            "ranger --selectfile=" .. vim.fn.shellescape(expanded_ford)
        )
    end)
end

M.open_split_dirbuf = function(dir)
    local expanded_dir = select_fileordir(dir, true, true)
    vim.schedule(function()
        vim.cmd.split()
        vim.cmd.Dirbuf(expanded_dir)
    end)
end

return M