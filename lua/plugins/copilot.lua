return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = true },
            panel = { enabled = true },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            local Util = require("lazyvim.util")
            local colors = {
            [""] = Util.fg("Special"),
            ["Normal"] = Util.fg("Special"),
            ["Warning"] = Util.fg("DiagnosticError"),
            ["InProgress"] = Util.fg("DiagnosticWarn"),
            }
            table.insert(opts.sections.lualine_x, 2, {
            function()
                local icon = require("lazyvim.config").icons.kinds.Copilot
                local status = require("copilot.api").status.data
                return icon .. (status.message or "")
            end,
            cond = function()
                local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
                return ok and #clients > 0
            end,
            color = function()
                local status = require("copilot.api").status.data
                return colors[status.status] or colors[""]
            end,
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            -- attach cmp source whenever copilot attaches
            -- fixes lazy-loading issues with the copilot cmp source
            require("lazyvim.util").on_attach(function(client)
            if client.name == "copilot" then
                copilot_cmp._on_insert_enter({})
            end
            end)
        end,
    }
}