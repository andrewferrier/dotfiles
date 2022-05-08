-- luacheck: globals vim

vim.filetype.add({
    extension = {
        ant = "ant",
        equivs = "debcontrol",
        gitlint = "toml",
        jad = "java",
        rasi = "rasi",
    },
    filename = {
        [".dockerignore"] = "gitignore",
        [".sqlfluff"] = "cfg",
        [".gitlint"] = "toml",
        ["control_template"] = "debcontrol",
    },
    pattern = {
        ["%.secrets.*"] = "sh",
        [".*%.gitignore.*"] = "gitignore",
        [".*%.properties.*"] = "jproperties",
        [".*/%.config/kitty/.*%.conf"] = "conf",
        [".*/%.config/systemd/user/.*"] = "systemd",
        [".*/%.kaf/config"] = "yaml",
        [".*/hugo/layouts/.*%.html"] = "gohtmltmpl",
        [".*Dockerfile.*"] = "dockerfile",
        [".*Jenkinsfile.*"] = "groovy",
        [".*envrc.*"] = "sh",
        [".*mkd%.txt"] = "markdown",
        [".*my%-ublock.*"] = "json",

        [".*/pack/packer/.*%.md"] = function()
            require("readonly").make_readonly()
            return "markdown"
        end,
    },
})
