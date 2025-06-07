return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },
}
