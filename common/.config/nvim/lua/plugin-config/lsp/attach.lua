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

M.keybindings_defaults = function()
    local map = function(keys, action_desc)
        vim.keymap.set("n", keys, function()
            vim.notify(
                "Don't know how to " .. action_desc .. " this filetype.",
                vim.log.levels.ERROR
            )
        end)
    end

    map("cxo", "organize imports for")
    map("cxa", "apply code actions for")
    map("gQ", "document format")
end

M.keybindings_formatting = function(bufnr)
    vim.keymap.set("n", "gQ", lsp_document_format, { buffer = bufnr })
end

M.keybindings_codeaction = function(bufnr)
    vim.keymap.set("n", "cxa", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("x", "cxa", vim.lsp.buf.code_action, { buffer = bufnr })
end

M.keybindings_rename = function(bufnr)
    vim.keymap.set("n", "cxr", function()
        return ":LspRename " .. vim.fn.expand("<cword>")
    end, {
        expr = true,
        buffer = bufnr,
    })
end

M.lsp_supports_rename = function(bufnr)
    for _, client in pairs(vim.lsp.buf_get_clients(bufnr)) do
        if client.server_capabilities.renameProvider then
            return true
        end
    end

    return false
end

local function keybindings_formatting_check(bufnr, server_capabilities)
    if server_capabilities.documentFormattingProvider == true then
        M.keybindings_formatting(bufnr)
    end
end

local function keybindings_codeaction_check(bufnr, server_capabilities)
    if server_capabilities.codeActionProvider then
        M.keybindings_codeaction(bufnr)
    end
end

local function keybindings_rename_check(bufnr, server_capabilities)
    if server_capabilities.renameProvider then
        M.keybindings_rename(bufnr)
    end
end

local function keybindings_hover_keyword(bufnr, server_capabilities, filetype)
    if filetype == "lua" then
        vim.bo.keywordprg = ":help"
    elseif filetype == "terraform" then
        -- Don't map "K"; this is handled in
        -- ~/.config/nvim/after/ftplugin/terraform.lua
    elseif server_capabilities.hoverProvider then
        if filetype ~= "vim" then
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        end
    else
        vim.keymap.set("n", "K", function()
            vim.notify("Hover not supported by LSP.", vim.log.levels.ERROR)
        end, { buffer = bufnr })
    end
end

local function keybindings_organizeimports(bufnr, lsp_name)
    if lsp_name == "tsserver" then
        vim.keymap.set("n", "cxo", function()
            require("typescript").actions.organizeImports()
        end, { buffer = bufnr })
    elseif lsp_name == "pyright" then
        vim.keymap.set("n", "cxo", function()
            vim.cmd("silent! PyrightOrganizeImports")
        end, { buffer = bufnr })
    end
end

M.on_attach = function(client, bufnr)
    local lsp_name = client.name
    local server_capabilities = client.server_capabilities
    local filetype = vim.bo.filetype

    keybindings_formatting_check(bufnr, server_capabilities)
    keybindings_codeaction_check(bufnr, server_capabilities)
    keybindings_rename_check(bufnr, server_capabilities)
    keybindings_hover_keyword(bufnr, server_capabilities, filetype)
    keybindings_organizeimports(bufnr, lsp_name)

    vim.api.nvim_create_user_command(
        "LspWhatCapabilities",
        "Capture call v:lua.show_capabilities()",
        {}
    )
end

return M