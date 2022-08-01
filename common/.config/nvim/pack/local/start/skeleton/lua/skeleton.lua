local M = {}

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

local function find_skeleton_with_warning()
    local skeleton = find_skeleton()

    if skeleton == nil then
        vim.notify(
            "No skeleton found for filetype '" .. vim.o.filetype .. "'",
            vim.log.levels.WARN
        )
    end

    return skeleton
end

local function check_for_skeleton()
    if find_skeleton() ~= nil then
        vim.notify(
            "Skeleton available; cvsr to read it in; cvss to open in a split.",
            vim.log.levels.WARN
        )
    end
end

M.setup = function()
    vim.api.nvim_create_autocmd("BufNewFile", {
        group = vim.api.nvim_create_augroup("skeleton", {}),
        pattern = "*",
        callback = check_for_skeleton,
    })

    vim.keymap.set("n", "cvsr", function()
        local skeleton = find_skeleton_with_warning()

        if skeleton ~= nil then
            vim.cmd("read " .. skeleton)
            vim.cmd("normal! kdd")
        end
    end)

    vim.keymap.set("n", "cvss", function()
        local existing_filetype = vim.o.filetype
        local skeleton = find_skeleton_with_warning()

        if skeleton ~= nil then
            vim.cmd("split " .. skeleton)
            vim.opt.filetype = existing_filetype
        end
    end)
end

return M
