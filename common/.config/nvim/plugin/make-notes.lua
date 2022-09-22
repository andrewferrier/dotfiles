local set = function(lhs, rhs)
    vim.keymap.set("n", "<Leader>" .. lhs, rhs)
end

local DATE = "=strftime('%F')"
local DATETIME = "=strftime('%FT%T%z')"

set("n.", ":split ./<C-R>" .. DATE .. "<CR>-")
set("nd", ":split ~/Desktop/<C-R>" .. DATE .. "<CR>-")
set("nm", ":split ~/Documents/meetings/<C-R>" .. DATE .. "<CR>-")
set("nn", ":split ~/notes/<C-R>" .. DATE .. "<CR>-")

set("nT", ":split /tmp/<C-R>" .. DATETIME .. "<CR>.md<CR>")
set("nt", ":split /tmp/<C-R>" .. DATETIME .. "<CR>-")

set("s.", ":save ./<C-R>" .. DATE .. "<CR>-")
set("sd", ":save ~/Desktop/<C-R>" .. DATE .. "<CR>-")
set("sm", ":save ~/Documents/meetings/<C-R>" .. DATE .. "<CR>-")
set("sn", ":save ~/notes/<C-R>" .. DATE .. "<CR>-")

set("sT", ":save /tmp/<C-R>" .. DATETIME .. "<CR>.md<CR>")
set("st", ":save /tmp/<C-R>" .. DATETIME .. "<CR>-")
