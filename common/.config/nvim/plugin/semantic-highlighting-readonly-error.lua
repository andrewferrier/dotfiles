-- Based on
-- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#complex-highlighting

local function show_unconst_caps(args)
    local token = args.data.token
    if token.type ~= "variable" or token.modifiers.readonly then
        return
    end

    local text = vim.api.nvim_buf_get_text(
        args.buf,
        token.line,
        token.start_col,
        token.line,
        token.end_col,
        {}
    )[1]
    if text ~= string.upper(text) then
        return
    end

    vim.lsp.semantic_tokens.highlight_token(
        token,
        args.buf,
        args.data.client_id,
        "Error"
    )
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local filetype = vim.api.nvim_buf_get_option(args.buf, "filetype")

        if filetype ~= "lua" then
            vim.api.nvim_create_autocmd("LspTokenUpdate", {
                buffer = args.buf,
                callback = show_unconst_caps,
            })
        end
    end,
})
