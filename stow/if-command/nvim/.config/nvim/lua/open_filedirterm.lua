local M = {}

---@param fileordir string
---@param force_dir boolean
---@param opening_oil boolean
---@return string
local select_fileordir = function(fileordir, force_dir, opening_oil)
    ---@type string
    local fileordir_t = vim.env.HOME

    if vim.bo.filetype == "oil" and not opening_oil then
        local current_dir = require("oil").get_current_dir()
        local current_file = require("oil").get_cursor_entry()["name"]
        fileordir_t = current_dir .. "/" .. current_file
    elseif vim.bo.buftype == "" then
        fileordir_t = vim.fn.expand(fileordir, true)
    end

    if vim.fn.isdirectory(fileordir_t) == 1 or not force_dir then
        return fileordir_t
    else
        return vim.fs.dirname(fileordir_t)
    end
end

---@class OpenTerminalOpts
---@field cwd string?
---@field external boolean?
---@field term true?

---@param command string
---@param opts OpenTerminalOpts
local open_terminal = function(command, opts)
    if opts.external then
        local cwd = ""

        if opts.cwd then
            cwd = "--working-directory " .. opts.cwd .. " "
        end

        vim.fn.jobstart(
            vim.env.TERMCMD .. " " .. cwd .. command,
            { detach = true }
        )
    else
        vim.cmd.wincmd("n")
        opts.term = true
        vim.fn.jobstart(command, opts)
    end
end

---@param command string
---@param opts OpenTerminalOpts
---@return nil
M.open_terminal = function(command, opts)
    opts.cwd = select_fileordir(opts.cwd, true, false)
    vim.schedule(function()
        open_terminal(command, opts)
    end)
end

---@param file_or_dir string
---@param opts OpenTerminalOpts
---@return nil
M.open_file_manager = function(file_or_dir, opts)
    local expanded_ford = select_fileordir(file_or_dir, false, false)
    vim.schedule(function()
        open_terminal("lf " .. vim.fn.shellescape(expanded_ford), opts)
    end)
end

---@param dir string
---@return nil
M.open_split_oil = function(dir)
    local expanded_dir = select_fileordir(dir, true, true)
    vim.schedule(function()
        vim.cmd.split()
        vim.cmd.Oil(expanded_dir)
    end)
end

return M
