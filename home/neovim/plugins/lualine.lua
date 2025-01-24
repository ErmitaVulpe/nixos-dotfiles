opts = {
    icons_enabled = true
}

if not (vim.fn.has("gui_running") == 1 or vim.env.COLORTERM or vim.env.TERM_PROGRAM) then
    opts.icons_enabled = false
    -- opts.component_separators = { left = "|", right = "|" }
    opts.section_separators = { left = "", right = "" }
end

require("lualine").setup({
    options = opts
})
