-- Go up and down the file
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Beginning and end of the line
vim.keymap.set("n", "!", "^")
vim.keymap.set("n", "@", "$")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
