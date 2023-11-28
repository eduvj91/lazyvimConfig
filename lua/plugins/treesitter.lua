return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "tsx",
                "typescript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "c",
                "diff",
                "python",
                "query",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = { enable = true,},
            indent = { enable = true, },
            autoag = { enable = true, },


            -- treesitter options
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },

            },
            -- textobjects options
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
                    },
                },
            },
        },

    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
            mode = "cursor",  -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = '-',
        },
    },

    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        opts = {},
    },
}

