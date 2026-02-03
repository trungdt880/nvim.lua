return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        'c',
        'lua',
        'javascript',
        'typescript',
        'python',
        'go',
        'java',
        'vim',
        'vimdoc',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'lua', 'javascript', 'typescript', 'python', 'go', 'java' },
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   opts = {
  --     enable = true,
  --     max_lines = 10, -- 0 for no limit
  --     multiline_threshold = 1,
  --     trim_scope = 'outer',
  --   },
  -- },
}
