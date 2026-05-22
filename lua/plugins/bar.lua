return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = {
      {
        'kiennt63/harpoon-files.nvim',
        dependencies = {
          { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
        },
        opts = {
          icon = '',
          max_length = 7,
          separator_left = ' ',
          separator_right = '',
          reverse_order = true,
        },
      },
    },
    config = function()
      local separator_glyphs = require 'config.lualine_separator'
      local harpoon_files = require 'harpoon_files'

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          section_separators = {
            left = separator_glyphs.close,
            right = separator_glyphs.open,
          },
          -- component_separators = { left = separator_glyphs.close, right = separator_glyphs.open },
          component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = ''},
          disabled_filetypes = {
            'alpha',
            'starter',
            'ministarter',
            statusline = {},
            winbar = {},
          },
          ignore_focus = { 'NvimTree', 'alpha' },
          always_divide_middle = true,
          globalstatus = true,
          -- refresh = {
          --     statusline = 1000,
          --     tabline = 1000,
          --     winbar = 1000,
          -- },
        },
        sections = {
          lualine_a = {
            {
              'filename',
              icons_enabled = true,
              separator = {
                left = separator_glyphs.open,
                right = separator_glyphs.close,
              },
              right_padding = 0,
              symbols = {
                modified = '●',
              },
            },
          },

          lualine_b = {
            { 'branch', icon = { '' } },
            {
              'diff',
              source = function()
                ---@diagnostic disable-next-line: undefined-field
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              -- symbols = { added = ' ', modified = ' ', removed = ' ' },
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              cond = nil,
            },
          },

          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = {
                error = ' ',
                warn = ' ',
                info = ' ',
                hint = ' ',
              },
              cond = function()
                return vim.fn.winwidth(0) > 70
              end,
            },
            -- require('lsp-progress').progress,
          },
          -- lualine_d = {require('auto-session-library').current_session_name},
          lualine_x = {
            {
              harpoon_files.lualine_component,
            },
            -- {
            --     function (msg)
            --         msg = msg or 'lsp inactive'
            --         local buf_clients = vim.lsp.get_active_clients()
            --         if next(buf_clients) == nil then
            --             -- TODO: clean up this if statement
            --             if type(msg) == 'boolean' or #msg == 0 then
            --                 return 'nolang'
            --             end
            --             return msg
            --         end
            --         local buf_ft = vim.bo.filetype
            --         local buf_client_names = {}
            --
            --         -- add client
            --         for _, client in pairs(buf_clients) do
            --             if client.name ~= 'null-ls' then
            --                 table.insert(buf_client_names, client.name)
            --             end
            --         end
            --
            --         -- add formatter
            --         local formatters = require 'lvim.lsp.null-ls.formatters'
            --         local supported_formatters = formatters.list_registered(buf_ft)
            --         vim.list_extend(buf_client_names, supported_formatters)
            --
            --         -- add linter
            --         local linters = require 'lvim.lsp.null-ls.linters'
            --         local supported_linters = linters.list_registered(buf_ft)
            --         vim.list_extend(buf_client_names, supported_linters)
            --
            --         local unique_client_names = vim.fn.uniq(buf_client_names)
            --         return '[' .. table.concat(unique_client_names, ', ') .. ']'
            --     end,
            --     color = { gui = 'bold' },
            --     cond = function ()
            --         return vim.fn.winwidth(0) > 70
            --     end,
            -- },
            -- {
            --     'filetype',
            --     cond = function ()
            --         return vim.fn.winwidth(0) > 70
            --     end,
            -- },
          },
          lualine_y = { 'progress' },
          lualine_z = {
            {
              'location',
              separator = {
                left = separator_glyphs.open,
                right = separator_glyphs.close,
              },
              left_padding = 0,
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    config = function()
      -- triggers CursorHold event faster
      vim.opt.updatetime = 200

      require('barbecue').setup {
        create_autocmd = false,
        exclude_filetypes = { '' },
        attach_navic = true,
        show_navic = true,
        symbols = {
          separator = '',
          modified = '●',
        },
      }

      vim.api.nvim_create_autocmd({
        'WinResized', -- or WinResized on NVIM-v0.9 and higher
        'BufWinEnter',
        'CursorHold',
        'InsertLeave',

        -- include this if you have set `show_modified` to `true`
        'BufModifiedSet',
      }, {
        group = vim.api.nvim_create_augroup('barbecue.updater', {}),
        callback = function()
          require('barbecue.ui').update()
        end,
      })
    end,
  },
}
