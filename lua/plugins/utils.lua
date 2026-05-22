return {
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  -- Zen mode comes from Snacks (<leader>z); folke/zen-mode.nvim removed to dedup.
  {
    'kristijanhusak/vim-carbon-now-sh',
    keys = {
      {
        '<leader>rs',
        ':CarbonNowSh<CR>',
        mode = { 'v', 'n' },
        desc = 'Take code snapshot',
      },
    },
  },
  {
    '2kabhishek/nerdy.nvim',
    cmd = 'Nerdy',
    keys = {
      { '<leader>ci', '<cmd>Nerdy<cr>', desc = 'Pick Icon' },
    },
  },
}
