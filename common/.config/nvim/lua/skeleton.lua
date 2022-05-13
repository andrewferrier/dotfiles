-- luacheck: globals vim

local M = {}

local function find_skeleton(filetype)
    local runtimepath = vim.opt.runtimepath._value

    local skeletons = vim.fn.globpath(
        runtimepath,
        "skeleton/" .. filetype,
        0,
        1
    )

    return skeletons[1]
end

local function handle_skeleton(filetype, skeleton)
    vim.ui.select({
        "Open it in a split",
        "Read it into the file",
        "Ignore it",
    }, {
        prompt = "What do you want to do with the skeleton?",
    }, function(_, idx)
        if idx == 1 then
            vim.cmd("split " .. skeleton)
            vim.cmd("set filetype=" .. filetype)
        elseif idx == 2 then
            vim.cmd("read " .. skeleton)
            vim.cmd("norm kdd")
        end
    end)
end

M.show_prompt = function(autocmd)
    local filetype = vim.opt.filetype:get()

    if filetype ~= nil and filetype ~= "" then
        local skeleton = find_skeleton(filetype)

        if skeleton ~= nil and skeleton ~= "" then
            handle_skeleton(filetype, skeleton)
        elseif not autocmd then
            vim.notify("No skeleton found for filetype '" .. filetype .. "'")
            vim.cmd("silent split " .. vim.fn.stdpath("config") .. "/skeleton")
        end
    else
        vim.notify("No filetype")
    end
end

return M
