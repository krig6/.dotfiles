return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install", -- Use npm to install dependencies
    init = function()
      vim.g.mkdp_filetypes = { "markdown" } -- Enable the plugin for markdown files
    end,
    ft = { "markdown" }, -- Load plugin only for markdown files
  },
}
