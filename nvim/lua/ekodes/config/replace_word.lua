-- Replace word under cursor
vim.keymap.set("n", "<leader>rw", function()
  local word = vim.fn.expand("<cword>")
  local replacement = vim.fn.input("Replace '" .. word .. "' with: ")
  if replacement == "" then
    return
  end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd(string.format("%%s/\\<%s\\>/%s/g", vim.fn.escape(word, "\\/"), replacement))
  vim.api.nvim_win_set_cursor(0, { row, col })
end, { noremap = true, silent = true })

-- Replace within visual selection
vim.api.nvim_set_keymap("x", "<leader>cw", [[:<C-u>lua VisualReplaceWord()<CR>]], { noremap = true, silent = true })
function VisualReplaceWord()
  local old = vim.fn.input("Old word: ")
  local new = vim.fn.input("New word: ")
  vim.cmd("'<,'>s/" .. old .. "/" .. new .. "/g")
end
