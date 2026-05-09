vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            -- FIXME: Not sure why packadd is needed
            vim.cmd.packadd("nvim-treesitter")

            if ev.data.kind == "update" then
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

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
    callback = function(args)
        local treesitter = require("nvim-treesitter")
        local filetype = vim.bo[args.buf].filetype

        if vim.bo[args.buf].buftype ~= "" or filetype == "" then
            return
        end

        if
            vim.list_contains(
                treesitter.get_installed(),
                vim.treesitter.language.get_lang(filetype)
            )
        then
            vim.treesitter.start(args.buf)
        else
            vim.notify(
                "Treesitter parser missing for "
                    .. filetype
                    .. "; installing..."
            )
            treesitter.install(filetype):wait(60000)
            vim.treesitter.start(args.buf)
        end
    end,
})
