function _G.show_capabilities()
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
        print(
            vim.inspect(client.name)
                .. "\n\n"
                .. vim.inspect(client.server_capabilities)
                .. "\n\n"
        )
    end
end

local function warn_unsupported(action_description)
    vim.notify(
        "Don't know how to "
            .. action_description
            .. " in filetype "
            .. vim.o.filetype,
        vim.log.levels.WARN
    )
end

local function supports_method(method)
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
        if client.supports_method(method) then
            return true
        end
    end

    return false
end

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
    elseif
        vim.fn.has("nvim-0.10.0") == 0
        or supports_method(vim.lsp.protocol.Methods.textDocument_formatting)
    then
        vim.lsp.buf.format({ timeout_ms = 3000 })
        vim.notify("Formatted document using LSP.")
    else
        warn_unsupported("format document")
    end
end

local function keybindings_formatting(bufnr)
    vim.keymap.set(
        "n",
        "gQ",
        lsp_document_format,
        { buffer = bufnr, desc = "Format buffer" }
    )
end

local function keybindings_codeaction(bufnr)
    -- Don't use visual mode here, conflicts with 'c'
    vim.keymap.set("n", "cxa", function()
        if
            vim.fn.has("nvim-0.10.0") == 0
            or supports_method(vim.lsp.protocol.Methods.textDocument_codeAction)
        then
            require("fzf-lua").lsp_code_actions({
                winopts = {
                    relative = "cursor",
                    width = 0.6,
                    height = 0.6,
                    row = 1,
                    preview = { vertical = "up:70%" },
                },
            })
        else
            warn_unsupported("apply code actions")
        end
    end, { buffer = bufnr, desc = "Apply code action" })
end

local function keybindings_rename(bufnr)
    if
        vim.fn.has("nvim-0.10.0") == 0
        or supports_method(vim.lsp.protocol.Methods.textDocument_rename)
    then
        vim.keymap.set("n", "cxr", function()
            return ":LspRename " .. vim.fn.expand("<cword>")
        end, {
            expr = true,
            buffer = bufnr,
            desc = "Rename identifier using LSP",
        })
    end
end

local function keybindings_organizeimports(bufnr)
    vim.keymap.set("n", "cxo", function()
        if vim.o.filetype == "python" then
            vim.cmd("silent! PyrightOrganizeImports")
        else
            warn_unsupported("organize imports")
        end
    end, { buffer = bufnr, desc = "Organize imports" })
end

local function keybindings_inlayhints(bufnr)
    vim.keymap.set("n", "yoi", function()
        vim.lsp.inlay_hint.enable(
            bufnr,
            not vim.lsp.inlay_hint.is_enabled(bufnr)
        )
    end, { buffer = bufnr, desc = "Toggle inlay hints" })
end

local function lsp_callback(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client ~= nil then
        local bufnr = event.buf

        keybindings_formatting(bufnr)
        keybindings_codeaction(bufnr)
        keybindings_rename(bufnr)
        keybindings_organizeimports(bufnr)

        if vim.fn.has("nvim-0.10.0") == 1 then
            vim.lsp.inlay_hint.enable(bufnr, true)
            keybindings_inlayhints(bufnr)
        end
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = lsp_callback,
})

vim.api.nvim_create_user_command(
    "LspWhatCapabilities",
    "Capture call v:lua.show_capabilities()",
    {}
)
