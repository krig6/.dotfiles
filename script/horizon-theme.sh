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

if [ -f ~/.config/polybar/config.ini ]; then
  echo "Updating Polybar colors..."
  awk '
    BEGIN { in_block = 0 }
    /^;[[:space:]]*Start of color definitions/ {
      print "; Start of color definitions"
      print "[colors]"
      print "background = #00000000"
      print "foreground = #e0def4"
      print "primary = #F4C01F"
      print "secondary = #f6c177"
      print "alert = #eb6f92"
      print "disabled = #313639"
      in_block = 1
      next
    }
  in_block && /^;[[:space:]]*End of color definitions/ {
    print "; End of color definitions"
    in_block = 0
    next
    }
    in_block { next }
    { print }
  ' ~/.config/polybar/config.ini >/tmp/polybar.tmp && mv /tmp/polybar.tmp ~/.config/polybar/config.ini

  killall polybar
  polybar top &
  echo "Polybar updated and restarted successfully!"
else
  echo "Polybar configuration not found, skipping."
fi

if [ -f ~/.config/alacritty/alacritty.toml ]; then
  echo "Updating Alacritty theme..."
  awk '
    BEGIN { in_block = 0 }
    /^import = \[/ {
      print "import = ["
      print "  \"~/.config/alacritty/keybindings.toml\","
      print "  \"~/.config/alacritty/rose-pine.toml\","
      in_block = 1
      next
    }
    in_block && /^\s*\]/ {
      print "]"
      in_block = 0
      next
    }
    in_block { next }
    { print }
  ' ~/.config/alacritty/alacritty.toml >/tmp/alacritty.tmp && mv /tmp/alacritty.tmp ~/.config/alacritty/alacritty.toml
  echo "Alacritty configuration updated successfully!"
else
  echo "Alacritty configuration not found, skipping."
fi

if [ -f ~/.bashrc ]; then
  echo "Updating Bash prompt (PS1)..."
  awk '
    BEGIN { in_block = 0 }
    /^#[[:space:]]*Start of custom PS1 prompt configuration/ {
      print "# Start of custom PS1 prompt configuration"
      print "if [ \"$color_prompt\" = yes ]; then"
      print "  PS1='\''$( \\"
      print "    branch=$(parse_git_branch); \\"
      print "    folder=$(realpath --relative-to=\"$HOME\" \"$PWD\"); \\"
      print "    if [ \"$PWD\" == \"$HOME\" ]; then \\"
      print "      echo \"\\[\\033[00m\\] ➜ \"; \\"
      print "    elif [ -n \"$branch\" ]; then \\"
      print "      echo \"\\[\\033[38;5;173m\\] ➜ $folder \\[\\033[38;5;66m\\]git:\\[\\033[38;5;66m\\](\\[\\033[38;5;210m\\]$branch\\[\\033[38;5;66m\\])\\[\\033[00m\\] \"; \\"
      print "    else \\"
      print "      echo \"\\[\\033[38;5;173m\\] ➜ $folder \"; \\"
      print "    fi \\"
      print "  )'\''"
      print "else"
      print "  PS1='\''$( \\"
      print "    branch=$(parse_git_branch); \\"
      print "    folder=$(realpath --relative-to=\"$HOME\" \"$PWD\"); \\"
      print "    if [ \"$PWD\" == \"$HOME\" ]; then \\"
      print "      echo \" ➜  \"; \\"
      print "    elif [ -n \"$branch\" ]; then \\"
      print "      echo \" ➜ $folder (git: $branch) \"; \\"
      print "    else \\"
      print "      echo \" ➜ $folder \"; \\"
      print "    fi \\"
      print "  )'\''"
      print "fi"
      in_block = 1
      next
    }
    in_block && /^#[[:space:]]*End of custom PS1 prompt configuration/ {
      print "# End of custom PS1 prompt configuration"
      in_block = 0
      next
    }
    in_block { next }
    { print }
  ' ~/.bashrc >/tmp/.bashrc.tmp && mv /tmp/.bashrc.tmp ~/.bashrc
  echo "Bash prompt updated successfully!"
else
  echo "Bash configuration not found, skipping."
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

if [ -f ~/.config/rofi/config.rasi ]; then
  echo "Setting Rofi theme..."
  awk '
    BEGIN { in_block = 0 }
    /^[[:space:]]*\/\/ Start of color definitions/ {
      print "// Start of color definitions"
      print "* {"
      print "bg:  #1c1e26;"
      print "cur: #2e303e;"
      print "fgd: #e3e6ee;"
      print "cmt: #6c6f93;"
      print "cya: #21bfc2;"
      print "grn: #27d796;"
      print "ora: #f09383;"
      print "pur: #b877db;"
      print "red: #e95678;"
      print "yel: #fab795;"
      in_block = 1
      next
    }
  in_block && /^[[:space:]]*\/\/ End of color definitions/ {
    print "// End of color definitions"
    in_block = 0
    next
    }
    in_block { next }
    { print }
  ' ~/.config/rofi/config.rasi >/tmp/rofi.tmp && mv /tmp/rofi.tmp ~/.config/rofi/config.rasi
  echo "Rofi theme updated!"
else
  echo "Rofi theme not found, skipping."
fi

if [ -f ~/.tmux.conf ]; then
  echo "Setting tmux theme..."
  awk '
    BEGIN { in_block = 0 }
    /^#[[:space:]]*Set tmux theme/ {
      print "# Set tmux theme"
      print "set -g @plugin '\''egel/tmux-gruvbox'\''"
      in_block = 1
      next
    }
  in_block && /^#[[:space:]]*tmux theme/ {
    print "# tmux theme"
    in_block = 0
    next
    }
    in_block { next }
    { print }
  ' ~/.tmux.conf >/tmp/.tmux.tmp && mv /tmp/.tmux.tmp ~/.tmux.conf
  echo "Tmux theme updated!"
else
  echo "Tmux theme not found, skipping."
fi

mkdir -p ~/.config/gtk-3.0

echo "Updating GTK theme and icons..."
cat >~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Gruvbox-Dark
gtk-icon-theme-name=Papirus
EOF
echo "GTK theme and icons updated successfully!"
echo "Horizon theme applied successfully!"
