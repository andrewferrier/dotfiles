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

---@param command string
---@param cwd string?
local open_terminal = function(command, cwd)
    local opts = { term = true }

    if cwd then
        opts.cwd = cwd
    end

    vim.cmd.wincmd("n")

    if vim.fn.has("nvim-0.11.0") == 1 then
        vim.fn.jobstart(command, opts)
    else
        vim.fn.termopen(command, opts)
    end
end

---@param command string
---@param dir string
---@return nil
M.open_terminal = function(command, dir)
    local expanded_dir = select_fileordir(dir, true, false)
    vim.schedule(function()
        open_terminal(command, expanded_dir)
    end)
end

---@param file_or_dir string
---@return nil
M.open_file_manager = function(file_or_dir)
    local expanded_ford = select_fileordir(file_or_dir, false, false)
    vim.schedule(function()
        open_terminal("lf " .. vim.fn.shellescape(expanded_ford))
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
