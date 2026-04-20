vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

for _, lsp in ipairs({
    "ansiblels",
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "jsonls",
    "lemminx",
    "lua_ls",
    "ruff",
    "rust_analyzer",
    "taplo",
    "texlab",
    "tofu_ls",
    "ts_ls",
    "ty",
    "vimls",
    "yamlls",
}) do
    vim.lsp.enable(lsp)
end

vim.lsp.on_type_formatting.enable()
vim.lsp.inlay_hint.enable()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local bufnr = event.buf

        vim.keymap.set("n", "yoi", function()
            vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
            )
        end, { buffer = bufnr, desc = "Toggle inlay hints" })
    end,
})
