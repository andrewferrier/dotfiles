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
                    key = nil,
                    desc = "Improve natural text",
                    name = 'ImproveNaturalText',
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
                    key = nil,
                    desc = "Improve code",
                    name = 'ImproveCode',
                    use_context = false,
                    prompt = [[
                Refactor this code to make it more readable and maintainable,
                ensuring that best practices are used wherever practical.
            ]]
                        .. require("utils").visual_selection_range(),
                    modes = { "v" },
                    strip_function = nil,
                },
            },
        })
    end,
}
