_G.custom_statuscol = function()
    if vim.v.virtnum == 0 then
        local signs = vim.fn.sign_getplaced(
            vim.fn.bufname(),
            { group = "*", lnum = tostring(vim.v.lnum) }
        )[1].signs[1]

        if signs ~= nil then
            if vim.o.relativenumber == true then
                return "%s%=%r "
            else
                return "%s%=%l "
            end
        else
            if vim.o.relativenumber == true then
                return "%=%r "
            else
                return "%=%l "
            end
        end
    else
        return ""
    end
end

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%{%v:lua.custom_statuscol()%}"
