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
        { "gyhs", desc = "Summarize text", mode = "v" },
        { "gyhr", desc = "Refactor code", mode = "v" },
    },
    config = function()
        require("neoai").setup({
            ui = {
                width = 50,
            },
            shortcuts = {
                {
                    key = "gyhs",
                    desc = "Improve natural text",
                    use_context = true,
                    prompt = [[
                Rewrite the following text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors:
            ]]
                        .. require("utils").visual_selection_range(),
                    modes = { "v" },
                    strip_function = nil,
                },
                {
                    key = "gyhr",
                    desc = "Improve code",
                    use_context = false,
                    prompt = [[
                Refactor this code to make it more readable and maintainable,
                also making it more concise where possible:
            ]]
                        .. require("utils").visual_selection_range(),
                    modes = { "v" },
                    strip_function = nil,
                },
            },
        })
    end,
}
