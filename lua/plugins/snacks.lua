-- folke/snacks.nvim — pickers, terminal, lazygit, zen, toggles, etc.
-- Split out of qol.lua so the snacks surface area lives in one file.

local grep_directory = function()
  local snacks = require 'snacks'

  vim.ui.input({
    prompt = 'Enter directory path for grep: ',
    default = vim.fn.getcwd(),
    completion = 'file',
  }, function(path)
    if path and path ~= '' then
      snacks.picker.grep { dirs = { path } }
    else
      vim.notify('No directory path entered. Grep operation cancelled.', vim.log.levels.INFO)
    end
  end)
end

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      terminal = {
        win = {
          wo = {
            winbar = '',
          },
        },
      },
      indent = { enabled = false },
      notifier = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      input = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            layout = { layout = { position = 'right' } },
          },
          grep = {
            hidden = true,
          },
        },
        hidden = true,
        preset = 'ivy',
      },
      quickfile = { enabled = true },
      scope = { enabled = false },
      words = { enabled = false },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      -- Top Pickers & Explorer
      { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
      -- Snacks built-in file explorer (disabled in opts above). We use
      -- mini.files / oil instead via <leader>ee / -.
      -- {
      --   '<leader>e',
      --   function()
      --     Snacks.explorer()
      --   end,
      --   desc = 'File Explorer',
      -- },

      -- find
      { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Config File' },
      { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
      { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
      { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
      { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },

      -- git
      { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
      { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
      { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
      { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
      { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
      -- <leader>gd is owned by Diffview (git.lua). Snacks diff lives on gD.
      { '<leader>gD', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
      { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },

      -- Grep / Search
      { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
      { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>sG', grep_directory, desc = 'Grep directory' },
      { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
      { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
      { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { '<leader>se', function() Snacks.picker.diagnostics { severity = vim.diagnostic.severity.ERROR } end, desc = 'Errors only' },
      { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
      { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
      { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
      { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
      { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
      { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
      { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
      { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
      { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
      { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
      { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },

      -- LSP
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
      { 'grr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
      { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
      { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
      { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
      { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },

      -- Other
      { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
      { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
      { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
      { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      -- <leader>n -> Snacks.picker.notifications() (defined above). Snacks.notifier
      -- is disabled in opts, so notifier.show_history() would no-op here.
      { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      { '<c-/>', function() Snacks.terminal.toggle() end, mode = { 'n', 't' }, desc = 'Toggle Terminal' },
      { '<m-j>', function() Snacks.terminal.toggle() end, mode = { 'n', 't' }, desc = 'Toggle Terminal' },
      { '<c-h>', [[<C-\><C-n><C-W>h]], mode = 't', desc = 'Window Movement: Move Left' },
      { '<c-j>', [[<C-\><C-n><C-W>j]], mode = 't', desc = 'Window Movement: Move Down' },
      { '<c-k>', [[<C-\><C-n><C-W>k]], mode = 't', desc = 'Window Movement: Move Up' },
      { '<c-l>', [[<C-\><C-n><C-W>l]], mode = 't', desc = 'Window Movement: Move Right' },
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Globals for debugging (lazy-loaded). dd() / bt() still available
          -- for explicit calls; we no longer override vim.print so that
          -- `:lua =foo` and `print()` go through the normal message route
          -- and are captured by noice (toggle history via <leader>tm).
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end

          -- Toggle mappings (registered on VeryLazy so Snacks.toggle is ready)
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
        end,
      })
    end,
  },
}
