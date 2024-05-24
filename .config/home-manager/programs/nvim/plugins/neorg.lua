require("neorg").setup {
    load = {
        ["core.defaults"] = {},
        ["core.autocommands"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
        ["core.integrations.nvim-cmp"] = {},
        ["core.concealer"] = { config = { icon_preset = "basic" } },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                norg_leader = "<Leader><Leader>",
            },
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    Minecraft = "~/Minecraft/notes",
                    Conlangs = "~/Documents/conlang",
                }
            }
        },
    }
}

vim.wo.conceallevel = 2
vim.wo.foldlevel = 99

-- local neorg_callbacks = require("neorg.core.callbacks")
-- 
-- neorg_callbacks.on_event("core.keybinds.event.enable_keybinds", function(_, keybinds)
--     keybinds.map_event_to_mode("norg", {
--             n = {
--                 { "<C-s>", "core.integrations.telescope.find_linkable" },
--             },
-- 
--             i = {
--                 { "<C-l>", "core.integrations.telescope.insert_link" },
--             },
--         }, {
--             silent = true,
--             noremap = true,
--         })
-- end)
