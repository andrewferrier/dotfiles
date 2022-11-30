require("filetype.section").setup(
    "\\\\section\\|\\\\subsection\\|\\\\begin{document}\\|\\\\end{document}"
)
require("filetype.text").setup()

vim.bo.commentstring = "% %s"

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

local function create_pdf_from_tex(absolute_tex_path)
    local AUX_DIRECTORY = "-aux-directory=/tmp"
    local OUTPUT_DIRECTORY = vim.fn.fnamemodify(absolute_tex_path, ":p:h")
    local OUTPUT_DIRECTORY_ARG = "-output-directory=" .. OUTPUT_DIRECTORY

    vim.cmd.update()
    local without_extension = vim.fn.fnamemodify(absolute_tex_path, ":p:r")

    local done_clean = function(_, exitcode, _)
        vim.notify("Built, opening...")

        if exitcode == 0 then
            vim.fn.system({ "open", without_extension .. ".pdf" })
        else
            vim.notify(
                "Could not convert to PDF:\n\n" .. exitcode,
                vim.log.levels.ERROR
            )
        end

        vim.notify("Opened, cleaning...")
        vim.fn.system({ "latexmk", AUX_DIRECTORY, OUTPUT_DIRECTORY_ARG, "-c" })
        vim.notify("Cleaned.")
    end

    vim.notify("Cleaning...")
    vim.fn.jobstart({ "latexmk", AUX_DIRECTORY, OUTPUT_DIRECTORY_ARG, "-c" }, {
        cwd = OUTPUT_DIRECTORY,
        on_exit = function()
            vim.notify("Cleaned, building...")
            vim.fn.jobstart({
                "latexmk",
                AUX_DIRECTORY,
                OUTPUT_DIRECTORY_ARG,
                "-pdf",
                absolute_tex_path,
            }, { on_exit = done_clean, cwd = OUTPUT_DIRECTORY })
        end,
    })
end

vim.keymap.set("n", "<Leader>cp", function()
    create_pdf_from_tex(vim.fn.expand("%:p"))
end, {
    buffer = true,
})
