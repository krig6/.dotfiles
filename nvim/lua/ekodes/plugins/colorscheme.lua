return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenwritten = {
        darkness = "stark",
        italic_comments = false,
        italic_strings = false,
        lighten_comments = 22,
        lighten_cursor_line = 10,
      }
      vim.cmd.colorscheme("zenwritten")
    end,
  },
}
