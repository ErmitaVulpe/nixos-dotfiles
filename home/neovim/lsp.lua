vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end
})

local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local function lspConfigurator(executable, server_name, settings)
  if os.execute("which " .. executable .. " > /dev/null 2>&1") == 0 then
    vim.lsp.config(server_name, vim.tbl_extend("keep", settings or {}, {
      capabilities = lsp_capabilities,
    }))
    vim.lsp.enable(server_name)
  end
end

lspConfigurator("lua-language-server", "lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})
lspConfigurator("nixd", "nixd")
lspConfigurator("pyright", "pyright")
lspConfigurator("rust-analyzer", "rust_analyzer")
lspConfigurator("vscode-css-language-server", "cssls")
lspConfigurator("vscode-eslint-language-server", "eslint")
lspConfigurator("vscode-html-language-server", "html")
lspConfigurator("vscode-json-language-server", "jsonls")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "nix" },
  command = "setlocal shiftwidth=2 tabstop=2"
})
