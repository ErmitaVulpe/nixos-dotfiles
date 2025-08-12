-- Copy to clipboard
-- vim.o.clipboard = "unnamedplus"

-- Set search options
vim.opt.ic = false
vim.opt.is = true
vim.opt.hls = true

-- Set line numbering
vim.opt.nu = true
vim.opt.rnu = true

-- Set indent options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

-- use undotree instead of the default
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

vim.opt.winborder = "rounded"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = { "80", "100" }

-- enable inlay hints
vim.lsp.inlay_hint.enable()

-- briefly highlight yanked area
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 75 }
  end,
})

-- conditionally enable termguicolors
if vim.fn.has("gui_running") == 1 or vim.env.COLORTERM or vim.env.TERM_PROGRAM then
  vim.o.termguicolors = true
end

