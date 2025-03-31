return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader>sB",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = vim.fn.getcwd(),
          select_buffer = true,
        })
      end,
      desc = "Browse Files",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
