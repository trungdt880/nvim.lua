-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  {
    'echasnovski/mini.files',
    config = function()
      local MiniFiles = require 'mini.files'
      MiniFiles.setup {
        mappings = {
          go_in = '<CR>', -- Map both Enter and L to enter directories or open files
          go_in_plus = 'L',
          go_out = '-',
          go_out_plus = 'H',
        },
      }
      vim.keymap.set('n', '<leader>ee', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Toggle mini file explorer' }) -- toggle file explorer
      vim.keymap.set('n', '<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end, { desc = 'Toggle into currently opened file' })
    end,
  },
  {
    {
      'stevearc/oil.nvim',
      lazy = false,
      keys = {
        { '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' } },
      },
      opts = {
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
      },
      -- Optional dependencies
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      local ag = vim.api.nvim_create_augroup
      local au = vim.api.nvim_create_autocmd

      -- REQUIRED
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: [Add] file' })
      vim.keymap.set('n', '<leader>h', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: [H]arpoon menu' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: View file 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: View file 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: View file 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: View file 4' })
      vim.keymap.set('n', '<leader>5', function()
        harpoon:list():select(5)
      end, { desc = 'Harpoon: View file 5' })
      vim.keymap.set('n', '<leader>6', function()
        harpoon:list():select(6)
      end, { desc = 'Harpoon: View file 6' })
      vim.keymap.set('n', '<leader>7', function()
        harpoon:list():select(7)
      end, { desc = 'Harpoon: View file 7' })
      vim.keymap.set('n', '<leader>8', function()
        harpoon:list():select(8)
      end, { desc = 'Harpoon: View file 8' })
      vim.keymap.set('n', '<leader>9', function()
        harpoon:list():select(9)
      end, { desc = 'Harpoon: View file 9' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = 'right',
        resize_to_content = false,
        preserve_equality = true,
        max_width = { 40, 0.2 },
        min_width = { 35, 0.25 },
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
