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

M.formatting = function(bufnr)
    vim.keymap.set(
        "n",
        "gQ",
        lsp_document_format,
        { buffer = bufnr, desc = "Format buffer" }
    )
end

M.codeaction = function(bufnr)
    local DESC = "Apply code action"

    vim.keymap.set(
        { "n", "x" },
        "cxa",
        require("fzf-lua").lsp_code_actions,
        { buffer = bufnr, desc = DESC }
    )
end

return M
