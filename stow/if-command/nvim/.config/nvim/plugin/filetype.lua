vim.filetype.add({
    extension = {
        equivs = "debcontrol",
        hurl = "hurl",
        jad = "java",
        rasi = "rasi",
        tfstate = "json",
    },
    filename = {
        [".ansible-lint"] = "yaml",
        [".dockerignore"] = "gitignore",
        [".gitlint"] = "cfg",
        [".sqlfluff"] = "cfg",
        ["control_template"] = "debcontrol",
        ["shellcheckrc"] = "conf",
    },
    pattern = {
        ["%.secrets.*"] = "sh",
        [".*%.gitignore.*"] = "gitignore",
        [".*%.properties.*"] = "jproperties",
        [".*/%.kaf/config"] = "yaml",
        [".*Dockerfile.*"] = "dockerfile",
        [".*Jenkinsfile.*"] = "groovy",
        [".*emails/cur/.*"] = "mail",
        [".*emails/new/.*"] = "mail",
        [".*emails/tmp/.*"] = "mail",
        [".*envrc.*"] = "sh",
        [".*mkd%.txt"] = "markdown",
        [".*my%-ublock.*"] = "json",
        ["muttrc%..*"] = "muttrc",

        -- Similar logic to pearofducks/ansible-vim
        [".*group_vars/.*"] = "yaml.ansible",
        [".*host_vars/.*"] = "yaml.ansible",

        [".*handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*roles/.*%.ya?ml"] = "yaml.ansible",
        [".*tasks/.*%.ya?ml"] = "yaml.ansible",

        [".*hosts.*.ya?ml"] = "yaml.ansible",
        [".*main.ya?ml"] = "yaml.ansible",
        [".*playbook.*.ya?ml"] = "yaml.ansible",
        [".*site.ya?ml"] = "yaml.ansible",
    },
})
