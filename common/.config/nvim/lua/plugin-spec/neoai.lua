return {
    "Bryley/neoai.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    cmd = {
        "NeoAI",
        "NeoAIOpen",
        "NeoAIClose",
        "NeoAIToggle",
        "NeoAIContext",
        "NeoAIContextOpen",
        "NeoAIContextClose",
        "NeoAIInject",
        "NeoAIInjectCode",
        "NeoAIInjectContext",
        "NeoAIInjectContextCode",
    },
    keys = {
        { "gyhs", desc = "Summarize text" },
    },
    config = function()
        require("neoai").setup({
            ui = {
                width = 50,
            },
            shortcuts = {
                {
                    key = "gyhs",
                    use_context = true,
                    prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
                    modes = { "v" },
                    strip_function = nil,
                },
            },
        })
    end,
}
