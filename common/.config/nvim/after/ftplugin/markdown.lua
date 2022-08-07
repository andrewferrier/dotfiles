require("filetype.section").setup("^#")
require("filetype.text").setup()

vim.cmd("packadd markdown-preview.nvim")

vim.cmd('iabbrev <buffer> zTODO <span style="color:red">TODO:</span><Esc>F<i')

local config = require("nvim-surround.config")

require("nvim-surround").buffer_setup({
    surrounds = {
        ["l"] = {
            add = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return {
                    { "[" },
                    { "](" .. clipboard .. ")" },
                }
            end,
            find = "%b[]%b()",
            delete = "^(%[)().-(%]%b())()$",
            change = {
                target = "^()()%b[]%((.-)()%)$",
                replacement = function()
                    local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                    return {
                        { "" },
                        { clipboard },
                    }
                end,
            },
        },
        ["L"] = {
            add = function()
                local link_name = config.get_input("Enter the link name: ")
                return { { "[" .. link_name .. "](" }, { ")" } }
            end,
        },
    },
})
