local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---@diagnostic disable: missing-fields
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

local M = {}

function M.setup()
    cmp.setup({

        completion = {
            completeopt = "menu,menuone,preview,noselect",
        },

        snippet = { -- configure how nvim-cmp interacts with snippet engine
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        mapping = cmp.mapping.preset.insert({
            ["<c-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<c-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = true }),

            -- SUPER TAB
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
                    cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- this way you will only jump inside the snippet region
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),

        -- sources for autocompletion
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- snippets
            { name = "buffer" }, -- text within current buffer
            { name = "path" }, -- file system paths
            { name = "emoji" },
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
            format = lspkind.cmp_format({
                maxwidth = 50,
                ellipsis_char = "...",
            }),
        },

    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' },   -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
                { name = 'buffer' },
            })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
                { name = 'cmdline' }
            })
    })

end

return M
