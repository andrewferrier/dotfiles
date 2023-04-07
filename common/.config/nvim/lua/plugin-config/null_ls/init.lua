local supports_method_for_filetype = function(filetype, method)
    local sources = require("null-ls.sources")
    local available = sources.get_available(filetype, method)
    return #available > 0
end

local on_attach = function(_, bufnr)
    local filetype = vim.bo.filetype

    local lsp_keybindings = require("lsp-keybindings")

    if supports_method_for_filetype(filetype, "NULL_LS_FORMATTING") then
        lsp_keybindings.formatting(bufnr)
    end

    if supports_method_for_filetype(filetype, "NULL_LS_CODE_ACTION") then
        lsp_keybindings.codeaction(bufnr)
    end
end

require("null-ls").setup({
    -- debug = true,
    sources = require("plugin-config.null_ls.sources").sources,
    on_attach = on_attach,
    should_attach = function(bufnr)
        return not require("utils").is_large_file(bufnr)
    end,
})
