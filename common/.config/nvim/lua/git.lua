local M = {}

M.get_git_dir = function()
    local dir = vim.fn.getcwd()
    local cmd = "cd " .. dir .. "; git rev-parse --show-toplevel"
    local root = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
        return vim.fn.trim(root)
    else
        return nil
    end
end

return M
