return {
    "Bryley/neoai.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = {
        "NeoAI",
        "NeoAIClose",
        "NeoAIContext",
        "NeoAIContextClose",
        "NeoAIContextOpen",
        "NeoAIInject",
        "NeoAIInjectCode",
        "NeoAIInjectContext",
        "NeoAIInjectContextCode",
        "NeoAIOpen",
        "NeoAIShortcut",
        "NeoAIToggle",
    },
    opts = {
        ui = {
            width = 50,
        },
        shortcuts = {
            {
                key = nil,
                desc = "Improve natural text",
                name = "ImproveNaturalText",
                use_context = false,
                prompt = function()
                    return [[
                Rewrite the following text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors:
            ]] .. require("utils").visual_selection_range()
                end,
                modes = { "v" },
                strip_function = nil,
            },
            {
                key = nil,
                desc = "Improve code",
                name = "ImproveCode",
                use_context = false,
                prompt = function()
                    return [[
                Refactor this code to make it more readable and maintainable,
                ensuring that best practices are used wherever practical.
            ]] .. require("utils").visual_selection_range()
                end,
                modes = { "v" },
                strip_function = nil,
            },
        },
    },
    enabled = function()
        if vim.env.OPENAI_API_KEY then
            return true
        else
            vim.notify(
                "$OPENAI_API_KEY not set; neoai.lua not loaded.",
                vim.log.levels.WARN
            )
            return false
        end
    end,
}
