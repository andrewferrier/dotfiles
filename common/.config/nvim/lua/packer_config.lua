local install_path = vim.fn.stdpath("data") .. "/site/pack"
local packer_path = install_path .. "/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        packer_path,
    })
end

vim.cmd.packadd("packer.nvim")
local packer = require("packer")

packer.init({
    compile_path = install_path
        .. "/packer_generated/start"
        .. "/packer_generated/plugin/packager_compiled.lua",
    disable_commands = true,
    -- profile = {
    --     enable = true,
    --     threshold = 0,
    -- },
})

local function install_treesitter_parsers()
    -- Neither of these are sync, but that shouldn't matter as there is no
    -- intersection in the parsers they will touch
    vim.cmd.TSUpdate()
    -- In practice TSInstall may not install new parsers until after NeoVim is
    -- restarted. I don't consider that a major problem, just means we might lag
    -- behind a bit.
    vim.cmd.TSInstall("all")
end

local function packages_operators(use)
    use({ "christoomey/vim-sort-motion", keys = "gs" })

    use({
        "johmsalas/text-case.nvim",
        requires = { "anuvyklack/hydra.nvim" },
        config = function()
            require("plugins.text_case")
        end,
        keys = "gyc",
    })
end

local function packages_commands(use)
    use({ "tpope/vim-eunuch" })

    -- Eventually this can be replaced with
    -- https://github.com/neovim/neovim/issues/5054
    use({ "tyru/capture.vim" })

    use({
        "tpope/vim-unimpaired",
        requires = { "tpope/vim-repeat" },
    }) -- quite slow

    use({
        "ibhagwan/fzf-lua",
        config = function()
            require("plugins.fzf")
        end,
        keys = { "cv" },
    })

    use({
        "anuvyklack/hydra.nvim",
        config = function()
            require("plugins.hydra")
        end,
    })
end

local function packages_navigation(use)
    use({
        "elihunter173/dirbuf.nvim",
        config = function()
            require("plugins.dirbuf")
        end,
        -- Pinned because of this bug: https://github.com/elihunter173/dirbuf.nvim/issues/53
        commit = "e0044552",
    })
end

local function packages_silent(use)
    use({
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("plugins.gruvbox")
        end,
    })

    use({ "tpope/vim-sleuth" })

    use({
        "vladdoster/remember.nvim",
        config = function()
            require("remember")
        end,
    })

    use({
        "tversteeg/registers.nvim",
        config = function()
            require("plugins.registers")
        end,
    })

    use({
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("plugins.colorizer")
        end,
    })

    use({
        "levouh/tint.nvim",
        config = function()
            require("plugins.tint")
        end,
        after = { "gruvbox.nvim" },
    })
end

local function packages_git(use)
    use({ "will133/vim-dirdiff", cmd = "DirDiff" })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    }) -- gb
end

local function packages_syntax(use)
    use({ "qnighy/vim-ssh-annex" })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        config = function()
            require("plugins.markdown_preview")
        end,
        ft = "markdown",
    })

    use({ "jkramer/vim-checkbox", ft = "markdown" })

    use({
        "lervag/vimtex",
        config = function()
            require("plugins.vimtex")
        end,
    })

    use({ "mechatroner/rainbow_csv" })
end

local function packages_treesitter(use)
    use({ "RRethy/nvim-treesitter-endwise" })
    use({ "mfussenegger/nvim-treehopper" })
    use({ "nvim-treesitter/nvim-treesitter-refactor" })
    use({ "nvim-treesitter/playground", command = "TSPlaygroundToggle" })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = install_treesitter_parsers,
        config = function()
            require("plugins.treesitter")
        end,
    })

    use({ "Afourcat/treesitter-terraform-doc.nvim" })

    use({
        "cshuaimin/ssr.nvim",
        config = function()
            require("plugins.ssr")
        end,
    })
end

local function packages_lsp(use)
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    }) -- gyq, gQ, cx

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.null_ls")
        end,
    })

    use({
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({ cmd_name = "LspRename" })
        end,
        event = "LspAttach",
    })

    use({
        "j-hui/fidget.nvim",
        config = function()
            require("plugins.fidget")
        end,
        event = "LspAttach",
    })

    use({
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("plugins.inlayhints")
        end,
    })

    use({ "jose-elias-alvarez/typescript.nvim" })
end

local function packages_misc(use)
    use({
        "echasnovski/mini.nvim",
        config = function()
            require("plugins.mini")
        end,
        branch = "stable",
    })
end

local function packages_mine(use)
    use({
        "git@github.com:andrewferrier/wrapping.nvim",
        config = function()
            require("plugins.wrapping")
        end,
    })

    use({
        "git@github.com:andrewferrier/textobj-diagnostic.nvim",
        config = function()
            require("textobj-diagnostic").setup()
        end,
    })

    use({
        "git@github.com:andrewferrier/debugprint.nvim",
        config = function()
            require("debugprint").setup()
        end,
        requires = "nvim-treesitter/nvim-treesitter",
    })
end

packer.startup(function(use)
    use({ "wbthomason/packer.nvim", opt = true })

    packages_operators(use)
    packages_commands(use)
    packages_navigation(use)
    packages_git(use)
    packages_silent(use)
    packages_syntax(use)
    packages_treesitter(use)
    packages_lsp(use)
    packages_misc(use)
    packages_mine(use)
end)

return packer
