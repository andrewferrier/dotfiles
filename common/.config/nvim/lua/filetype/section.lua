local M = {}

local OPTS = {
    buffer = true,
    silent = true,
}

M.setup = function(pattern_start, pattern_end)
    M.setup_outline(pattern_start)
    M.setup_navigation(pattern_start, pattern_end)
end

M.setup_outline = function(pattern_start)
    vim.keymap.set("n", "gO", function()
        vim.cmd("vimgrep '" .. pattern_start .. "' %")
        vim.cmd("copen")
    end, OPTS)
end

M.setup_navigation = function(pattern_start, pattern_end)
    vim.keymap.set("n", "]]", function()
        vim.cmd("mark '")
        vim.fn.search(pattern_start, "W")
    end, OPTS)

    vim.keymap.set("n", "[[", function()
        vim.cmd("mark '")
        vim.fn.search(pattern_start, "bW")
    end, OPTS)

    vim.keymap.set("v", "]]", function()
        vim.cmd("mark '")
        vim.cmd("normal! gv")
        vim.fn.search(pattern_start, "W")
    end, OPTS)

    vim.keymap.set("v", "[[", function()
        vim.cmd("mark '")
        vim.cmd("normal! gv")
        vim.fn.search(pattern_start, "bW")
    end, OPTS)

    if pattern_end ~= nil then
        vim.keymap.set("n", "][", function()
            vim.cmd("mark '")
            vim.fn.search(pattern_end, "W")
        end, OPTS)

        vim.keymap.set("n", "[]", function()
            vim.cmd("mark '")
            vim.fn.search(pattern_end, "bW")
        end, OPTS)

        vim.keymap.set("v", "][", function()
            vim.cmd("mark '")
            vim.cmd("normal! gv")
            vim.fn.search(pattern_end, "W")
        end, OPTS)

        vim.keymap.set("v", "[]", function()
            vim.cmd("mark '")
            vim.cmd("normal! gv")
            vim.fn.search(pattern_end, "bW")
        end, OPTS)
    end
end

return M
