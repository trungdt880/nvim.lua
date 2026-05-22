-- Editing helpers: number/date bump, folds, line join/split, snippets,
-- python venv selector, auto-pair brackets.

return {
  {
    'monaqa/dial.nvim',
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { 'let', 'const' } },
        },
      }
    end,
  },

  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {
      -- Disable origami's default h/l fold-aware overrides on hjkl.
      -- (Currently letting origami bind them; flip to false to keep raw hjkl.)
      -- foldKeymaps = {
      --   setup = false,
      -- },
    }, -- needed even when using default config
    -- Disable vim's auto-folding so origami controls fold state.
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

  {
    'Wansmer/treesj',
    keys = {
      { '<leader>tj', '<cmd>TSJToggle<cr>', desc = '[T]oggle [J]oin' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load { paths = '~/.config/nvim/my_snippets' }
    end,
  },

  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = false,
    branch = 'regexp',
    keys = {
      { '<leader>cv', '<cmd>VenvSelect<cr>', desc = '[C]ode select python [v]env' },
    },
  },

  -- Auto-pair brackets/quotes on insert.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
