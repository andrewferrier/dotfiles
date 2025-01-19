local M = {}

M.inspect_client = function()
    -- Based on https://www.reddit.com/r/neovim/comments/1gf7kyn/lsp_configuration_debugging/
    local lines = {}

    for i, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if i > 1 then
            table.insert(lines, "")
            table.insert(lines, string.rep("-", 80))
            table.insert(lines, "")
        end

        table.insert(lines, "Client: " .. client.name)
        table.insert(lines, "ID: " .. client.id)
        table.insert(lines, "")

        table.insert(lines, "Configuration:")
        local config_lines = vim.split(vim.inspect(client.config), "\n")
        vim.list_extend(lines, config_lines)

        table.insert(lines, "")
        table.insert(lines, "Server Capabilities:")
        table.insert(lines, "")
        local server_capabilities_lines =
            vim.split(vim.inspect(client.server_capabilities), "\n")
        vim.list_extend(lines, server_capabilities_lines)
    end

    require("utils").show_in_split_window(lines)
end

return M
