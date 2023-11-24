return { -- https://github.com/rest-nvim/rest.nvim
  {
    "rest-nvim/rest.nvim",
    requires = { "yanick/nvim-jq", "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_curl_command = true,
          show_url = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              if vim.fn.executable("tidy") == 0 then
                return body
              end
        -- stylua: ignore
        return vim.fn.system({
          "tidy", "-i", "-q",
          "--tidy-mark",      "no",
          "--show-body-only", "auto",
          "--show-errors",    "0",
          "--show-warnings",  "0",
          "-",
        }, body):gsub("\n$", "")
            end,
          },
        }, -- Jump to request line on run
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end,
  },
}
