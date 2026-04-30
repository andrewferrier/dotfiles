vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = function()
        -- Don't insert skeletons in diff mode; just confusing!
        if vim.opt.diff:get() == false then
            require("skeleton").check_and_insert_skeleton(true)
        end
    end,
})

vim.api.nvim_create_user_command("SkeletonRead", function()
    require("skeleton").check_and_insert_skeleton(false)
end, {})
