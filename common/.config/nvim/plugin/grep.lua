-- luacheck: globals vim

if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg="rg --vimgrep --smart-case"
    vim.opt.grepformat="%f:%l:%c:%m"
end
