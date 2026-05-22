-- [[ Setting global ]]
-- See `:help vim.g`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal.
-- Lualine, snacks, gitsigns, and aerial all render glyphs that require it.
vim.g.have_nerd_font = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Format-on-save toggle backing the <leader>tf mapping in plugins/lsp.lua.
-- Initialized here so the value is never nil (conform.nvim checks truthiness).
vim.g.disable_autoformat = false

if os.getenv 'SSH_TTY' then
  -- Configure Neovim to use OSC 52 for clipboard operations during SSH sessions
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
else
  -- Retain default clipboard behavior for local sessions
  vim.g.clipboard = nil
end

-- [[ Setting options ]]
-- See `:help vim.o` and `:help vim.opt`

local options = {
  -- Make line numbers default
  number = true,
  relativenumber = true,

  -- Enable mouse mode, can be useful for resizing splits for example!
  mouse = 'a',
  -- Don't show the mode, since it's already in the status line
  showmode = false,

  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,

  -- Enable break indent
  breakindent = true,

  -- Save undo history under the XDG state dir (~/.local/state/nvim/undo by
  -- default). Avoids the legacy ~/.vim/undodir path that predates XDG.
  undofile = true,
  undodir = vim.fn.stdpath 'state' .. '/undo',
  swapfile = false,

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  ignorecase = true,
  smartcase = true,

  -- Keep signcolumn on by default
  signcolumn = 'yes',

  -- Decrease update time
  updatetime = 250,

  -- Decrease mapped sequence wait time
  timeoutlen = 300,

  -- Configure how new splits should be opened
  splitright = true,
  splitbelow = true,

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'` and `:help 'listchars'`
  list = true,
  listchars = { tab = '» ', trail = '·', nbsp = '␣' }, -- This is a table option, vim.opt handles it

  -- Preview substitutions live, as you type!
  inccommand = 'split',

  -- Show which line your cursor is on
  cursorline = false,

  -- Minimal number of screen lines to keep above and below the cursor.
  scrolloff = 10,
  sidescrolloff = 10,

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  confirm = true,
}

-- Loop through the options table and set them using vim.opt
for k, v in pairs(options) do
  vim.opt[k] = v
end
