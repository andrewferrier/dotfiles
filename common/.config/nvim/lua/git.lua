local M = {}

local expand_input_dir = function(dir)
    if dir then
        return vim.fn.expand(dir, 1)
    else
        return vim.fn.expand("%:p:h", 1)
    end
end

local get_git_root_dir = function(dir)
    local cmd = "cd " .. dir .. "; git rev-parse --show-toplevel"
    local root = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
        return vim.fn.trim(root)
    else
        return nil
    end
end

M.if_in_git = function(callback, dir)
    local use_dir = expand_input_dir(dir)
    local git_root_dir = get_git_root_dir(use_dir)

    if git_root_dir then
        callback(git_root_dir)
    else
        vim.notify(use_dir .. " is not in a git directory.", vim.log.levels.ERROR)
    end
end

return M
