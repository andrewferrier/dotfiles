vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("PackerCompilePost", { clear = true }),
    pattern = "PackerCompileDone",
    callback = function()
        if vim.g.loaded_nvim_treesitter then
            local treesitter_install = require("nvim-treesitter.install")
            vim.notify("Installing treesitter packages...")
            treesitter_install.ensure_installed("all")
            vim.notify("Updating treesitter packages...")
            treesitter_install.update({ with_sync = true })
        end

        vim.notify("Installing mason packages...")
        vim.cmd("packadd mason-tool-installer.nvim")
        require("mason-tool-installer").check_install(true)

        vim.notify("Sync complete.")
    end,
})

vim.api.nvim_create_user_command("Sync", function()
    require("packer_config").sync()
end, {})

vim.api.nvim_create_user_command("PackerProfile", function()
    require("packer_config")
    require("packer").profile_output()
end, {})
