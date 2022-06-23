local M = {}

local function handle_skeleton(filetype, skeleton)
    vim.ui.select({
        "Open " .. skeleton .. " in a split",
        "Read " .. skeleton .. " into the file",
        "Ignore it",
    }, {
        prompt = "What do you want to do with the skeleton?",
    }, function(_, idx)
        if idx == 1 then
            vim.cmd("split " .. skeleton)
            vim.opt.filetype = filetype
        elseif idx == 2 then
            vim.cmd("read " .. skeleton)
            vim.cmd("norm kdd")
        end
    end)
end

local function get_skeleton_match(tail)
    local skeleton =
        vim.api.nvim_get_runtime_file(
            "skeleton/" .. tail,
            false
        )[1]

    if skeleton == "" then
        return nil
    else
        return skeleton
    end
end

M.show_prompt = function(autocmd)
    local skeleton = get_skeleton_match(vim.fn.expand("%:t"))

    local filetype = vim.opt.filetype:get()

    if skeleton == nil and filetype ~= "" then
        skeleton = get_skeleton_match(filetype)
    end

    if skeleton ~= nil then
        handle_skeleton(filetype, skeleton)
    elseif not autocmd then
        vim.notify(
            "No skeleton found for filetype '" .. filetype .. "'",
            vim.log.levels.ERROR
        )
    end
end

return M
