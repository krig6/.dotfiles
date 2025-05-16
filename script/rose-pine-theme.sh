if [ -f ~/.config/nvim/lua/ekodes/plugins/colorscheme.lua ]; then
    echo "Updating Neovim colorscheme configuration..."
    echo "return {
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
          transparency = true,
          italic = false,
        },
        palette = {
          main = {
            base = "#100e13",
            surface = "#100e13",
            overlay = "#26233a",
            muted = "#575279",
            subtle = "#575279",
            text = "#cecacd",
            love = "#b87c77",
            gold = "#e19b74",
            rose = "#e89b9b",
            pine = "#5f8786",
            foam = "#aed7d6",
            iris = "#c4a7e7",
          },
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
}" >~/.config/nvim/lua/ekodes/plugins/colorscheme.lua
    echo "Neovim colorscheme updated successfully!"
else
    echo "Neovim colorscheme configuration not found, skipping."
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

if [ -f ~/.config/polybar/config.ini ]; then
    echo "Updating Polybar colors..."
    awk '
    BEGIN { in_block = 0 }
    /^;[[:space:]]*Start of color definitions/ {
      print "; Start of color definitions"
      print "[colors]"
      print "background = #00000000"
      print "foreground = #e0def4"
      print "primary = #312f4f"
      print "secondary = #f6c177"
      print "alert = #eb6f92"
      print "disabled = #ebbcba"
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
      print "      echo \"\\[\\033[38;5;223m\\] ➜ $folder \\[\\033[38;5;74m\\]git:\\[\\033[38;5;74m\\](\\[\\033[38;5;212m\\]$branch\\[\\033[38;5;74m\\])\\[\\033[00m\\] \"; \\"
      print "    else \\"
      print "      echo \"\\[\\033[38;5;223m\\] ➜ $folder \"; \\"
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
      print "feh --bg-scale ~/.dotfiles/wallpapers/rosepine.jpg"
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
    feh --bg-scale ~/.dotfiles/wallpapers/rosepine.jpg
    betterlockscreen -u ~/.dotfiles/wallpapers/rosepine.jpg
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
      print "bg:  #191724;"
      print "cur: #44415a;"
      print "fgd: #e0def4;"
      print "cmt: #6e6a86;"
      print "cya: #9ccfd8;"
      print "grn: #31748f;"
      print "ora: #ebbcba;"
      print "pur: #c4a7e7;"
      print "red: #eb6f92;"
      print "yel: #f6c177;"
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
      print "set -g @plugin '\''rose-pine/tmux'\''"
      print "set -g @rose_pine_variant '\''main'\''"
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
gtk-theme-name=Rose-Pine
gtk-icon-theme-name=rose-pine-icons
EOF
echo "GTK theme and icons updated successfully!"
echo "Rose Pine theme applied!"
