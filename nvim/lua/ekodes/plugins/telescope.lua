return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers", noremap = true })
    vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "gs", builtin.lsp_workspace_symbols, { desc = "Telescope lsp workspace symbols" })
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope lsp definition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Telescope lsp references" })
    -- vim.keymap.set("n", "sd", builtin.diagnostics, { desc = "Telescope lsp references" })
  end,
}
