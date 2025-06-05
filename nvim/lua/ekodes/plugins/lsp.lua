return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "cssls",
        "html",
        "emmet_language_server",
        "jsonls",
        "lua_ls",
        "jsonls",
        "omnisharp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup_handlers({
        -- Default handler for all servers not listed below
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = function(client, bufnr)
              print(server_name .. " attached")

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end,
          })
        end,

        -- Custom setup for omnisharp
        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/OmniSharp" },
            on_attach = function(client, bufnr)
              print("omnisharp attached")

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end,
          })
        end,
      })
    end,
  },
}
