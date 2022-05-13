-- luacheck: globals vim

local M = {}

M.setup = function(mode)
    local targetmode
    if mode ~= nil then
        targetmode = mode
    else
        targetmode = ""
    end

    -- This might get called multiple times in, for example, the case of
    -- .mkd.txt files, where they are initially detected as .txt by Vim's own
    -- filetype detection, then overridden as markdown in my filetype.lua.
    if vim.b.text_based_filetype == nil then
        if
            not vim.o.readonly
            and vim.o.modifiable
            and vim.fn.empty(vim.fn.bufname("%")) == 0
            and not vim.o.diff
        then
            vim.opt_local.spell = true
        end

        if vim.g.loaded_wrapping_softhard ~= nil then
            if targetmode == "hard" then
                vim.fn["vim_wrapping_softhard#HardWrapMode"]()
            elseif targetmode == "soft" then
                vim.fn["vim_wrapping_softhard#SoftWrapMode"]()
            else
                vim.fn["vim_wrapping_softhard#SetModeAutomatically"]()
            end
        end

        vim.b.text_based_filetype = 1
    end
end

return M
