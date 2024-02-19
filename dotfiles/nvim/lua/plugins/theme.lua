-- if true then return {} end

return -- Lazy
{
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  opts = function()
    return {}
  end,
}