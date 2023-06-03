local M = {}

local null_ls = require("null-ls")

local diagnostics_by_line_results = function(content, match_regex, name)
    local result = {}

    for line_number = 1, #content do
        match_regex(function(regex, message, severity)
            local line = content[line_number]
            local start_byte, end_byte = regex:match_str(line)

            if start_byte ~= nil then
                table.insert(result, {
                    message = message,
                    severity = severity,
                    row = line_number,
                    col = start_byte + 1,
                    end_row = line_number,
                    end_col = end_byte + 1,
                    source = name,
                })
            end
        end)
    end

    return result
end

M.diagnostics_by_line = function(options)
    return {
        method = null_ls.methods.DIAGNOSTICS,
        name = options.name,
        filetypes = options.filetypes or {},
        disabled_filetypes = options.disabled_filetypes or {},
        generator = {
            async = true,
            fn = function(params, done)
                return done(
                    diagnostics_by_line_results(
                        params.content,
                        options.fn,
                        options.name
                    )
                )
            end,
        },
    }
end

return M
