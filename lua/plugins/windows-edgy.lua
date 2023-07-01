return {
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "BufWinEnter",
    keys = {
      -- close window
      ["q"] = function(win)
        win:close()
      end,
      -- hide window
      ["<c-q>"] = function(win)
        win:hide()
      end,
      -- close sidebar
      ["Q"] = function(win)
        win.view.edgebar:close()
      end,
      -- next open window
      ["]w"] = function(win)
        win:next({ visible = true, focus = true })
      end,
      -- previous open window
      ["[w"] = function(win)
        win:prev({ visible = true, focus = true })
      end,
      -- next loaded window
      ["]W"] = function(win)
        win:next({ pinned = false, focus = true })
      end,
      -- prev loaded window
      ["[W"] = function(win)
        win:prev({ pinned = false, focus = true })
      end,
    },
    opts = {
      bottom = {
        { ft = "toggleterm", size = { height = 0.2 } },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- don't open help files in edgy that we're editing
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.6, width = 0.2 },
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
          size = { height = 0.2 },
        },
        {
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutline",
          size = { height = 0.2 },
        },
        "neo-tree",
      },
    },
  },
}
