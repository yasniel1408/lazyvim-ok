-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("symbols-outline").setup()
require("toggleterm").setup()
require("config.options")
require("config.lazy")

if vim.fn.argc(-1) == 0 then
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("NeovimPDE", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      require("config.autocmds")
      require("config.keymaps")
    end,
  })
else
  require("config.autocmds")
  require("config.keymaps")
end

require("rest-nvim").setup()
require("colorizer").setup()
require("ccc").setup()
require("smoothcursor").setup()
