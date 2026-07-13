return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "lua-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "tailwindcss-language-server",
        "emmet-language-server",
        "ruby-lsp",
        "omnisharp",

        -- Formatters / Linters
        "stylua",
        "shfmt",
        "rubocop",
      },
    },
  },
}
