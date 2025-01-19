---@param bufnr integer
local function keybindings_organizeimports(bufnr)
    vim.keymap.set("n", "gro", function()
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

        keybindings_organizeimports(bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        keybindings_inlayhints(bufnr)

        vim.keymap.set(
            { "n", "x" },
            "gra",
            require("fzf-lua").lsp_code_actions,
            { buffer = bufnr, desc = "Apply code action" }
        )
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = lsp_callback,
})

vim.api.nvim_create_user_command("LspInspectClient", function()
    require("lsp").inspect_client()
end, {})
