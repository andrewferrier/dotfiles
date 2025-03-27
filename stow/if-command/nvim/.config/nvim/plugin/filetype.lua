vim.filetype.add({
    extension = {
        equivs = "debcontrol",
        jad = "java",
        tf = "terraform", -- I never use 'tinyfugue': https://www.reddit.com/r/neovim/comments/18xg9na/comment/kg54fy7/
        tfstate = "json",
    },
    filename = {
        [".ansible-lint"] = "yaml",
        [".sqlfluff"] = "cfg",
        ["control_template"] = "debcontrol",
        ["shellcheckrc"] = "conf",

        -- Doesn't have to be JSON, but I try to standardize on it.
        -- See https://github.com/igorshubovych/markdownlint-cli?tab=readme-ov-file#configuration
        [".markdownlintrc"] = "jsonc",
    },
    pattern = {
        ["%.secrets.*"] = "sh",
        [".*/%.config/git%-local/.*"] = "gitconfig",
        [".*/%.config/lf%-local/.*"] = "conf",
        [".*/%.config/i3/.*"] = "i3config",
        [".*/%.kaf/config"] = "yaml",
        [".*/i3/config%.d/.*"] = "i3config",
        [".*Dockerfile.*"] = "dockerfile",
        [".*Jenkinsfile.*"] = "groovy",
        [".*emails/cur/.*"] = "mail",
        [".*emails/new/.*"] = "mail",
        [".*emails/tmp/.*"] = "mail",
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
