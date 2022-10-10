local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

vim.cmd("packadd packer.nvim")
local packer = require("packer")

packer.init({
    compile_path = vim.fn.stdpath("data")
        .. "/site/pack/packer_generated/start"
        .. "/packer_generated/plugin/packager_compiled.lua",
    disable_commands = true,
    -- profile = {
    --     enable = true,
    --     threshold = 0,
    -- },
})

local function install_treesitter_parsers()
    local treesitter_install = require("nvim-treesitter.install")

    local number_of_parsers_installed =
        #require("nvim-treesitter.info").installed_parsers()

    if number_of_parsers_installed < 10 then
        -- This is probably a fresh install or reinstall
        treesitter_install.ensure_installed("all")
    else
        treesitter_install.ensure_installed_sync("all")
        treesitter_install.update()
    end
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

    use({
        "kylechui/nvim-surround",
        tag = "*", -- stable
        config = function()
            require("plugins.surround")
        end,
    })
end

local function packages_commands(use)
    use({ "tpope/vim-eunuch" })

    -- Eventually this can be replaced with
    -- https://github.com/neovim/neovim/issues/5054
    use({ "tyru/capture.vim" })

    use({
        "chentoast/marks.nvim",
        config = function()
            require("plugins.marks")
        end,
    })

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
            require("tint").setup({})
        end,
        cond = function()
            return vim.fn.has("nvim-0.8.0") == 1
        end,
        requires = { "ellisonleao/gruvbox.nvim" },
    })
end

local function packages_git(use)
    use({ "whiteinge/diffconflicts", opt = true }) -- invoked by `git mergetool`
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
        opt = true,
        config = function()
            require("plugins.markdown_preview")
        end,
    })

    use({ "jkramer/vim-checkbox", ft = "markdown" })
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

    -- FIXME: event = "LspAttach" can be added to inc-rename and fidget once 0.7
    -- fully removed
    use({
        "smjonas/inc-rename.nvim",
        config = function()
            require("plugins.inc_rename")
        end,
        cond = function()
            return vim.fn.has("nvim-0.8.0") == 1
        end,
    })

    use({
        "j-hui/fidget.nvim",
        config = function()
            require("plugins.fidget")
        end,
    })
end

local function packages_misc(use)
    use({
        "echasnovski/mini.nvim",
        config = function()
            require("plugins.mini")
        end,
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
            require("plugins.textobj_diagnostic")
        end,
    })

    use({
        "git@github.com:andrewferrier/debugprint.nvim",
        config = function()
            require("plugins.debugprint")
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
