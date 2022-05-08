-- luacheck: globals vim
local set = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {})
end

local DATE = "=strftime('%F')"
local DATETIME = "=strftime('%FT%T%z')"

set("<Leader>n.", ":split ./<C-R>" .. DATE .. "<CR>-")
set("<Leader>nd", ":split ~/Desktop/<C-R>" .. DATE .. "<CR>-")
set("<Leader>nm", ":split ~/Documents/meetings/<C-R>" .. DATE .. "<CR>-")
set("<Leader>nn", ":split ~/notes/<C-R>" .. DATE .. "<CR>-")

set("<Leader>nT", ":split /tmp/<C-R>" .. DATETIME .. "<CR>.md<CR>")
set("<Leader>nt", ":split /tmp/<C-R>" .. DATETIME .. "<CR>-")

set("<Leader>s.", ":save ./<C-R>" .. DATE .. "<CR>-")
set("<Leader>sd", ":save ~/Desktop/<C-R>" .. DATE .. "<CR>-")
set("<Leader>sm", ":save ~/Documents/meetings/<C-R>" .. DATE .. "<CR>-")
set("<Leader>sn", ":save ~/notes/<C-R>" .. DATE .. "<CR>-")

set("<Leader>sT", ":save /tmp/<C-R>" .. DATETIME .. "<CR>.md<CR>")
set("<Leader>st", ":save /tmp/<C-R>" .. DATETIME .. "<CR>-")
