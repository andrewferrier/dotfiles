local null_ls = require("null-ls")

local null_ls_sources = require("plugin-config.null_ls.sources")

local supports_method_for_filetype = function(filetype, method)
    local sources = require("null-ls.sources")
    local available = sources.get_available(filetype, method)
    return #available > 0
end

local on_attach = function(_, bufnr)
    local filetype = vim.bo.filetype

    local attach = require("plugin-config.lsp.attach")

    if supports_method_for_filetype(filetype, "NULL_LS_FORMATTING") then
        attach.keybindings_formatting(bufnr)
    end

    if supports_method_for_filetype(filetype, "NULL_LS_CODE_ACTION") then
        attach.keybindings_codeaction(bufnr)
    end
end

null_ls.setup({
    -- debug = true,
    sources = null_ls_sources.sources,
    on_attach = on_attach,
    should_attach = function(bufnr)
        return not require("utils").is_large_file(bufnr)
    end,
})
