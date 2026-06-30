return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- disable the preset
      },
      views = {
        hover = {
          border = {
            style = "rounded",
          },
        },
      },
    },
  },
}
