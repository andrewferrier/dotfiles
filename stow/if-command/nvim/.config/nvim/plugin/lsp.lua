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

---@param action_description string
local function warn_unsupported(action_description)
    vim.notify(
        "Don't know how to "
            .. action_description
            .. " in filetype "
            .. vim.o.filetype,
        vim.log.levels.WARN
    )
end

local function lsp_document_format()
    if
        require("utils").lsp_supports_method(
            vim.lsp.protocol.Methods.textDocument_formatting
        )
    then
        vim.lsp.buf.format({ timeout_ms = 3000 })
        vim.notify("Formatted document using LSP.")
    else
        warn_unsupported("format document")
    end
end

---@param bufnr integer
local function keybindings_formatting(bufnr)
    vim.keymap.set(
        "n",
        "gQ",
        lsp_document_format,
        { buffer = bufnr, desc = "Format buffer" }
    )
end

---@param bufnr integer
local function keybindings_organizeimports(bufnr)
    vim.keymap.set("n", "gro", function()
        if vim.o.filetype == "python" then
            vim.cmd("silent! PyrightOrganizeImports")
        else
            warn_unsupported("organize imports")
        end
    end, { buffer = bufnr, desc = "Organize imports" })
end

---@param bufnr integer
local function keybindings_inlayhints(bufnr)
    vim.keymap.set("n", "yoi", function()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
            { bufnr = bufnr }
        )
    end, { buffer = bufnr, desc = "Toggle inlay hints" })
end

local function lsp_callback(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client ~= nil then
        local bufnr = event.buf

        keybindings_formatting(bufnr)
        keybindings_organizeimports(bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        keybindings_inlayhints(bufnr)

        vim.keymap.set(
            "n",
            "gra",
            require("fzf-lua").lsp_code_actions,
            { buffer = bufnr, desc = "Apply code action" }
        )
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
