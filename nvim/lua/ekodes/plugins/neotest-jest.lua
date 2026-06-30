return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "haydenmeade/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- Vitest
      table.insert(opts.adapters, require("neotest-vitest")({}))

      -- Jest
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
    config = function(_, opts)
      local neotest = require("neotest")
      neotest.setup(opts)

      -- Keymaps
      vim.keymap.set("n", "<leader>tt", function()
        neotest.run.run()
      end, { desc = "Run nearest test" })

      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run tests in file" })

      vim.keymap.set("n", "<leader>to", function()
        neotest.output.open()
      end, { desc = "Open test output" })

      vim.keymap.set("n", "<leader>tl", function()
        neotest.run.run_last()
      end, { desc = "Run last test" })

      vim.keymap.set("n", "<leader>ts", function()
        neotest.summary.toggle()
      end, { desc = "Toggle test summary" })
    end,
  },
}
