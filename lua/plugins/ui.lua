return {
  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 2000,
      render = 'wrapped-compact',
      stages = 'static',
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- Render LSP markdown via treesitter so cmp/etc pick up nicer highlights.
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- classic bottom cmdline for search
        command_palette = true, -- cmdline + popupmenu in one float
        long_message_to_split = true, -- long messages → split
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    keys = {
      -- Toggle the noice message history in a persistent split. Useful when
      -- a notification disappears before you can read it (e.g. `:lua =foo`).
      {
        '<leader>tm',
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == 'noice' then
              vim.api.nvim_win_close(win, false)
              return
            end
          end
          -- `all` includes msg_show, lsp, notify, etc. `history` filters
          -- to the message history view only.
          vim.cmd 'Noice all'
        end,
        desc = '[T]oggle [M]essage log (noice)',
      },
      { '<leader>tM', '<cmd>Noice dismiss<cr>', desc = '[T]oggle: dis[M]iss notifications' },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- nvim-notify provides the notification view; noice falls back to mini if missing.
      'rcarriga/nvim-notify',
    },
  },
}
