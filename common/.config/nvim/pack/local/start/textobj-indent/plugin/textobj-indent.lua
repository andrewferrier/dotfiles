-- luacheck: globals vim

-- Based on https://thevaluable.dev/vim-create-text-objects/

local BLANK_LINE_PATTERN = "^%s*$"

local is_blank_line = function(line)
    return string.match(vim.fn.getline(line), BLANK_LINE_PATTERN)
end

local function check_indented(start_indent, include_blank_lines, line)
    return start_indent > 0
        and (
            (is_blank_line(line) and include_blank_lines)
            or vim.fn.indent(line) >= start_indent
        )
end

local function check_noindent(start_indent, line)
    -- This ensures that if I check indent for a block at top level, it doesn't
    -- capture the whole file.
    return start_indent == 0 and not is_blank_line(line)
end

function _G.indent_textobj_select(include_blank_lines)
    local start_indent = vim.fn.indent(vim.fn.line("."))

    if is_blank_line(vim.fn.line(".")) then
        return
    end

    if vim.v.count > 0 then
        start_indent = start_indent - vim.o.shiftwidth * (vim.v.count - 1)
        if start_indent < 0 then
            start_indent = 0
        end
    end

    local prev_line = vim.fn.line(".") - 1
    while
        prev_line > 0
        and (
            check_indented(start_indent, include_blank_lines, prev_line)
            or check_noindent(start_indent, prev_line)
        )
    do
        vim.cmd("-")
        prev_line = vim.fn.line(".") - 1
    end

    vim.cmd("normal! 0V")

    local next_line = vim.fn.line(".") + 1
    local last_line = vim.fn.line("$")
    while
        next_line <= last_line
        and (
            check_indented(start_indent, include_blank_lines, next_line)
            or check_noindent(start_indent, next_line)
        )
    do
        vim.cmd("+")
        next_line = vim.fn.line(".") + 1
    end
end

for _, mode in ipairs({ "x", "o" }) do
    vim.keymap.set(
        mode,
        "ii",
        ":<c-u>lua _G.indent_textobj_select(false)<cr>",
        { silent = true }
    )
    vim.keymap.set(
        mode,
        "ai",
        ":<c-u>lua _G.indent_textobj_select(true)<cr>",
        { silent = true }
    )
end
