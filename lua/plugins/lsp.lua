return {
    -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
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
        eslint = {
            settings = {
                -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                workingDirectory = { mode = "auto" },
            },
        },
        tailwindcss = {},
        jsonls = {
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
                json = {
                    format = {
                    enable = true,
                    },
                    validate = { enable = true },
                },
            },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
            tsserver = function(_, opts)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    callback = function(event)
                    if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
                        vim.cmd("EslintFixAll")
                    end
                    end,
                })
                require("lazyvim.util").on_attach(function(client, buffer)
                    if client.name == "tsserver" then
                    -- stylua: ignore
                    vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
                    -- stylua: ignore
                    vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
                    end
                end)
                require("typescript").setup({ server = opts })
                return true
            end,
        },
    },
  },
}