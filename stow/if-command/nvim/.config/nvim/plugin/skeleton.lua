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

---@param from_scratch boolean
---@return nil
local function check_and_insert_skeleton(from_scratch)
    local skeleton = find_skeleton()
    local end_line = 0

    if skeleton ~= nil then
        if from_scratch then
            end_line = -1
        end

        vim.api.nvim_buf_set_lines(
            0,
            0,
            end_line,
            true,
            vim.fn.readfile(skeleton)
        )

        if from_scratch then
            vim.cmd.normal({ args = { "G" }, bang = true })
        end

        vim.api.nvim_set_option_value(
            "foldmethod",
            "marker",
            { scope = "local" }
        )

        vim.api.nvim_set_option_value("foldlevel", 0, { scope = "local" })

        vim.notify("Added skeleton " .. skeleton)
    end
end

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = function()
        check_and_insert_skeleton(true)
    end,
})

vim.api.nvim_create_user_command("SkeletonRead", function()
    check_and_insert_skeleton(false)
end, {})
