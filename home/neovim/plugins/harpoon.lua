local harpoon = require("harpoon")

harpoon:setup()

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader><C-x>", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })

vim.keymap.set("n", "<leader>q", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>w", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>e", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>r", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader><C-q>", function() harpoon:list():replace_at(1) end)
vim.keymap.set("n", "<leader><C-w>", function() harpoon:list():replace_at(2) end)
vim.keymap.set("n", "<leader><C-e>", function() harpoon:list():replace_at(3) end)
vim.keymap.set("n", "<leader><C-r>", function() harpoon:list():replace_at(4) end)
