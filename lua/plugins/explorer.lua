-- File explorers: mini.files (floating tree) + oil (buffer-as-directory).

return {
  {
    'echasnovski/mini.files',
    config = function()
      local MiniFiles = require 'mini.files'
      MiniFiles.setup {
        mappings = {
          go_in = '<CR>', -- Enter and L open files / enter directories.
          go_in_plus = 'L',
          go_out = '-',
          go_out_plus = 'H',
        },
      }
      vim.keymap.set('n', '<leader>ee', '<cmd>lua MiniFiles.open()<CR>', { desc = '[E]xplorer: open mini.files' })
      vim.keymap.set('n', '<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end, { desc = '[E]xplorer: reveal current [F]ile' })
    end,
  },

  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      { '-', '<CMD>Oil<CR>', { desc = 'Oil: open parent directory' } },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
