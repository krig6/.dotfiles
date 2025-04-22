if [ -f ~/.config/nvim/lua/plugins/colorscheme.lua ]; then
  echo "Updating Neovim colorscheme configuration..."
  echo "return {
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = 'original' -- mix, material, original
      vim.g.gruvbox_material_background = 'hard' -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = 'high' -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = 'dim' -- Background of floating windows (dim, bright)
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'highlighted'
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme('gruvbox-material')
    end,
  }
}" >~/.config/nvim/lua/plugins/colorscheme.lua
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
      print "  \"~/.config/alacritty/gruvbox.toml\","
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
      print "background-alt = #3c3836"
      print "foreground = #ebdbb2"
      print "primary = #504945"
      print "secondary = #fabd2f"
      print "alert = #fb4934"
      print "disabled = #d5c4a1"
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
      print "      echo \"\\[\\033[38;5;223m\\] ➜ \\[\\033[38;5;208m\\]$folder \\[\\033[38;5;167m\\]git:\\[\\033[38;5;142m\\](\\[\\033[38;5;142m\\]$branch\\[\\033[38;5;142m\\])\\[\\033[00m\\] \"; \\"
      print "    else \\"
      print "      echo \"\\[\\033[38;5;223m\\] ➜ \\[\\033[38;5;208m\\]$folder \\[\\033[00m\\]\"; \\"
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

if [ -f ~/.config/gtk-3.0/settings.ini ]; then
  echo "Updating GTK theme and icons..."
  echo "
[Settings]
gtk-theme-name=Gruvbox-Dark
gtk-icon-theme-name=Papirus
" >~/.config/gtk-3.0/settings.ini
  echo "GTK theme and icons updated successfully!"
else
  echo "GTK configuration not found, skipping."
fi

echo "Gruvbox Material theme applied successfully!"
