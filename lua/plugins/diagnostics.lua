-- folke/trouble.nvim — diagnostics/LSP/quickfix list panel.

return {
  {
    'folke/trouble.nvim',
    opts = {
      -- jk stays line nav (default), <C-n>/<C-p> jumps issue-by-issue.
      -- Trouble defaults: } / { also jump items.
      keys = {
        ['<C-n>'] = 'next',
        ['<C-p>'] = 'prev',
      },
    },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xe', '<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>', desc = 'Errors only (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
  },
}
