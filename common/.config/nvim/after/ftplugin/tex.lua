-- luacheck: globals vim

require("filetype.text").setup()

local function create_pdf_from_tex(absoluteTexPath)
    vim.cmd("update")
    local directory = vim.fn.fnamemodify(absoluteTexPath, ":p:h")
    local withoutExtension = vim.fn.fnamemodify(absoluteTexPath, ":p:r")

    local output = vim.fn.system({
        "pdflatex",
        "-output-directory=" .. directory,
        absoluteTexPath,
    })

    if vim.v.shell_error == 0 then
        vim.fn.system({ "open", withoutExtension .. ".pdf" })
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
