---@param linenum integer
---@return boolean
local signs_on_line = function(linenum)
    return vim.fn.sign_getplaced(
        vim.fn.bufname(),
        { group = "*", lnum = tostring(linenum) }
    )[1].signs[1] ~= nil
end

if vim.fn.has("nvim-0.11.0") == 1 then
    ---@return string
    _G.custom_statuscol = function()
        if vim.v.virtnum ~= 0 then
            return ""
        end

        if vim.o.number == false then
            if vim.o.relativenumber == true then
                return "%s%l "
            else
                return "%s" .. vim.v.lnum .. " "
            end
        else
            return "%s"
        end
    end

    vim.opt.number = false
else
    ---@return string
    _G.custom_statuscol = function()
        if vim.v.virtnum ~= 0 then
            return ""
        end

        local line

        if signs_on_line(vim.v.lnum) then
            line = "%s"
        else
            line = ""
        end

        if vim.o.relativenumber == true then
            return line .. "%=%r "
        else
            return line .. "%=%l "
        end
    end

    vim.opt.number = true
end

vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%{%v:lua.custom_statuscol()%}"
