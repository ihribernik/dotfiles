local spec = {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    bold_keywords = true,
    italic_comments = true,
    bright_border = true,
    reduced_blue = true,
    telescope = {
      style = "flat",
    },
    noice = {
      style = "classic",
    },
    leap = {
      dim_backdrop = true,
    },
    cursorline = {
      bold = false,
      bold_number = true,
      theme = "dark",
      blend = 0.85,
    },

    visual = {
      bold = false,
      bold_number = true,
      theme = "dark",
      blend = 0.85,
    },

    on_highlight = function(highlights, palette)
      highlights.WhichKeyBorder = {
        fg = palette.gray3,
        bg = palette.black0,
      }

      highlights.WhichKeyNormal = {
        bg = palette.black0,
      }
    end,
  },
}
return spec
