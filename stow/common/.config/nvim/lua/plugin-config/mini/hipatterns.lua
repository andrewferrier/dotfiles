local hipatterns = require("mini.hipatterns")

local if_textfile = function(pattern)
    return function()
        if
            vim.tbl_contains({
                "asciidoc",
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

hipatterns.setup({
    highlighters = {
        fixme = {
            pattern = if_textfile("%f[%w]()FIXME()%f[%W]"),
            group = "@text.danger.comment",
        },
        todo = {
            pattern = if_textfile("%f[%w]()TODO()%f[%W]"),
            group = "@text.todo.comment",
        },
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})
