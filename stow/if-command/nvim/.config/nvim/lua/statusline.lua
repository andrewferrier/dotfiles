local M = {}

local WIN_WIDTH_FILENAME_FRACTION = 0.07
local WIN_WIDTH_DIR_FRACTION = 0.03

local LEFT_BRACE = "‹"
local RIGHT_BRACE = "›"

local RESET_HIGHLIGHTING = "%*"
local TRUNCATOR_POSITION = "%<"
local ALIGN_RHS = "%="
local SEPARATOR = "│ "

---@return string
M.featuresenabled = function()
    local return_string = ""

    if vim.bo.filetype ~= "oil" and vim.bo.buftype ~= "terminal" then
        if not vim.diagnostic.is_enabled() then
            return_string = return_string .. ",¬D"
        end

        if not vim.wo.list and not vim.bo.readonly then
            return_string = return_string .. ",¬list"
        end

        if vim.bo.fileencoding == "" then
            return_string = return_string .. ",fenc=?"
        elseif vim.bo.fileencoding ~= "utf-8" then
            return_string = return_string .. ",fenc=" .. vim.bo.fileencoding
        end
    end

    return return_string
end

---@return string
local gitsigns = function()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return LEFT_BRACE .. vim.b.gitsigns_status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string
local indent = function()
    if vim.bo.buftype == "terminal" then
        return ""
    end

    local returnstring

    if vim.bo.expandtab then
        returnstring = "sw=" .. vim.bo.shiftwidth
    else
        returnstring = "ts=" .. vim.bo.tabstop
    end

    if vim.bo.textwidth ~= 80 and vim.bo.textwidth < 9999 then
        -- If textwidth is very high, we are in 'soft' wrapping mode, don't
        -- display textwidth.
        returnstring = returnstring .. ",tw=" .. vim.bo.textwidth
    end

    return returnstring
end

---@return string
M.filename = function()
    return vim.fn.pathshorten(
        require("utils").get_filename_homedir(),
        math.floor(vim.fn.winwidth(0) * WIN_WIDTH_FILENAME_FRACTION)
    )
end

---@return string
M.getcwd = function()
    if
        vim.bo.filetype ~= "help"
        and vim.bo.filetype ~= "man"
        and vim.bo.buftype ~= "terminal"
    then
        local path = vim.fn.fnamemodify(vim.fn.getcwd(0), ":~")

        return vim.fn.pathshorten(
            path,
            math.floor(vim.fn.winwidth(0) * WIN_WIDTH_DIR_FRACTION)
        )
    else
        return ""
    end
end

---@return string
M.wrappingmode = function()
    local currentmode = require("wrapping").get_current_mode()

    if currentmode ~= nil then
        return "," .. currentmode
    end

    return ""
end

---@return string
M.lspprogress = function()
    local status = vim.trim(vim.lsp.status())

    if status ~= "" then
        return LEFT_BRACE .. status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

local searchcount = function()
    local response

    if vim.v.hlsearch == 0 then
        return ""
    end

    -- `searchcount()` can return errors because it is evaluated very often in
    -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
    local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
    if not ok or s_count.current == nil or s_count.total == 0 then
        return ""
    end

    if s_count.incomplete == 1 then
        return "[?/?] "
    end

    local too_many = ">" .. s_count.maxcount
    local current = s_count.current > s_count.maxcount and too_many
        or s_count.current
    local total = s_count.total > s_count.maxcount and too_many or s_count.total
    response = current .. "/" .. total

    return "[" .. response .. "] "
end

local macrorecording = function()
    local reg = vim.fn.reg_recording()

    if not reg or reg == "" then
        return ""
    end

    return "🔴" .. reg .. " "
end

function M.render()
    -- LHS - Filename & Filetype
    local sl = " %{v:lua.require('statusline').filename()}"
    sl = sl .. " %y"

    -- LHS - Cwd
    sl = sl .. " " .. SEPARATOR
    sl = sl .. TRUNCATOR_POSITION
    sl = sl .. "%{v:lua.require('statusline').getcwd()}"
    sl = sl .. RESET_HIGHLIGHTING

    sl = sl .. ALIGN_RHS

    -- RHS - Progress, Status and Warnings
    sl = sl .. "%-10.S"
    sl = sl .. "%{v:lua.require('statusline').lspprogress()}"
    sl = sl .. "%{v:lua.vim.ui.progress_status()}"
    sl = sl .. "%{% &busy > 0 ? '◐ ' : '' %}"
    sl = sl .. vim.diagnostic.status() .. " "
    sl = sl .. gitsigns()
    sl = sl .. searchcount()
    sl = sl .. macrorecording()

    sl = sl .. SEPARATOR

    -- RHS - File and feature info
    sl = sl .. indent()
    sl = sl .. "%{&fileformat!=#'unix'?',ff='.&fileformat:''}"
    sl = sl .. "%{v:lua.require('statusline').wrappingmode()}"
    sl = sl .. "%{v:lua.require('statusline').featuresenabled()}"
    sl = sl .. "%M"
    sl = sl .. " " .. SEPARATOR

    -- RHS - Location
    sl = sl .. "%l/%L,%c "

    return sl
end

return M
