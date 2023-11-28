return {
    "neovim/nvim-lspconfig",
    cmd = { 'LspInfo', 'LspInstall', 'LspUnInstall' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
        { "folke/neodev.nvim", opts = {} },
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("neodev").setup()
        require("plugins.lsp.config")
    end,
}
