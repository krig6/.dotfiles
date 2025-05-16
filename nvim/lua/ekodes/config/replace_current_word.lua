vim.keymap.set("n", "<leader>rw", function()
  local word = vim.fn.expand("<cword>")
  local replacement = vim.fn.input("Replace '" .. word .. "' with: ")
  if replacement == "" then
    return
  end

  -- Save current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Do the substitution
  vim.cmd(string.format("%%s/\\<%s\\>/%s/g", vim.fn.escape(word, "\\/"), replacement))

  -- Restore cursor position
  vim.api.nvim_win_set_cursor(0, { row, col })
end, { noremap = true, silent = true })
