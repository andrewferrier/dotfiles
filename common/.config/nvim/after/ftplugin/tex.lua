-- luacheck: globals vim

require("filetype.text").setup()

local function create_pdf_from_tex(absolute_tex_path)
    vim.cmd("update")
    local directory = vim.fn.fnamemodify(absolute_tex_path, ":p:h")
    local without_extension = vim.fn.fnamemodify(absolute_tex_path, ":p:r")

    local output = vim.fn.system({
        "pdflatex",
        "-output-directory=" .. directory,
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
