---@param tail string
---@return string|nil
local function get_skeleton_match(tail)
    local skeleton =
        vim.api.nvim_get_runtime_file("skeleton/" .. tail, false)[1]

    if skeleton == "" then
        return nil
    else
        return skeleton
    end
end

---@return string|nil
local function find_skeleton()
    local skeleton = get_skeleton_match(vim.fn.expand("%:t"))

    if skeleton == nil then
        local extension = vim.fn.expand("%:e")

        if extension ~= nil and extension ~= "" then
            skeleton = get_skeleton_match(extension)
        end
    end

    if skeleton == nil then
        local filetype = vim.o.filetype

        if filetype ~= nil and filetype ~= "" then
            skeleton = get_skeleton_match(filetype)
        end
    end

    return skeleton
end

local function check_for_skeleton()
    local skeleton = find_skeleton()

    if skeleton ~= nil then
        vim.cmd.read(skeleton)
        vim.cmd.normal({ args = { "kddG" }, bang = true })
        vim.cmd.normal({ args = { "zM" } })
        vim.api.nvim_set_option_value(
            "foldmethod",
            "marker",
            { scope = "local" }
        )
        vim.notify("Added skeleton " .. skeleton)
    end
end

vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("skeleton", {}),
    pattern = "*",
    callback = check_for_skeleton,
})
