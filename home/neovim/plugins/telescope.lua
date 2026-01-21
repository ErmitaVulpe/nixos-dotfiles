local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', function()
  builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
end, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "/node_modules/",
      "^node_modules/",
      "/target/",
      "^target/",
    },
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
    },
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  }
})
