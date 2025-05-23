-- Go up and down the file
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "!", "^")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
