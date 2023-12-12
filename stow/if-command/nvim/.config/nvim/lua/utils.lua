local M = {}

local function get_marked_region(mark1, mark2, options)
    local bufnr = 0
    local adjust = options.adjust
        or function(pos1, pos2)
            return pos1, pos2
        end
    local regtype = options.regtype or vim.fn.visualmode()
    local selection = options.selection or (vim.o.selection ~= "exclusive")

    local pos1 = vim.fn.getpos(mark1)
    local pos2 = vim.fn.getpos(mark2)
    pos1, pos2 = adjust(pos1, pos2)

    local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
    local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

    -- Return if start or finish are invalid
    if start[2] < 0 or finish[1] < start[1] then
        return
    end

    local region = vim.region(bufnr, start, finish, regtype, selection)
    return region, start, finish
end

M.visual_selection_range = function()
    -- See https://github.com/neovim/neovim/pull/13896#issuecomment-1621702052
    local r = vim.region(0, "'<", "'>", vim.fn.visualmode(), true)
    local text = ""
    local maxcol = vim.v.maxcol
    for line, cols in vim.spairs(r) do
        local endcol = cols[2] == maxcol and -1 or cols[2]
        local chunk =
            vim.api.nvim_buf_get_text(0, line, cols[1], line, endcol, {})[1]
        text = ("%s%s\n"):format(text, chunk)
    end
    return text
end

M.job_stderr = function(_, stderr_line, _)
    stderr_line = stderr_line[1]
    if #stderr_line > 0 then
        vim.notify(stderr_line, vim.log.levels.ERROR)
    end
end

M.is_large_file = function(bufnr)
    return vim.api.nvim_buf_line_count(bufnr or 0) > 10000
end

M.get_filename_homedir = function()
    local curfile = vim.fn.expand("%")
    ---@cast curfile string
    return vim.fn.substitute(curfile, "^" .. vim.env.HOME, "~", "")
end

return M
