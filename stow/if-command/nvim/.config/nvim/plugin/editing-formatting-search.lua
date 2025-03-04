vim.opt.clipboard = "unnamed" -- On OSX, unnamed=unnamedplus, on Linux, autocutsel syncs them anyway
vim.opt.expandtab = true
vim.opt.formatoptions:append("l")
vim.opt.ignorecase = true
vim.opt.mousescroll = "ver:3,hor:1"
vim.opt.nrformats:append("unsigned")
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.textwidth = 80 -- Default for most languages: https://en.wikipedia.org/wiki/Characters_per_line#In_programming
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full"

vim.opt.completeopt:append("popup")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:remove("noinsert")

if vim.fn.has("nvim-0.11.0") == 1 then
    vim.opt.completeopt:append("fuzzy")
else
    vim.opt.diffopt:append("linematch:40")
end

-- see https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("vertical")

vim.cmd.iabbrev("zDATE", '<C-R>=strftime("%F")<CR>')
vim.cmd.iabbrev("zDATETIME", '<C-R>=strftime("%FT%H:%M:%S")<CR>')

-- Search only inside visual selection
vim.keymap.set("x", "/", "<Esc>/\\%V")

if vim.fn.has("nvim-0.11.0") == 0 then
    -- These are included in nightly: https://github.com/neovim/neovim/pull/30984
    vim.keymap.set(
        "n",
        "[<Space>",
        "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
        { desc = "Put empty line(s) above", unique = true }
    )

    vim.keymap.set(
        "n",
        "]<Space>",
        "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
        { desc = "Put empty line(s) below", unique = true }
    )
end
