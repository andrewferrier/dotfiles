local hipatterns = require("mini.hipatterns")

---@param pattern string
---@return function
local if_textfile = function(pattern)
    return function()
        if
            vim.tbl_contains({
                "asciidoc",
                "hurl",
                "latex",
                "markdown",
                "rst",
                "tex",
                "text",
            }, vim.bo.filetype)
        then
            return pattern
        else
            return nil
        end
    end
end

local highlighters = {
    fixme = {
        pattern = if_textfile("%f[%w]()FIXME()%f[%W]"),
        group = "MiniHipatternsFixme",
    },
    todo = {
        pattern = if_textfile("%f[%w]()TODO()%f[%W]"),
        group = "MiniHipatternsTodo",
    },
}

if vim.fn.has("nvim-0.12.0") == 0 then
    highlighters.hex_color = hipatterns.gen_highlighter.hex_color()
end

hipatterns.setup({ highlighters = highlighters })
