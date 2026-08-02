local sql_filetypes = { "sql", "mysql", "plsql" }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "sql" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "sqlfluff" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      for _, filetype in ipairs(sql_filetypes) do
        opts.linters_by_ft[filetype] = { "sqlfluff" }
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}
      opts.formatters.sqlfluff = {
        args = { "format", "--dialect=postgres", "-" },
      }
      for _, filetype in ipairs(sql_filetypes) do
        opts.formatters_by_ft[filetype] = { "sqlfluff" }
      end
    end,
  },
}
