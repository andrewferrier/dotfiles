vim.api.nvim_create_user_command("PackerProfile", function()
    require("packer_config")
    require("packer").profile_output()
end, {})

vim.api.nvim_create_user_command("PackerSync", function()
    require("packer_config").sync()
end, {})
