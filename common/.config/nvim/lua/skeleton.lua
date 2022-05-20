-- luacheck: globals vim

local M = {}

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
        local skeleton = vim.api.nvim_get_runtime_file(
            "skeleton/" .. filetype,
            false
        )[1]

        if skeleton ~= nil and skeleton ~= "" then
            handle_skeleton(filetype, skeleton)
        elseif not autocmd then
            vim.notify(
                "No skeleton found for filetype '" .. filetype .. "'",
                vim.log.levels.ERROR
            )
            vim.cmd("silent split " .. vim.fn.stdpath("config") .. "/skeleton")
        end
    else
        vim.notify("No filetype", vim.log.levels.ERROR)
    end
end

return M
