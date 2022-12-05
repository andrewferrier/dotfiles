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
    -- Based on https://github.com/neovim/neovim/pull/13896, can be removed when
    -- that is merged.

    local bufnr = 0
    local visual_modes = {
        v = true,
        V = true,
    }

    if visual_modes[vim.api.nvim_get_mode().mode] == nil then
        return
    end

    local options = {}
    options.adjust = function(pos1, pos2)
        if vim.fn.visualmode() == "V" then
            pos1[3] = 1
            pos2[3] = 2 ^ 31 - 1
        end

        if pos1[2] > pos2[2] then
            pos2[3], pos1[3] = pos1[3], pos2[3]
            return pos2, pos1
        elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
            return pos2, pos1
        else
            return pos1, pos2
        end
    end

    local region, start, finish = get_marked_region("v", ".", options)

    if region ~= nil and start ~= nil and finish ~= nil then
        local lines =
            vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
        local line1_end
        if region[start[1]][2] - region[start[1]][1] < 0 then
            line1_end = #lines[1] - region[start[1]][1]
        else
            line1_end = region[start[1]][2] - region[start[1]][1]
        end

        lines[1] =
            vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
        if start[1] ~= finish[1] then
            lines[#lines] = vim.fn.strpart(
                lines[#lines],
                region[finish[1]][1],
                region[finish[1]][2] - region[finish[1]][1]
            )
        end
        return table.concat(lines)
    else
        return nil
    end
end

M.job_stderr = function(_, stderr_line, _)
    stderr_line = stderr_line[1]
    if #stderr_line > 0 then
        vim.notify(stderr_line, vim.log.levels.ERROR)
    end
end

return M
