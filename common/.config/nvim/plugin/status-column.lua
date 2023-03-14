if vim.fn.has("nvim-0.9.0") == 1 then
    _G.custom_statuscol = function()
        if vim.v.virtnum == 0 then
            local signs = vim.fn.sign_getplaced(
                vim.fn.bufname(),
                { group = "*", lnum = vim.v.lnum }
            )[1].signs[1]

            if signs ~= nil then
                return "%s "
            end

            if vim.o.relativenumber == true then
                return "%=%r "
            else
                return "%=%l "
            end
        else
            return ""
        end
    end

    vim.opt.numberwidth = 3
    vim.opt.signcolumn = "yes"
    vim.opt.statuscolumn = "%{%v:lua.custom_statuscol()%}"
else
    -- numbers and signs in the same column
    vim.opt.signcolumn = "number"
end

vim.opt.relativenumber = true
vim.opt.number = true
