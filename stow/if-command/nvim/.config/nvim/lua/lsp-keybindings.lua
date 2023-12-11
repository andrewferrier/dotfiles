local M = {}

local function is_lsp_loaded(client_name)
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
        if client.name == client_name then
            return true
        end
    end

    return false
end

local function is_correct_lsp_loaded(filetype)
    if filetype == "terraform" then
        return is_lsp_loaded("terraformls")
    else
        return true
    end
end

local function lsp_document_format()
    if not is_correct_lsp_loaded(vim.bo.filetype) then
        vim.notify(
            "Required LSPs not yet loaded, please wait a bit and retry.",
            vim.log.levels.ERROR
        )

        return
    end

    vim.lsp.buf.format({ timeout_ms = 3000 })
    vim.notify("Formatted document using LSP.")
end

M.inlay_hints = function(bufnr)
    vim.lsp.inlay_hint.enable(bufnr, true)

    vim.keymap.set("n", "yoi", function()
        vim.lsp.inlay_hint.enable(
            bufnr,
            not vim.lsp.inlay_hint.is_enabled(bufnr)
        )
    end, { buffer = bufnr, desc = "Toggle inlay hints" })
end

M.formatting = function(bufnr)
    vim.keymap.set(
        "n",
        "gQ",
        lsp_document_format,
        { buffer = bufnr, desc = "Format buffer" }
    )
end

M.codeaction = function(bufnr)
    -- Don't use visual mode here, conflicts with 'c'
    vim.keymap.set(
        "n",
        "cxa",
        require("fzf-lua").lsp_code_actions,
        { buffer = bufnr, desc = "Apply code action" }
    )
end

return M
