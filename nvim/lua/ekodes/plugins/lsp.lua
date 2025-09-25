return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "cssls",
        "html",
        "emmet_language_server",
        "jsonls",
        "lua_ls",
        "omnisharp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Minimal setups for each server
      lspconfig.ts_ls.setup({})
      lspconfig.cssls.setup({})
      lspconfig.html.setup({})
      lspconfig.emmet_language_server.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.lua_ls.setup({})

      lspconfig.omnisharp.setup({
        cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp" },
      })
    end,
  },
}
