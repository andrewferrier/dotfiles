local M = {}

---@return string
local expand_input_dir = function(dir)
    if dir then
        return vim.fn.expand(dir, true)
    else
        return vim.fn.expand("%:p:h", true)
    end
end

-- TODO: refactor using vim.fs.root in nvim 0.10+
---@return string|nil
local get_git_root_dir = function(dir)
    local cmd = "cd '" .. dir .. "'; git rev-parse --show-toplevel"
    local root = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
        return vim.trim(root)
    else
        return nil
    end
end

---@param callback function
---@param dir string
---@return nil
M.if_in_git = function(callback, dir)
    local use_dir = expand_input_dir(dir)
    local git_root_dir = get_git_root_dir(use_dir)

    if git_root_dir then
        callback(git_root_dir)
    else
        vim.notify(use_dir .. " is not in a git directory.", vim.log.levels.ERROR)
    end
end

---@param command string
---@param dir string
---@return nil
M.run_git_cmd = function(command, dir)
    M.if_in_git(function()
        require("open_filedirterm").open_terminal(command, dir)
    end, dir)
end

return M
