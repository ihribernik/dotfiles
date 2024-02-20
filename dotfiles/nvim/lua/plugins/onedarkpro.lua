-- if true then return {} end

return -- Lazy
{
  "olimorris/onedarkpro.nvim",
  lazy = true,
  priority = 1000, -- Ensure it loads first
  opts = {
    options = {
      transparency = true,
      terminal_colors = true,
    },
  },
  config = true,
}
