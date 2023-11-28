return {
    -- Nightfly
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.g.nightflyCursorColor = true
            vim.g.nightflyItalics = false
            vim.g.nightflyNormalFloat = true
            vim.g.nightflyTerminalColors = false
            vim.g.nightflyUndercurls = false
            vim.g.nightflyUnderlineMatchParen = true
            vim.g.nightflyWinSeparator = 2
            vim.opt.fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }
            local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "nightfly",
                callback = function()
                    vim.api.nvim_set_hl(0, "Function", { fg = "#82aaff", bold = true })
                end,
                group = custom_highlight,
            })
        end
    },
    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        },
    },

    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },

    -- Tokionight
    {
        "folke/tokyonight.nvim",
        opts = { style = "night" },
    },
}
