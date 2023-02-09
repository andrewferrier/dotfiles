local diagnostics = require("diagnostics")

local WIN_WIDTH_FILENAME_FRACTION = 0.07
local WIN_WIDTH_DIR_FRACTION = 0.03

local MAX_SPELL_ERRORS = 20

local LEFT_BRACE = "‹"
local RIGHT_BRACE = "›"

local function get_filename_homedir()
    return vim.fn.substitute(vim.fn.expand("%"), "^" .. vim.env.HOME, "~", "")
end

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

function _G.Statusline_FeaturesEnabled()
    local return_string = ""

    if vim.bo.filetype ~= "dirbuf" then
        if require("gitsigns.config").config.show_deleted then
            return_string = return_string .. ",_̸"
        end

        if not diagnostics.enabled() then
            return_string = return_string .. ",D̸"
        end

        local bufnr = vim.api.nvim_get_current_buf()

        if not vim.treesitter.highlighter.active[bufnr] then
            return_string = return_string .. ",T̸"
        end
    end

    return return_string
end

function _G.Statusline_DiagnosticStatus()
    if diagnostics.enabled() then
        local diagnostics_counts = {}

        for prefix, severity in pairs({
            e = vim.diagnostic.severity.ERROR,
            w = vim.diagnostic.severity.WARN,
            i = vim.diagnostic.severity.INFO,
            h = vim.diagnostic.severity.HINT,
        }) do
            local count = #vim.diagnostic.get(0, { severity = severity })

            if count > 0 then
                table.insert(diagnostics_counts, prefix .. count)
            end
        end

        if #diagnostics_counts > 0 then
            return LEFT_BRACE
                .. "D "
                .. table.concat(diagnostics_counts, ",")
                .. RIGHT_BRACE
                .. " "
        else
            return ""
        end
    end

    return ""
end

function _G.Statusline_GitSigns()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return LEFT_BRACE .. vim.b.gitsigns_status .. RIGHT_BRACE .. " "
    else
        return ""
    end
end

function _G.Statusline_List()
    if
        not vim.wo.list
        and not vim.bo.readonly
        and vim.bo.buftype ~= "terminal"
        and vim.bo.filetype ~= "dirbuf"
    then
        return ",nolist"
    else
        return ""
    end
end

function _G.Statusline_Fileencoding()
    if vim.bo.filetype == "dirbuf" or vim.bo.filetype == "terminal" then
        return ""
    elseif vim.bo.fileencoding == "" then
        return ",fenc=?"
    elseif vim.bo.fileencoding ~= "utf-8" then
        return ",fenc=" .. vim.bo.fileencoding
    end

    return ""
end

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

function _G.Statusline_Filename()
    return vim.fn.pathshorten(
        get_filename_homedir(),
        math.floor(vim.fn.winwidth(0) * WIN_WIDTH_FILENAME_FRACTION)
    )
end

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

function _G.Statusline_Wrappingmode()
    local currentmode = require("wrapping").get_current_mode()

    if currentmode ~= nil then
        return "," .. currentmode
    end

    return ""
end

function _G.Titlestring_Filename()
    return vim.fn.pathshorten(get_filename_homedir())
end

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("ResetSpellingCount", {}),
    callback = function()
        vim.b.spelling_warning = nil
    end,
})

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

function _G.Statusline_Search()
    if vim.v.hlsearch == 1 then
        local searchcount = vim.fn.searchcount()

        if searchcount["total"] > 0 then
            return " "
                .. "s "
                .. searchcount["current"]
                .. "∕"
                .. searchcount["total"]
        end
    end

    return ""
end

function _G.Statusline_MacroRecording()
    local recording_register = vim.fn.reg_recording()

    if recording_register == "" then
        return ""
    else
        return LEFT_BRACE .. "rec @" .. recording_register .. RIGHT_BRACE .. " "
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

-- RHS - Search Counter
statusline = statusline .. "%{v:lua.Statusline_Search()}"
statusline = statusline .. " " .. SEPARATOR

-- RHS - Warnings
statusline = statusline .. "%{v:lua.Statusline_DiagnosticStatus()}"
statusline = statusline .. "%{v:lua.Statusline_SpellingErrorCount()}"
statusline = statusline .. "%{v:lua.Statusline_GitSigns()}"
statusline = statusline .. "%{v:lua.Statusline_MacroRecording()}"
statusline = statusline .. SEPARATOR

-- RHS - File and feature info
statusline = statusline .. "%{v:lua.Statusline_Indent()}"
statusline = statusline .. "%{v:lua.Statusline_Fileencoding()}"
statusline = statusline .. "%{&fileformat!=#'unix'?',ff='.&fileformat:''}"
statusline = statusline .. "%{v:lua.Statusline_Wrappingmode()}"
statusline = statusline .. "%{&spell?',S':''}"
statusline = statusline .. "%{v:lua.Statusline_FeaturesEnabled()}"
statusline = statusline .. "%{v:lua.Statusline_List()}"
statusline = statusline .. "%M"
statusline = statusline .. " " .. SEPARATOR

-- RHS - Location
statusline = statusline .. "%l/%L,%c "

vim.o.statusline = statusline

-- Title string
vim.g.general_titlestring = "nvim [%{v:lua.Titlestring_Filename()}%( %M%)]"
vim.o.titlestring = vim.g.general_titlestring

-- Window title
vim.o.title = true
