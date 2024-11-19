---@param lhs string
---@param directory string
---@param createfile boolean
---@param includetime boolean
---@param immediate boolean
---@return nil
local set = function(lhs, directory, createfile, includetime, immediate)
    local command, postfix, date, desc

    if createfile then
        command = ":split "
        desc = "Create new file in "
    else
        command = ":save "
        desc = "Save file in "
    end

    desc = desc .. directory

    if immediate then
        postfix = ".md<CR>"
        desc = desc .. " immediately"
    else
        postfix = "-"
    end

    if includetime then
        date = "=strftime('%FT%T%z')"
    else
        date = "=strftime('%F')"
    end

    local rhs = command .. directory .. "<C-R>" .. date .. "<CR>" .. postfix

    vim.keymap.set("n", "<Leader>" .. lhs, rhs, { desc = desc, unique = true })
end

set("n.", "./", true, false, false)
set("nk", "~/Desktop/", true, false, false)
set("nn", "~/notes/", true, false, false)

set("nT", "/tmp/", true, true, true)
set("nt", "/tmp/", true, true, false)

set("s.", "./", false, false, false)
set("sk", "~/Desktop/", false, false, false)
set("sn", "~/notes/", false, false, false)

set("sT", "/tmp/", false, true, true)
set("st", "/tmp/", false, true, false)
