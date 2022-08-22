vim.opt_local.commentstring = "% %s"

require("filetype.text").setup()

local config = require("nvim-surround.config")

require("nvim-surround").buffer_setup({
    surrounds = {
        ["c"] = {
            add = function()
                local cmd = config.get_input("Command: ")
                return { { "\\" .. cmd .. "{" }, { "}" } }
            end,
        },
        ["e"] = {
            add = function()
                local env = config.get_input("Environment: ")
                return {
                    { "\\begin{" .. env .. "}" },
                    {
                        "\\end{" .. env .. "}",
                    },
                }
            end,
        },
    },
})

local function create_pdf_from_tex(absolute_tex_path)
    vim.cmd("update")
    local without_extension = vim.fn.fnamemodify(absolute_tex_path, ":p:r")
    local directory = vim.fn.fnamemodify(absolute_tex_path, ":p:h")

    local output = vim.fn.system({
        "latexmk",
        "-aux-directory=/tmp",
        "-output-directory=" .. directory,
        "-pdf",
        absolute_tex_path,
    })

    if vim.v.shell_error == 0 then
        vim.fn.system({ "open", without_extension .. ".pdf" })
    else
        vim.notify(
            "Could not convert to PDF:\n\n" .. output,
            vim.log.levels.ERROR
        )
    end
end

vim.keymap.set("n", "<Leader>cp", function()
    create_pdf_from_tex(vim.fn.expand("%:p"))
end, {
    buffer = true,
})
