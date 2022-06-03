-- luacheck: globals vim

require("filetype.text").setup()

local function create_pdf_from_tex(absoluteTexPath)
    vim.cmd("update")
    local directory = vim.fn.fnamemodify(absoluteTexPath, ":p:h")
    local withoutExtension = vim.fn.fnamemodify(absoluteTexPath, ":p:r")

    vim.fn.system({
        "pdflatex",
        "-output-directory=" .. directory,
        absoluteTexPath,
    })
    vim.fn.system({ "open", withoutExtension .. ".pdf" })
end

vim.keymap.set("n", "<Leader>cp", function()
    create_pdf_from_tex(vim.fn.expand("%:p"))
end, {
    buffer = true,
})
