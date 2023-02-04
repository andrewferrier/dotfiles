local function get_skeleton_match(tail)
    local skeleton =
        vim.api.nvim_get_runtime_file("skeleton/" .. tail, false)[1]

    if skeleton == "" then
        return nil
    else
        return skeleton
    end
end

local function find_skeleton()
    local skeleton = get_skeleton_match(vim.fn.expand("%:t"))

    local filetype = vim.o.filetype

    if skeleton == nil and filetype ~= "" then
        skeleton = get_skeleton_match(filetype)
    end

    return skeleton
end

local function check_for_skeleton()
    local skeleton = find_skeleton()

    if skeleton ~= nil then
        vim.cmd.read(skeleton)
        vim.cmd.normal({ args = { "kdd" }, bang = true })
        vim.notify('Added skeleton ' .. skeleton)
    end
end

vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("skeleton", {}),
    pattern = "*",
    callback = check_for_skeleton,
})
