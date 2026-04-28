vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            -- FIXME: Not sure why packadd is needed
            vim.cmd.packadd("nvim-treesitter")

            if ev.data.kind == "install" then
                vim.cmd.TSInstall("all")
            elseif ev.data.kind == "update" then
                vim.cmd.TSInstall("all")
                vim.cmd.TSUpdate()
            end
        end
    end,
})

-- Without this, it keeps switching back to 'master' as the branch
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
})

require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("treesitter-start-files", {}),
    pattern = vim.iter(require("nvim-treesitter").get_installed("parsers"))
        :map(function(parser)
            return vim.treesitter.language.get_filetypes(parser)
        end)
        :flatten()
        :totable(),
    callback = function()
        vim.treesitter.start()
    end,
})
