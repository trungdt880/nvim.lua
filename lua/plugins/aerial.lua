-- stevearc/aerial.nvim — symbol outline panel.
-- Keymaps live in lua/keymaps.lua: <leader>cp/cn (nav) and <leader>co/to (toggle).

return {
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
