require("conform").setup({
  stop_after_first = true,
  notify_no_formatters = false,
  default_format_opts = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
  },
})

vim.keymap.set("n", "<leader>=", function()
  local did_format = require("conform").format({
    lsp_format = "fallback",
  })
  if did_format then
    return
  end

  local view = vim.fn.winsaveview()
  vim.cmd("normal! gg=G")
  vim.fn.winrestview(view)
end, { desc = "Smart formatting using Conform" })
