return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          bold = true,
          transparency = true,
          italic = false,
        },
        palette = {
          main = {
            base = '#100e13',
            surface = '#100e13',
            overlay = '#26233a',
            muted = '#575279',
            subtle = '#575279',
            text = '#cecacd',
            love = '#b87c77',
            gold = '#e19b74',
            rose = '#e89b9b',
            pine = '#5f8786',
            foam = '#aed7d6',
            iris = '#c4a7e7',
          },
        },
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },
}
