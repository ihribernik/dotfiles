local spec = {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        search_down = { view = "cmdline" },
        search_up = { view = "cmdline" },
      },
    },
  },
}

return spec
