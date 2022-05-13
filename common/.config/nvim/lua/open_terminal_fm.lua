-- luacheck: globals vim

local M = {}

local get_ford_to_use = function(dir)
    if vim.opt.filetype:get() == "dirbuf" then
        return require("dirbuf").get_cursor_path()
    elseif vim.opt.buftype:get() == "" then
        return vim.fn.expand(dir, 1)
    else
        return vim.env.HOME
    end
end

local ensure_dir = function(ford)
    if vim.fn.isdirectory(ford) == 1 then
        return ford
    else
        return ford:gsub("(.*)/.*$","%1")
    end
end

M.open_terminal = function(command, dir)
    local expanded_dir = ensure_dir(get_ford_to_use(dir))
    vim.cmd("wincmd n")
    vim.fn.termopen(command, { cwd = expanded_dir })
end

M.open_file_manager = function(file_or_dir)
    local expanded_ford = get_ford_to_use(file_or_dir)
    vim.cmd("wincmd n")
    vim.fn.termopen("ranger --selectfile=" .. vim.fn.shellescape(expanded_ford))
end

return M
