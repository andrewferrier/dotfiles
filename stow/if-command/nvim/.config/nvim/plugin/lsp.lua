function _G.show_capabilities()
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        print(
            vim.inspect(client.name)
                .. "\n\n"
                .. vim.inspect(client.server_capabilities)
                .. "\n\n"
        )
    end
end

function _G.inspect_lsp_client()
    -- Based on https://www.reddit.com/r/neovim/comments/1gf7kyn/lsp_configuration_debugging/
    vim.ui.input({ prompt = "Enter LSP Client name: " }, function(client_name)
        if client_name then
            local client = vim.lsp.get_clients({ name = client_name })

            if #client == 0 then
                vim.notify(
                    "No active LSP clients found with this name: "
                        .. client_name,
                    vim.log.levels.WARN
                )
                return
            end

            -- Create a temporary buffer to show the configuration
            local buf = vim.api.nvim_create_buf(false, true)
            local win = vim.api.nvim_open_win(buf, true, {
                relative = "editor",
                width = math.floor(vim.o.columns * 0.75),
                height = math.floor(vim.o.lines * 0.90),
                col = math.floor(vim.o.columns * 0.125),
                row = math.floor(vim.o.lines * 0.05),
                style = "minimal",
                border = "rounded",
                title = " "
                    .. (client_name:gsub("^%l", string.upper))
                    .. ": LSP Configuration ",
                title_pos = "center",
            })

            local lines = {}
            for i, this_client in ipairs(client) do
                if i > 1 then
                    table.insert(lines, string.rep("-", 80))
                end
                table.insert(lines, "Client: " .. this_client.name)
                table.insert(lines, "ID: " .. this_client.id)
                table.insert(lines, "")
                table.insert(lines, "Configuration:")

                local config_lines =
                    vim.split(vim.inspect(this_client.config), "\n")
                vim.list_extend(lines, config_lines)
            end

            -- Set the lines in the buffer
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

            -- Set buffer options
            vim.bo[buf].modifiable = false
            vim.bo[buf].filetype = "lua"
            vim.bo[buf].bh = "delete"

            vim.api.nvim_buf_set_keymap(
                buf,
                "n",
                "q",
                ":q<CR>",
                { noremap = true, silent = true }
            )
        end
    end)
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
            { "n", "x" },
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

vim.api.nvim_create_user_command(
    "LspInspectClient",
    "call v:lua.inspect_lsp_client()",
    {}
)
