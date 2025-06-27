return {
  {
    "daneofmanythings/chalktone.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("chalktone").setup({})
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({})
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
}