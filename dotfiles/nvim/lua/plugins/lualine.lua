local spec = {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    local palette = require("nordic.colors")
    opts.options.theme = {
      normal = {
        a = { fg = palette.black0, bg = palette.blue2, gui = "bold" },
        b = { fg = palette.white0, bg = palette.gray1 },
        c = { fg = palette.white0, bg = palette.black0 },
      },
      insert = {
        a = { fg = palette.black0, bg = palette.green.base, gui = "bold" },
        b = { fg = palette.white0, bg = palette.gray1 },
        c = { fg = palette.white0, bg = palette.black0 },
      },
      visual = {
        a = { fg = palette.black0, bg = palette.magenta.base, gui = "bold" },
        b = { fg = palette.white0, bg = palette.gray1 },
        c = { fg = palette.white0, bg = palette.black0 },
      },
      replace = {
        a = { fg = palette.black0, bg = palette.red.base, gui = "bold" },
        b = { fg = palette.white0, bg = palette.gray1 },
        c = { fg = palette.white0, bg = palette.black0 },
      },
      command = {
        a = { fg = palette.black0, bg = palette.yellow.base, gui = "bold" },
        b = { fg = palette.white0, bg = palette.gray1 },
        c = { fg = palette.white0, bg = palette.black0 },
      },
      inactive = {
        a = { fg = palette.gray3, bg = palette.black0 },
        b = { fg = palette.gray3, bg = palette.black0 },
        c = { fg = palette.gray3, bg = palette.black0 },
      },
    }
    opts.options.section_separators = ""
    opts.options.component_separators = "|"
  end,
}

return spec
