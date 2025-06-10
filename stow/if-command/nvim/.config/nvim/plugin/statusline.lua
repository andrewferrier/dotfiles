local RESET_HIGHLIGHTING = "%*"
local TRUNCATOR_POSITION = "%<"
local ALIGN_RHS = "%="
local SEPARATOR = "│ "

-- LHS - Filename & Filetype
local statusline = " %{v:lua.require('statusline').filename()}"
statusline = statusline .. " %y"

-- LHS - Cwd
statusline = statusline .. " " .. SEPARATOR
statusline = statusline .. TRUNCATOR_POSITION
statusline = statusline .. "%{v:lua.require('statusline').getcwd()}"
statusline = statusline .. RESET_HIGHLIGHTING

statusline = statusline .. ALIGN_RHS

-- RHS - Warnings
statusline = statusline .. "%{v:lua.require('statusline').lspprogress()}"
statusline = statusline .. "%{v:lua.require('statusline').diagnosticstatus()}"
statusline = statusline .. "%{v:lua.require('statusline').spellingerrorcount()}"
statusline = statusline .. "%{v:lua.require('statusline').gitsigns()}"
statusline = statusline .. SEPARATOR

-- RHS - File and feature info
statusline = statusline .. "%{v:lua.require('statusline').indent()}"
statusline = statusline .. "%{&fileformat!=#'unix'?',ff='.&fileformat:''}"
statusline = statusline .. "%{v:lua.require('statusline').wrappingmode()}"
statusline = statusline .. "%{&spell?',S':''}"
statusline = statusline .. "%{v:lua.require('statusline').featuresenabled()}"
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

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspProgress" }, {
    pattern = "*",
    callback = callback,
})
