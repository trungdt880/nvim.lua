-- Adds git related signs to the gutter, as well as utilities for managing changes.
-- All gitsigns config (signs + keymaps) lives here.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        -- Known cosmetic quirk: pressing ]c / [c opens an empty noice
        -- "Messages" popup. nav_hunk's trailing nvim_echo escapes through
        -- noice's message pipeline; silent! / max_length filters didn't
        -- catch it. Living with it for now.
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Hunk actions live under <leader>gh* (g = git, h = hunk).
        -- <leader>h* is owned by [H]arpoon.
        -- visual mode
        map('v', '<leader>ghs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [h]unk [s]tage' })
        map('v', '<leader>ghr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [h]unk [r]eset' })
        -- normal mode
        map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'git [h]unk [s]tage' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git [h]unk [r]eset' })
        map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'git [h]unk [S]tage buffer' })
        map('n', '<leader>ghu', gitsigns.stage_hunk, { desc = 'git [h]unk [u]ndo stage' })
        map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'git [h]unk [R]eset buffer' })
        map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'git [h]unk [p]review' })
        map('n', '<leader>ghb', gitsigns.blame_line, { desc = 'git [h]unk [b]lame line' })
        map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'git [h]unk [d]iff vs index' })
        map('n', '<leader>ghD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [h]unk [D]iff vs last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
