return {
    {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
        servers = {
        ---Typescript
        tsserver = {
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        -- ESLint
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = "auto" },
          },
        },
      },
        setup = {
        eslint = function()
            require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
                client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
                client.server_capabilities.documentFormattingProvider = false
            end
            end)
        end,
        },
    },
    }
}