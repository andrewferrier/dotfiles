vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.cmd.packadd("nvim-treesitter")

            if ev.data.kind == "update" then
                vim.cmd.TSUpdate()
            end
        end
    end,
})

-- Without the version, it keeps switching back to 'master' as the branch
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
})
-- By doing packadd, it forces plugin/filetypes.lua to be loaded, which is
-- important for filetype <-> lang mapping
vim.cmd.packadd("nvim-treesitter")

require("nvim-treesitter").setup()
local available_to_install = require("nvim-treesitter").get_available()

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
    callback = function(args)
        local treesitter = require("nvim-treesitter")
        local filetype = vim.bo[args.buf].filetype

        if vim.bo[args.buf].buftype ~= "" or filetype == "" then
            return
        end

        local treesitter_lang = vim.treesitter.language.get_lang(filetype)

        if vim.list_contains(treesitter.get_installed(), treesitter_lang) then
            vim.treesitter.start(args.buf)
        else
            if vim.list_contains(available_to_install, treesitter_lang) then
                vim.notify(
                    "Treesitter parser missing for "
                        .. filetype
                        .. "; installing..."
                )
                treesitter.install(filetype):wait(60000)
                vim.treesitter.start(args.buf)
            end
        end
    end,
})
