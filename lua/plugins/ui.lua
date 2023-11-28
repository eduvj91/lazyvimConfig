return {
    -- ICONS
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            override_by_filename = {
                ["babel.config.js"] = {
                    icon = "󰨥",
                    color = "#ebd558",
                    name = "Babel"
                },
            },
            override_by_extension = {
                ["exe"] = {
                    icon = "󰇺",
                    color = "#81e043",
                    name = "Exe"
                }
            }
        }
    }
}
