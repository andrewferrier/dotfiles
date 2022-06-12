-- Do NOT run setup, otherwise it creates default keybindings
-- require("textcase").setup({})

local mapping = {}
mapping["_"] = "to_snake_case"
mapping["-"] = "to_dash_case"
mapping["C"] = "to_constant_case"
mapping["."] = "to_dot_case"
mapping["c"] = "to_camel_case"
mapping["t"] = "to_title_case"
mapping["/"] = "to_path_case"
mapping["s"] = "to_phrase_case" -- sentence
mapping["m"] = "to_pascal_case" -- mixed case

for map, target in pairs(mapping) do
    vim.keymap.set("n", "gyc" .. map, function()
        require("textcase").operator(target)
    end)
end
