return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-jest" },
  { "nvim-neotest/neotest-python" },
  { "nvim-neotest/neotest-go" },
  { "markemmons/neotest-deno" },
  { "nvim-neotest/neotest-vim-test" },
  { "neotest-vim-test" },
  { "vim-test/vim-test" },
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "neotest-vim-test",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          args = { "--coverage" },
        },
        ["neotest-plenary"] = {},
        ["neotest-python"] = {},
        ["neotest-deno"] = {},
        ["neotest-go"] = {
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
        },
        ["neotest-vim-test"] = {
          ignore_filetypes = { "jest", "python", "go" },
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if require("lazyvim.util").has("trouble.nvim") then
            vim.cmd("Trouble quickfix")
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    benchmark = {
      enabled = true,
    },
    consumers = {},
    default_strategy = "integrated",
    diagnostic = {
      enabled = true,
      severity = 1,
    },
    discovery = {
      concurrent = 0,
      enabled = true,
    },
    floating = {
      border = "rounded",
      max_height = 0.6,
      max_width = 0.6,
      options = {},
    },
    highlights = {
      adapter_name = "NeotestAdapterName",
      border = "NeotestBorder",
      dir = "NeotestDir",
      expand_marker = "NeotestExpandMarker",
      failed = "NeotestFailed",
      file = "NeotestFile",
      focused = "NeotestFocused",
      indent = "NeotestIndent",
      marked = "NeotestMarked",
      namespace = "NeotestNamespace",
      passed = "NeotestPassed",
      running = "NeotestRunning",
      select_win = "NeotestWinSelect",
      skipped = "NeotestSkipped",
      target = "NeotestTarget",
      test = "NeotestTest",
      unknown = "NeotestUnknown",
    },
    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = "",
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      passed = "",
      running = "",
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      skipped = "",
      unknown = "",
    },
    jump = {
      enabled = true,
    },
    log_level = 3,
    output = {
      enabled = true,
      open_on_run = "short",
    },
    output_panel = {
      enabled = true,
      open = "botright split | resize 15",
    },
    projects = {},
    quickfix = {
      enabled = true,
      open = true,
    },
    run = {
      enabled = true,
    },
    running = {
      concurrent = true,
    },
    state = {
      enabled = true,
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = false,
    },
    strategies = {
      integrated = {
        height = 40,
        width = 120,
      },
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        jumpto = "i",
        mark = "m",
        next_failed = "J",
        output = "o",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        short = "O",
        stop = "u",
        target = "t",
      },
      open = "botright vsplit | vertical resize 50",
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  -- stylua: ignore
  keys = {
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
  -- stylua: ignore
  keys = {
    { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
  },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
      },
    },
  },
}
