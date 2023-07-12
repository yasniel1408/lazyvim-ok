return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = true,
        ignore = "^$",
        pre_hook = function()
          return require("ts_context_commentstring.internal").calculate_commentstring()
        end,
      })
    end,
  },
}

-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment
