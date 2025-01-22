vim.g.mapleader = " "

-- netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pn", function() vim.cmd("Vex!") end)

-- convenience
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete to void
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>x", [["_x]])

-- format whole buffer
vim.keymap.set("n", "<leader>=", "gg=G``")

-- terminal navigation
vim.keymap.set("t", "<C-w>h", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-N><C-w>l")
vim.keymap.set("t", "<C-w>q", "<C-\\><C-N><C-w>q")
vim.keymap.set("t", "<C-w><C-q>", "<C-\\><C-N><C-w><C-q>")

-- -- since tmux navigator occupies the <C-l> keybinding i rebind it's
-- -- functionality to "\"
-- vim.keymap.set("n", "\\", function ()
--     vim.cmd("noh")
--     print(" ")
-- end)
