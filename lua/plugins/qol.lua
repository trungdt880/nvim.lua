-- Quality-of-life plugins: which-key, mini.nvim, todo-comments, guess-indent.
-- Snacks lives in snacks.lua.

return {
  { 'NMAC427/guess-indent.nvim', opts = {} }, -- Detect tabstop and shiftwidth automatically

  { -- Pending-keybinds popup
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
      },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>gh', group = 'git [H]unk', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>u', group = '[U]I' },
        { '<leader>r', group = 'Othe[R]' },
        { '<leader>e', group = '[E]xplorer' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>x', group = 'Trouble' },
        { '<leader>a', group = '[A]I' },
      },
    },
  },

  -- Highlight TODO/NOTE/FIX/etc. in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Collection of small independent plugins/modules (mini.nvim)
    'nvim-mini/mini.nvim',
    config = function()
      -- mini.ai — extended text objects.
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup {
        -- Avoid conflicts with treesitter incremental selection on nvim >= 0.12.
        mappings = {
          around_next = 'aa',
          inside_next = 'ii',
        },
        n_lines = 500,
      }

      -- mini.surround — add/delete/replace brackets, quotes, etc.
      --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      --  - sd'   - [S]urround [D]elete [']quotes
      --  - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- mini.statusline — kickstart sample, disabled because lualine owns
      -- the statusline in plugins/bar.lua.
      -- local statusline = require 'mini.statusline'
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      -- statusline.section_location = function() return '%2l:%-2v' end
    end,
  },
}
