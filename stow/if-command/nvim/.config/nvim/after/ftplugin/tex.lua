require("filetype.text").setup()

vim.keymap.set(
    "n",
    "gO",
    "<Plug>(vimtex-toc-open)",
    { desc = "Show file outline", unique = true }
)

vim.cmd.iabbrev("<buffer>", "zTODO", "\\textcolor{red}{TODO\\@:}<Esc>i")

local surround = require("mini.surround")

vim.b.minisurround_config = {
    custom_surroundings = {
        c = {
            output = function()
                local cmd = surround.user_input("Command: ")
                return { left = "\\" .. cmd .. "{", right = "}" }
            end,
        },
        e = {
            output = function()
                local env = surround.user_input("Environment: ")
                return {
                    left = "\\begin{" .. env .. "}",
                    right = "\\end{" .. env .. "}",
                }
            end,
        },
        l = {
            output = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return { left = "\\href{" .. clipboard .. "}{", right = "}" }
            end,
        },
        L = {
            output = function()
                local link_name = surround.user_input("Enter the link name: ")
                return {
                    left = "\\href{",
                    right = "}{" .. link_name .. "}",
                }
            end,
        },
    },
}
