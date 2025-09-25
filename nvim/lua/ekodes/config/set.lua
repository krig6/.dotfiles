vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.statuscolumn = ""
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.wrap = true
vim.opt.iskeyword:append("-")
vim.opt.termguicolors = true
