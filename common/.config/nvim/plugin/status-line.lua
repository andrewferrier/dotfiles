local treesitter_parsers = require("nvim-treesitter.parsers")

local WIN_WIDTH_COMPRESS_THRESHOLD_FILENAME = 100
local WIN_WIDTH_COMPRESS_THRESHOLD_PATH = 200

local function is_diagnostic_enabled()
    return vim.b.diagnostic_enabled == nil or vim.b.diagnostic_enabled == true
end

local function get_diagnostic_count(severity)
    return #vim.diagnostic.get(0, { severity = severity })
end

local function get_diagnostic_types()
    return {
        e = get_diagnostic_count(vim.diagnostic.severity.ERROR),
        w = get_diagnostic_count(vim.diagnostic.severity.WARN),
        i = get_diagnostic_count(vim.diagnostic.severity.INFO),
        h = get_diagnostic_count(vim.diagnostic.severity.HINT),
    }
end

function _G.Statusline_FeaturesEnabled()
    local return_string = ""

    if vim.opt.filetype:get() ~= "dirbuf" then
        if not is_diagnostic_enabled() then
            return_string = return_string .. ",¬D"
        end

        local treesitter_status = treesitter_parsers.has_parser()
            and (
                vim.b.treesitter_enabled == nil
                or vim.b.treesitter_enabled == true
            )

        if not treesitter_status then
            return_string = return_string .. ",¬T"
        end
    end

    return return_string
end

function _G.Statusline_DiagnosticStatus()
    if is_diagnostic_enabled() then
        local diagnostics = {}

        for prefix, count in pairs(get_diagnostic_types()) do
            if count > 0 then
                table.insert(diagnostics, prefix .. count)
            end
        end

        if #diagnostics > 0 then
            return "[D " .. table.concat(diagnostics, ",") .. "]"
        else
            return ""
        end
    end

    return ""
end

function _G.Statusline_GitSigns()
    if vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" then
        return "[" .. vim.b.gitsigns_status .. "]"
    else
        return ""
    end
end

function _G.Statusline_List()
    if
        not vim.opt.list:get()
        and not vim.opt.readonly:get()
        and vim.opt.buftype:get() ~= "terminal"
        and vim.opt.filetype:get() ~= "dirbuf"
    then
        return "[!list]"
    else
        return ""
    end
end

function _G.Statusline_Fileencoding()
    if
        vim.opt.filetype:get() == "dirbuf"
        or vim.opt.buftype:get() == "terminal"
    then
        return ""
    elseif vim.opt.fileencoding:get() == "" then
        return ",fenc=?"
    elseif vim.opt.fileencoding:get() ~= "utf-8" then
        return ",fenc=" .. vim.opt.fileencoding:get()
    end

    return ""
end

function _G.Statusline_Indent()
    local returnstring = ""

    if vim.opt.buftype:get() == "terminal" then
        return returnstring
    end

    if vim.opt.expandtab:get() then
        returnstring = returnstring .. "sw=" .. vim.opt.shiftwidth:get()
    else
        returnstring = returnstring .. "ts=" .. vim.opt.tabstop:get()
    end

    if vim.opt.textwidth:get() ~= 80 then
        -- If shiftwidth is very high, we are in 'soft' wrapping mode, don't
        -- display shiftwidth.
        if vim.opt.textwidth:get() < 9999 then
            returnstring = returnstring .. ",tw=" .. vim.opt.textwidth:get()
        end
    end

    return returnstring
end

function _G.Statusline_Filename()
    local filename = vim.fn.substitute(
        vim.fn.expand("%"),
        "^" .. vim.env.HOME,
        "~",
        ""
    )

    if vim.fn.winwidth(0) < WIN_WIDTH_COMPRESS_THRESHOLD_FILENAME then
        return vim.fn.pathshorten(filename)
    else
        return filename
    end
end

function _G.Statusline_Getcwd()
    if
        not (
            vim.opt.filetype == "help"
            or vim.opt.filetype == "man"
            or vim.opt.buftype == "terminal"
        )
    then
        local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")

        if vim.fn.winwidth(0) < WIN_WIDTH_COMPRESS_THRESHOLD_PATH then
            return " " .. vim.fn.pathshorten(path)
        else
            return " " .. path
        end
    else
        return ""
    end
end

function _G.Statusline_Wrappingmode()
    local currentmode = vim.fn["vim_wrapping_softhard#GetCurrentMode"]()

    if currentmode ~= "off" then
        return "," .. currentmode
    end

    return ""
end

function _G.Titlestring_Filename()
    local filename = vim.fn.substitute(
        vim.fn.expand("%"),
        "^" .. vim.env.HOME,
        "~",
        ""
    )

    return vim.fn.pathshorten(filename)
end

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("ResetSpellingCount", {}),
    callback = function()
        vim.b.spelling_warning = nil
    end,
})

local MAX_SPELL_ERRORS = 20

function _G.Statusline_SpellingErrorCount()
    if vim.opt.spell:get() == true then
        if vim.b.spelling_warning == nil then
            local view = vim.fn.winsaveview()
            local oldwrapscan = vim.opt.wrapscan:get()
            vim.opt.wrapscan = false

            local mycount = 0
            vim.fn.cursor(1, 1)

            while true do
                local lastline = vim.fn.line(".")
                local lastcol = vim.fn.col(".")
                vim.cmd("normal! ]S")
                if
                    (
                        vim.fn.line(".")
                            == lastline
                        and vim.fn.col(".") == lastcol
                    ) or mycount > MAX_SPELL_ERRORS
                then
                    break
                end
                mycount = mycount + 1
            end

            vim.fn.winrestview(view)
            vim.opt.wrapscan = oldwrapscan

            if mycount > MAX_SPELL_ERRORS then
                vim.b.spelling_warning = "[S " .. MAX_SPELL_ERRORS .. "+]"
            elseif mycount > 0 then
                vim.b.spelling_warning = "[S " .. mycount .. "]"
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
            return "[srch: "
                .. searchcount["current"]
                .. "/"
                .. searchcount["total"]
                .. "] "
        end
    end

    return ""
end

local RESET_HIGHLIGHTING = "%*"
local TRUNCATOR_POSITION = "%<"
local ALIGN_RHS = "%="
local SEPARATOR = " | "

-- LHS - Filename & Filetype
local statusline = " %{v:lua.Statusline_Filename()}"
statusline = statusline .. " %y "
statusline = statusline .. TRUNCATOR_POSITION

-- LHS - Cwd
statusline = statusline .. "%#StatusLineSecondary#"
statusline = statusline .. "%{v:lua.Statusline_Getcwd()} "
statusline = statusline .. RESET_HIGHLIGHTING

statusline = statusline .. ALIGN_RHS

-- RHS - Temporary Status
statusline = statusline .. "%{v:lua.Statusline_Search()}"

-- RHS - Warnings
statusline = statusline .. "%m"
statusline = statusline .. "%{v:lua.Statusline_DiagnosticStatus()}"
statusline = statusline .. "%{v:lua.Statusline_SpellingErrorCount()}"
statusline = statusline .. "%{v:lua.Statusline_List()}"
statusline = statusline .. "%{v:lua.Statusline_GitSigns()}"
statusline = statusline .. SEPARATOR

-- RHS - File and feature info
statusline = statusline .. "%{v:lua.Statusline_Indent()}"
statusline = statusline .. "%{v:lua.Statusline_Fileencoding()}"
statusline = statusline .. "%{&fileformat!=#'unix'?',ff='.&fileformat:''}"
statusline = statusline .. "%R"
statusline = statusline .. "%{v:lua.Statusline_Wrappingmode()}"
statusline = statusline .. "%{&spell?',S':''}"
statusline = statusline .. "%{v:lua.Statusline_FeaturesEnabled()}"
statusline = statusline .. SEPARATOR

-- RHS - Location
statusline = statusline .. "%l/%L,%c "

vim.opt.statusline = statusline

-- Title string
vim.g.general_titlestring = "nvim [%{v:lua.Titlestring_Filename()}%( %M%)]"
vim.opt.titlestring = vim.g.general_titlestring

-- Window title
vim.opt.title = true
