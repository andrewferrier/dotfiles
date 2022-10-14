vim.filetype.add({
    extension = {
        equivs = "debcontrol",
        gitlint = "toml",
        jad = "java",
        rasi = "rasi",
        tex = "latex", -- We always want LaTeX, avoid slow detection logic
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
        [".*/%.kaf/config"] = "yaml",
        [".*Dockerfile.*"] = "dockerfile",
        [".*Jenkinsfile.*"] = "groovy",
        [".*envrc.*"] = "sh",
        [".*mkd%.txt"] = "markdown",
        [".*my%-ublock.*"] = "json",
        ["muttrc%..*"] = "muttrc",
    },
})
