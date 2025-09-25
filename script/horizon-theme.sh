if [ -f ~/.config/nvim/lua/ekodes/plugins/colorscheme.lua ]; then
  echo "Updating Neovim colorscheme configuration..."
  echo "return {
  {
    'akinsho/horizon.nvim',
    config = function()
      vim.cmd.colorscheme('horizon')
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none'})
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'none' })
    end,
  },
}" >~/.config/nvim/lua/ekodes/plugins/colorscheme.lua
  echo "Neovim colorscheme updated successfully!"
else
  echo "Neovim colorscheme configuration not found, skipping."
fi

if [ -f ~/.config/openbox/autostart ]; then
  echo "Setting wallpaper in Openbox..."
  awk '
    BEGIN { in_block = 0 }
    /^#[[:space:]]*Set wallpaper/ {
      print "# Set wallpaper"
      print "feh --bg-scale ~/.dotfiles/wallpapers/horizon.jpg"
      in_block = 1
      next
    }
  in_block && /^#[[:space:]]*Wallpaper/ {
    print "# Wallpaper"
    in_block = 0
    next
    }
    in_block { next }
    { print }
  ' ~/.config/openbox/autostart >/tmp/openbox.tmp && mv /tmp/openbox.tmp ~/.config/openbox/autostart
  feh --bg-scale ~/.dotfiles/wallpapers/horizon.jpg
  betterlockscreen -u ~/.dotfiles/wallpapers/horizon.jpg
  echo "Wallpaper updated and set in Openbox!"
else
  echo "Wallpaper not found, skipping."
fi

echo "Horizon theme applied successfully!"
