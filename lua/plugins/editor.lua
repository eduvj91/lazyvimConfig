---@diagnostic disable: cast-local-type, param-type-mismatch
return {
    -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
            {
                's1n7ax/nvim-window-picker',
                version = '2.*',
                config = function()
                    require 'window-picker'.setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                    })
                end,
            },
        },
        keys = {
            {
                "-", function()
                    local reveal_file = vim.fn.expand('%:p')
                    if (reveal_file == '') then
                        reveal_file = vim.fn.getcwd()
                    else
                        local f = io.open(reveal_file, "r")
                        if (f) then
                            f.close(f)
                        else
                            reveal_file = vim.fn.getcwd()
                        end
                    end
                    require("neo-tree.command").execute({
                        toggle = true,
                        reveal_file = reveal_file,
                    })
                end,
                desc = "Explorer NeoTree (root dir)",
                mode = "n",
            },
        },
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
            default_component_configs = {
                icon = {
                    -- folder_closed = "",
                    -- folder_open = "",
                    folder_empty = "",
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
            },
            open_files_in_last_window = true, -- move cursor correctly on close.
            enable_git_status = true,
            filesystem = {
                bind_to_cwd = false,
                use_libuv_file_watcher = true,
                follow_current_file = { enabled = true },
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
        },
    },

    -- search/replace in multiple files
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },

    -- Fuzzy finder.
    -- The default key bindings to find files will use Telescope's
    -- `find_files` or `git_files` depending on whether the
    -- directory is a git repo.
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            {
                "<leader>,",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Switch Buffer",
            },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
            --vim.
            { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
            -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
            -- { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
            -- { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            -- { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
            -- git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
            -- search
            { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
            -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
            -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
            -- { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
            -- { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
            -- { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
            -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
            -- { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
        },
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-file-browser.nvim",
                keys = {
                    {
                        "<leader>sB",
                        ":Telescope file_browser path=%:p:h<cr>",
                        desc = "Browser File",
                    }
                }
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
            },
        },
        config = function ()
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("fzf")
            require("plugins.telescope.setup")
            require("plugins.telescope.mappings")
        end
    },
}
