return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function()
      vim.fn.system({ "npm", "install" }, { cwd = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app" })
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", mode = "n", desc = "Toggle markdown preview" },
    },
  },
}
