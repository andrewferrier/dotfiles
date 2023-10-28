require("filetype.section").setup("^#")
require("filetype.text").setup()

vim.cmd.iabbrev(
    "<buffer>",
    "zTODO",
    '<span style="color:red">TODO:</span><Esc>F<i'
)

local surround = require("mini.surround")

vim.b.minisurround_config = {
    custom_surroundings = {
        l = {
            output = function()
                local clipboard = tostring(vim.fn.getreg("+")):gsub("\n", "")
                return { left = "[", right = "](" .. clipboard .. ")" }
            end,
        },
        L = {
            output = function()
                local link_name = surround.user_input("Enter the link name: ")
                return {
                    left = "[" .. link_name .. "](",
                    right = ")",
                }
            end,
        },
    },
}
