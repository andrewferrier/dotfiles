-- FIXME: Dynamically calculate whether to support keybindings based on client.supports_method()

local DISABLED_DESC = "DISABLED FOR THIS FILETYPE"

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

local function keybindings_rename(bufnr)
    vim.keymap.set("n", "cxr", function()
        return ":LspRename " .. vim.fn.expand("<cword>")
    end, {
        expr = true,
        buffer = bufnr,
        desc = "Rename identifier using LSP",
    })
end

local function keybindings_formatting_check(bufnr, server_capabilities)
    if server_capabilities.documentFormattingProvider == true then
        require("lsp-keybindings").formatting(bufnr)
    end
end

local function keybindings_rename_check(bufnr, server_capabilities)
    if server_capabilities.renameProvider then
        keybindings_rename(bufnr)
    end
end

local function keybindings_organizeimports(bufnr, lsp_name)
    vim.keymap.set("n", "cxo", function()
        if vim.o.filetype == "python" then
            vim.cmd("silent! PyrightOrganizeImports")
        else
            vim.notify(
                "Don't know how to organize imports in filetype "
                    .. vim.o.filetype,
                vim.log.levels.WARN
            )
        end
    end, { buffer = bufnr, desc = "Organize imports" })
end

local function lsp_callback(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client ~= nil then
        local bufnr = event.buf
        local lsp_name = client.name
        local server_capabilities = client.server_capabilities

        keybindings_formatting_check(bufnr, server_capabilities)
        require("lsp-keybindings").codeaction(bufnr)
        keybindings_rename_check(bufnr, server_capabilities)
        keybindings_organizeimports(bufnr, lsp_name)

        vim.api.nvim_create_user_command(
            "LspWhatCapabilities",
            "Capture call v:lua.show_capabilities()",
            {}
        )
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = lsp_callback,
})

local map = function(keys, action_desc)
    vim.keymap.set("n", keys, function()
        vim.notify(
            "Don't know how to " .. action_desc .. " this filetype.",
            vim.log.levels.ERROR
        )
    end, { desc = DISABLED_DESC, unique = true })
end

map("gQ", "document format")
