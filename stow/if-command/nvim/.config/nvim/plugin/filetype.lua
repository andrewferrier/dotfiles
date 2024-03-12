vim.filetype.add({
    extension = {
        equivs = "debcontrol",
        jad = "java",
        rasi = "rasi",
        tf = "terraform", -- I never use 'tinyfugue': https://www.reddit.com/r/neovim/comments/18xg9na/comment/kg54fy7/
        tfstate = "json",
        wat = "wast", -- This is needed for now as a workaround because NeoVim doesn't natively support .wat files
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
        [".*/%.config/git%-local/.*"] = "gitconfig",
        [".*/%.i3/config%.d/.*"] = "i3config",
        [".*/%.kaf/config"] = "yaml",
        [".*/i3/config%.d/.*"] = "i3config",
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

if vim.fn.has("nvim-0.10.0") == 0 then
    vim.filetype.add({
        extension = {
            hurl = "hurl",
        },
    })
end
