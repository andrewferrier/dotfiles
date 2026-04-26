local M = {}

local WIN_WIDTH_FILENAME_FRACTION = 0.07
local WIN_WIDTH_DIR_FRACTION = 0.03

local MAX_SPELL_ERRORS = 20

local LEFT_BRACE = "‹"
local RIGHT_BRACE = "›"

local TRUNCATOR_POSITION = "%<"
local ALIGN_RHS = "%="
local SEPARATOR = "│ "

---@return integer
local function get_spelling_count()
    local view = vim.fn.winsaveview()
    local oldwrapscan = vim.o.wrapscan
    vim.o.wrapscan = false

    local spell_count = 0
    vim.fn.cursor(1, 1)

    while true do
        local lastline = vim.fn.line(".")
        local lastcol = vim.fn.col(".")
        vim.cmd.normal({ args = { "]S" }, bang = true })
        if
            (vim.fn.line(".") == lastline and vim.fn.col(".") == lastcol)
            or spell_count > MAX_SPELL_ERRORS
        then
            break
        end
        spell_count = spell_count + 1
    end

    vim.fn.winrestview(view)
    vim.o.wrapscan = oldwrapscan

    if spell_count > MAX_SPELL_ERRORS then
        spell_count = MAX_SPELL_ERRORS
    end

    return spell_count
end

---@return string[]
local featuresenabled = function()
    ---@type string[]
    local returns = {}

    if vim.bo.filetype ~= "oil" and vim.bo.buftype ~= "terminal" then
        if not vim.diagnostic.is_enabled() then
            table.insert(returns, "¬D")
        end

        if vim.opt_local.spell:get() then
            table.insert(returns, "S")
        end

        if not vim.wo.list and not vim.bo.readonly then
            table.insert(returns, "¬list")
        end

        if vim.bo.fileencoding == "" then
            table.insert(returns, "fenc=?")
        elseif vim.bo.fileencoding ~= "utf-8" then
            table.insert(returns, "fenc=" .. vim.bo.fileencoding)
        end
    end

    return returns
end

---@return string[]
local fileformat = function()
    if vim.opt.fileformat:get() ~= "unix" then
        return { vim.opt.fileformat:get() }
    end

    return {}
end

---@return string[]
local modified = function()
    if vim.opt_local.modified:get() == true then
        return { "+" }
    end

    return {}
end

---@return string
local gitsigns = function()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return LEFT_BRACE .. vim.b.gitsigns_status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string[]
local indent = function()
    ---@type string[]
    local returns = {}

    if vim.bo.buftype == "terminal" then
        return {}
    end

    if vim.bo.expandtab then
        table.insert(returns, "sw=" .. vim.bo.shiftwidth)
    else
        table.insert(returns, "ts=" .. vim.bo.tabstop)
    end

    if vim.bo.textwidth ~= 80 and vim.bo.textwidth < 9999 then
        -- If textwidth is very high, we are in 'soft' wrapping mode, don't
        -- display textwidth.
        table.insert(returns, "tw=" .. vim.bo.textwidth)
    end

    return returns
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

---@return string[]
local wrappingmode = function()
    local currentmode = require("wrapping").get_current_mode()

    if currentmode ~= nil then
        return { currentmode }
    end

    return {}
end

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufWritePost" }, {
    callback = function()
        vim.b.spelling_warning = nil
    end,
})

---@return string
M.spellingerrorcount = function()
    if vim.wo.spell == true then
        if vim.b.spelling_warning == nil then
            local spelling_count = get_spelling_count()

            if spelling_count > 0 then
                vim.b.spelling_warning = LEFT_BRACE
                    .. "S "
                    .. spelling_count
                    .. RIGHT_BRACE
                    .. " "
            else
                vim.b.spelling_warning = ""
            end
        end
    else
        vim.b.spelling_warning = ""
    end

    return vim.b.spelling_warning
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

    sl = sl .. ALIGN_RHS

    -- RHS - Progress, Status and Warnings
    sl = sl .. "%-10.S"
    sl = sl .. "%{v:lua.require('statusline').lspprogress()}"
    sl = sl .. vim.ui.progress_status()
    sl = sl .. "%{% &busy > 0 ? '◐ ' : '' %}"
    sl = sl .. vim.diagnostic.status() .. " "
    sl = sl .. "%{v:lua.require('statusline').spellingerrorcount()}"
    sl = sl .. gitsigns()
    sl = sl .. searchcount()
    sl = sl .. macrorecording()

    sl = sl .. SEPARATOR

    -- RHS - File and feature info
    sl = sl
        .. table.concat(
            vim.iter({
                fileformat(),
                indent(),
                wrappingmode(),
                featuresenabled(),
                modified(),
            })
                :flatten()
                :totable(),
            ","
        )
    sl = sl .. " " .. SEPARATOR

    -- RHS - Location
    sl = sl .. "%l/%L,%c "

    return sl
end

return M
