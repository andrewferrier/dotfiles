local M = {}

local WIN_WIDTH_FILENAME_FRACTION = 0.07
local WIN_WIDTH_DIR_FRACTION = 0.03

local MAX_SPELL_ERRORS = 20

local LEFT_BRACE = "‹"
local RIGHT_BRACE = "›"

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
M.diagnosticstatus = function()
    local content = require("mini.statusline")
        .section_diagnostics({
            icon = "",
            signs = { ERROR = "✘", WARN = "", INFO = "󰋽", HINT = "ɦ" },
        })
        :gsub("%s+", "")

    if content:len() > 0 then
        return LEFT_BRACE .. content .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string
M.gitsigns = function()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return LEFT_BRACE .. vim.b.gitsigns_status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string
M.indent = function()
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

return M
