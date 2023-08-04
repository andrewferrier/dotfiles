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

local function keybindings_codeaction_check(bufnr, server_capabilities)
    if server_capabilities.codeActionProvider then
        require("lsp-keybindings").codeaction(bufnr)
    end
end

local function keybindings_rename_check(bufnr, server_capabilities)
    if server_capabilities.renameProvider then
        keybindings_rename(bufnr)
    end
end

local function keybindings_hover_keyword(bufnr, server_capabilities, filetype)
    -- FIXME: Once 0.10 out, switch this to exploit the default setting of 'K'
    -- to hover()

    if filetype == "lua" then
        vim.bo.keywordprg = ":help"
    elseif filetype == "terraform" then
        -- Don't map "K"; this is handled in
        -- ~/.config/nvim/after/ftplugin/terraform.lua
    elseif server_capabilities.hoverProvider then
        if filetype ~= "vim" then
            vim.keymap.set(
                "n",
                "K",
                vim.lsp.buf.hover,
                { buffer = bufnr, desc = "Show definition using LSP" }
            )
        end
    else
        vim.keymap.set("n", "K", function()
            vim.notify("Hover not supported by LSP.", vim.log.levels.ERROR)
        end, { buffer = bufnr, desc = DISABLED_DESC })
    end
end

local function keybindings_organizeimports(bufnr, lsp_name)
    local DESC = "Organize imports"

    if lsp_name == "tsserver" then
        vim.keymap.set("n", "cxo", function()
            require("typescript").actions.organizeImports()
        end, { buffer = bufnr, desc = DESC })
    elseif lsp_name == "pyright" then
        vim.keymap.set("n", "cxo", function()
            vim.cmd("silent! PyrightOrganizeImports")
        end, { buffer = bufnr, desc = DESC })
    end
end

local function lsp_callback(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    local lsp_name = client.name
    local server_capabilities = client.server_capabilities
    local filetype = vim.bo.filetype

    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

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
    end, { desc = DISABLED_DESC })
end

map("cxo", "organize imports for")
map("cxa", "apply code actions for")
map("gQ", "document format")
