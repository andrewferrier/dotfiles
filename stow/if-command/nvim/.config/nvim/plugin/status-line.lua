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
function _G.Statusline_FeaturesEnabled()
    local return_string = ""

    if vim.bo.filetype ~= "oil" and vim.bo.buftype ~= "terminal" then
        if require("gitsigns.config").config.show_deleted then
            return_string = return_string .. ",_̸"
        end

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
function _G.Statusline_DiagnosticStatus()
    local content = require("mini.statusline").section_diagnostics({
        icon = "",
        signs = { ERROR = "✘", WARN = "", INFO = "󰋽", HINT = "ɦ" },
    }):gsub("%s+", "")

    if content:len() > 0 then
        return LEFT_BRACE .. content .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string
function _G.Statusline_GitSigns()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return LEFT_BRACE .. vim.b.gitsigns_status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

---@return string
function _G.Statusline_Indent()
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
function _G.Statusline_Filename()
    return vim.fn.pathshorten(
        require("utils").get_filename_homedir(),
        math.floor(vim.fn.winwidth(0) * WIN_WIDTH_FILENAME_FRACTION)
    )
end

---@return string
function _G.Statusline_Getcwd()
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
function _G.Statusline_Wrappingmode()
    local currentmode = require("wrapping").get_current_mode()

    if currentmode ~= nil then
        return "," .. currentmode
    end

    return ""
end

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("ResetSpellingCount", {}),
    callback = function()
        vim.b.spelling_warning = nil
    end,
})

---@return string
function _G.Statusline_SpellingErrorCount()
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
function _G.Statusline_LSPProgress()
    local status = vim.trim(vim.lsp.status())

    if status ~= "" then
        return LEFT_BRACE .. status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

local RESET_HIGHLIGHTING = "%*"
local TRUNCATOR_POSITION = "%<"
local ALIGN_RHS = "%="
local SEPARATOR = "│ "

-- LHS - Filename & Filetype
local statusline = " %{v:lua.Statusline_Filename()}"
statusline = statusline .. " %y"

-- LHS - Cwd
statusline = statusline .. " " .. SEPARATOR
statusline = statusline .. TRUNCATOR_POSITION
statusline = statusline .. "%{v:lua.Statusline_Getcwd()}"
statusline = statusline .. RESET_HIGHLIGHTING

statusline = statusline .. ALIGN_RHS

-- RHS - Warnings
statusline = statusline .. "%{v:lua.Statusline_LSPProgress()}"
statusline = statusline .. "%{v:lua.Statusline_DiagnosticStatus()}"
statusline = statusline .. "%{v:lua.Statusline_SpellingErrorCount()}"
statusline = statusline .. "%{v:lua.Statusline_GitSigns()}"
statusline = statusline .. SEPARATOR

-- RHS - File and feature info
statusline = statusline .. "%{v:lua.Statusline_Indent()}"
statusline = statusline .. "%{&fileformat!=#'unix'?',ff='.&fileformat:''}"
statusline = statusline .. "%{v:lua.Statusline_Wrappingmode()}"
statusline = statusline .. "%{&spell?',S':''}"
statusline = statusline .. "%{v:lua.Statusline_FeaturesEnabled()}"
statusline = statusline .. "%M"
statusline = statusline .. " " .. SEPARATOR

-- RHS - Location
statusline = statusline .. "%l/%L,%c "

vim.o.statusline = statusline

local redraw_timer

local delayed_redraw = function()
    vim.cmd.redrawstatus()
    redraw_timer = nil
end

local callback = function()
    if redraw_timer ~= nil then
        vim.fn.timer_stop(redraw_timer)
    end

    vim.cmd.redrawstatus()
    redraw_timer = vim.fn.timer_start(750, delayed_redraw)
end

vim.api.nvim_create_autocmd("LspProgress", {
    pattern = "*",
    callback = callback,
})
