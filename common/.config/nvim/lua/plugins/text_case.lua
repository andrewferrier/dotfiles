-- Do NOT run setup, otherwise it creates default keybindings
-- require("textcase").setup({})

local hydra = require("hydra")

local head = function(key, operator_name, desc)
    return {
        key,
        function()
            require("textcase").operator(operator_name)
        end,
        { desc = desc },
    }
end

hydra({
    config = {
        exit = true,
    },
    name = "Change case",
    mode = "n",
    body = "gyc",
    heads = {
        head("_", "to_snake_case", "snake_case"),
        head("-", "to_dash_case", "dash-case"),
        head("C", "to_constant_case", "CONSTANT_CASE"),
        head(".", "to_dot_case", "dot.case"),
        head("c", "to_camel_case", "camelCase"),
        head("t", "to_title_case", "Title Case"),
        head("/", "to_path_case", "path/case"),
        head("s", "to_phrase_case", "Sentence case"),
        head("m", "to_pascal_case", "MixedCase"),

        { "<Esc>", nil, { exit = true } },
    },
})
