return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  cmd = "VenvSelect",
  -- branch = "regexp", -- This is the regexp branch, use this for the new version
  opts = function(_, opts)
    if require("lazyvim.util").has("nvim-dap-python") then
      opts.dap_enabled = true
    end
    return vim.tbl_deep_extend("force", opts, {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    })
  end,
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
}