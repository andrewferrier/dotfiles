if vim.fn.has("nvim-0.9.0") == 1 then
    _G.custom_statuscol = function()
        if vim.v.virtnum == 0 then
            if vim.o.relativenumber == true then
                return "%s%=%r "
            else
                return "%s%=%l "
            end
        else
            return ""
        end
    end

    vim.opt.statuscolumn = "%{%v:lua.custom_statuscol()%}"
    vim.opt.signcolumn = "yes:1"
else
    -- numbers and signs in the same column
    vim.opt.signcolumn = "number"
end

vim.opt.relativenumber = true
vim.opt.number = true
