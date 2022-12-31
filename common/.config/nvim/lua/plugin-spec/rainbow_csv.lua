return {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
    config = function()
        -- This is required to prevent conflicts with dirbuf
        vim.g.disable_rainbow_csv_autodetect = 1
    end,
}
