-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- Errors-only: noisy codebases (PyTorch, ML) flood the loclist otherwise.
-- For all diagnostics use `<leader>sd` (Snacks) or `:Trouble diagnostics`.
vim.keymap.set('n', '<leader>q', function()
  vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.ERROR } }
end, { desc = 'Errors to quickfix' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Custom keymap ]]
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- vim.keymap.set('n', '<Left>', function()
--   require('origami').h()
-- end)
-- vim.keymap.set('n', '<Right>', function()
--   require('origami').l()
-- end)
map('n', '[d', function()
  vim.diagnostic.jump {
    count = -1,
    severity = vim.diagnostic.severity.WARN,
    wrap = true,
  }
end, { desc = 'Previous warning diagnostic in buffer' })
map('n', ']d', function()
  vim.diagnostic.jump {
    count = 1,
    severity = vim.diagnostic.severity.WARN,
    wrap = true,
  }
end, { desc = 'Next warning diagnostic in buffer' })
map('n', '[D', function()
  vim.diagnostic.jump {
    count = -1,
    severity = vim.diagnostic.severity.ERROR,
    wrap = true,
  }
end, { desc = 'Previous error diagnostic in buffer' })
map('n', ']D', function()
  vim.diagnostic.jump {
    count = 1,
    severity = vim.diagnostic.severity.ERROR,
    wrap = true,
  }
end, { desc = 'Next error diagnostic in buffer' })

-- map("n", "<leader>e", vim.cmd.Ex, { desc = "Open ex" })
map('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [w]ord on cursor' })
map('n', '<C-f>', '<cmd>silent !tmux neww t<CR>', { desc = 'Open new tmux session' })
map('n', '<leader>F', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Open new tmux' })

-- move line
map('x', 'J', ":move '>+1<CR>gv=gv", { desc = 'Move line up' })
map('x', 'K', ":move '<-2<CR>gv=gv", { desc = 'Move line down' })

-- yank and paste
map('x', '<leader>p', [["_dP]], { desc = 'Paste without remove clipboard' })
map('x', '<leader>y', [["_P]], { desc = 'Yank to clipboard' })
map('n', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank til end system clipboard' })
map('v', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>d', [["_d]], { desc = 'Delete without yank' })
map('v', '<leader>d', [["_d]], { desc = 'Delete without yank' })

-- line moving
-- map("n", "J", "mzJ`z`", { desc = "Connect line below" })
map('n', '<C-d>', '<C-d>zz', { desc = 'Move half-up' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Move half-down' })
map('n', 'n', 'nzzzv', { desc = 'Next find' })
map('n', 'N', 'Nzzzv', { desc = 'Prev find' })
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- utils
-- NOTE: <C-k>/<C-j> stay reserved for window navigation (see lines 25-26).
-- Use vim's built-in ]q/[q for quickfix nav, or <leader>k/<leader>j for location list.
map('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next in quickfix' })
map('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Prev in quickfix' })
map('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next in location' })
map('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Prev in location' })
map('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true })

map('n', '<leader>bu', vim.cmd.UndotreeToggle, { desc = 'Undotree toggle' })
map('n', '<leader>gs', vim.cmd.Git, { desc = 'Git toggle' })
-- map('n', '<leader>gg', vim.cmd.LazyGit, { desc = 'LazyGit toggle' })

-- cwd problem
-- Store the original working directory when Neovim starts
local original_cwd = vim.fn.getcwd()

-- Function to set CWD to the LSP root of the current buffer
local function set_cwd_to_lsp_root()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  if #clients == 0 then
    print 'No active LSP clients for the current buffer.'
    return
  end
  local lsp_root = clients[1].config.root_dir
  if lsp_root and vim.fn.isdirectory(lsp_root) == 1 then
    vim.api.nvim_set_current_dir(lsp_root)
    print('Changed working directory to LSP root: ' .. lsp_root)
  else
    print 'Invalid LSP root directory.'
  end
end

-- Function to reset CWD to the original directory
local function reset_cwd_to_original()
  vim.api.nvim_set_current_dir(original_cwd)
  print('Reset working directory to original: ' .. original_cwd)
end

-- Create user commands
vim.api.nvim_create_user_command('SetCwdToLspRoot', set_cwd_to_lsp_root, {})
vim.api.nvim_create_user_command('ResetCwdToOriginal', reset_cwd_to_original, {})

-- Key mappings
map('n', '<leader>bs', ':SetCwdToLspRoot<CR>', { desc = 'Set CWD to LSP root' })
map('n', '<leader>bS', ':ResetCwdToOriginal<CR>', { desc = 'Reset CWD to original' })
local log_path = vim.fn.stdpath 'cache' .. '/rsync_repo.log'

-- Helper: Run the command, write to log file, show notification
local function run_rsync_command(command, label)
  -- Reset to original directory
  vim.cmd 'ResetCwdToOriginal'

  -- Run the command and capture output
  local output = vim.fn.systemlist(command .. ' 2>&1')

  -- Save full output to log file
  vim.fn.writefile(output, log_path)

  -- Show last few lines in a notification
  local num_lines = #output
  local preview_lines = {}
  for i = math.max(1, num_lines - 5), num_lines do
    table.insert(preview_lines, output[i])
  end
  local message = label .. ' complete.\nLast lines:\n' .. table.concat(preview_lines, '\n')
  vim.notify(message, vim.log.levels.INFO, { title = 'RsyncRepo' })
end

-- Upload map
map('n', '<leader>ru', function()
  run_rsync_command('~/scripts/rsync_repo.py upload', 'Upload')
end, { desc = 'RsyncRepo: Upload' })

-- Download map
map('n', '<leader>rd', function()
  run_rsync_command('~/scripts/rsync_repo.py download', 'Download')
end, { desc = 'RsyncRepo: Download' })

map('n', '<leader>tH', function()
  require('oil').toggle_hidden()
end, { desc = 'Format: [T]oggle [H]idden in oil' })

-- Store the buffer number for the log file
local log_buffer = nil

-- View log file in buffer (toggle)
map('n', '<leader>rl', function()
  -- Check if buffer exists and is valid
  if log_buffer and vim.api.nvim_buf_is_valid(log_buffer) then
    -- Check if buffer is currently visible in any window
    local wins = vim.api.nvim_list_wins()
    local buffer_visible = false
    local win_with_buffer = nil

    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_buf(win) == log_buffer then
        buffer_visible = true
        win_with_buffer = win
        break
      end
    end

    if buffer_visible then
      -- Buffer is visible, close the window
      vim.api.nvim_win_close(win_with_buffer, false)
    else
      -- Buffer exists but not visible, show it in a new window
      vim.cmd 'new'
      vim.api.nvim_win_set_buf(0, log_buffer)
      vim.cmd 'normal! gg'
    end
  else
    -- Buffer doesn't exist, create it
    local lines = vim.fn.readfile(log_path)
    vim.cmd 'new'
    log_buffer = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_lines(log_buffer, 0, -1, false, lines)
    vim.bo[log_buffer].buftype = 'nofile'
    vim.bo[log_buffer].bufhidden = 'wipe'
    vim.bo[log_buffer].swapfile = false
    vim.bo[log_buffer].readonly = true
    vim.bo[log_buffer].filetype = 'log'
    vim.cmd 'normal! gg'

    -- Clear the buffer variable when the buffer is wiped
    vim.api.nvim_create_autocmd('BufWipeout', {
      buffer = log_buffer,
      callback = function()
        log_buffer = nil
      end,
      once = true,
    })
  end
end, { desc = 'Toggle RsyncRepo Log' })

map('n', '<leader>cp', '<cmd>AerialPrev<CR>', { desc = 'Previous symbol' })
map('n', '<leader>cn', '<cmd>AerialNext<CR>', { desc = 'Next symbol' })
map('n', '<leader>to', '<cmd>AerialToggle!<CR>', { desc = '[T]oggle [o]utline' })
