return {
  --gruvbox-material
  -- {
  --   "sainnhe/gruvbox-material",
  --   enabled = true,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_transparent_background = 1
  --     vim.g.gruvbox_material_foreground = "original" -- mix, material, original
  --     vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
  --     vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
  --     vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows (dim, bright)
  --     vim.g.gruvbox_material_diagnostic_line_highlight = 1
  --     vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
  --
  --     vim.g.gruvbox_material_better_performance = 1
  --
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = {
          bold = true,
          italic = true,
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "gruvbox",
  --   },
  -- }

  -- nordic
  -- {
  --   "AlexvZyl/nordic.nvim",
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "nordic",
  --     transparent = true,
  --   },
  -- },

  -- gruvbox-flat
  -- { 'eddyekofo94/gruvbox-flat.nvim', },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = 'gruvbox-flat',
  --   },
  -- }

  -- fancy
  -- {
  --   'nyngwang/nvimgelion',
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "nvimgelion"
  --   },
  -- }
}
