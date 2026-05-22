return {
  -- Catppuccin: installed but inactive. Uncomment the init block to switch.
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    -- end,
    priority = 1000,
  },
  -- Kanagawa (dragon): installed but inactive; kanagawa-paper below is the
  -- active scheme. Uncomment the init block to switch.
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    -- init = function()
    --   vim.cmd.colorscheme 'kanagawa'
    -- end,
    -- WinSeparator override below paints split borders hot pink (#FF69B4).
    config = function()
      require('kanagawa').setup {
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        transparent = true,
        terminalColors = true,
        theme = 'dragon',
        dimInactive = false,
        overrides = function(colors)
          local theme = colors.theme
          return {
            LineNr = { bg = 'none' },

            -- TreesitterContextLineNumber = { bg = "none" },
            TreesitterContext = { bg = theme.ui.bg },

            -- telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg },
            TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
            TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
            TelescopePreviewNormal = { bg = theme.ui.bg },
            TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },

            -- popup menus
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            WinSeparator = { fg = '#FF69B4' },
          }
        end,
      }
    end,
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'kanagawa-paper'
    end,
    priority = 1000,
    opts = {
      -- undercurl = true,
      transparent = true,
      gutter = false,
      dimInactive = false, -- disabled when transparent
      terminalColors = true,
      commentStyle = { italic = true },
      functionStyle = { italic = false, bold = true },
      keywordStyle = { italic = true, bold = false },
      statementStyle = { italic = false, bold = false },
      typeStyle = { italic = false },
      colors = {
        theme = {},
        palette = {
          roninYellow = '#FFA066',
          samuraiRed = '#FF5D62',
        },
      },
      overrides = function() -- override highlight groups
        return {}
      end,
    },
  },
}
