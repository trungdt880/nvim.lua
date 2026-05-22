return {
  -- Go forward/backward with square brackets
  {
    'echasnovski/mini.bracketed',
    event = 'BufReadPost',
    config = function()
      local bracketed = require 'mini.bracketed'
      bracketed.setup {
        file = { suffix = '' },
        diagnostic = { suffix = '' },
        window = { suffix = '' },
        quickfix = { suffix = '' },
        yank = { suffix = '' },
        -- ]c / [c reserved for gitsigns hunk navigation (plugins/gitsigns.lua).
        comment = { suffix = '' },
        treesitter = { suffix = 'n' },
      }
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
