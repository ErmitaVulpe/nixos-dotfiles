require("lualine").setup({
    icons_enabled = not (vim.fn.has("gui_running") == 1 or vim.env.COLORTERM or vim.env.TERM_PROGRAM)
})

-- if vim.fn.has("gui_running") == 1 or vim.env.COLORTERM or vim.env.TERM_PROGRAM then
--     require("lualine").setup()
-- end
