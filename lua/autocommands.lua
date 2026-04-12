-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('my-fugitive', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then return end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git 'push' end, opts)

    -- rebase always
    vim.keymap.set('n', '<leader>gP', function() vim.cmd.Git { 'pull', '--rebase' } end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set('n', '<leader>gpp', ':Git push -u origin ', opts)
  end,
})

autocmd('BufWritePre', {
  callback = function(args)
    if vim.bo[args.buf].filetype ~= 'oil' then
      local dir = vim.fn.fnamemodify(args.file, ':p:h')
      if not vim.loop.fs_stat(dir) then vim.fn.mkdir(dir, 'p') end
    end
  end,
})

vim.api.nvim_create_user_command('CopyAbsoluteFilePath', function()
  local filepath = vim.fn.expand '%:p'
  vim.fn.setreg('+', filepath)
  print('Copied: ' .. filepath)
end, {})

vim.api.nvim_create_user_command('CopyFilePath', function()
  local filepath = vim.fn.expand '%'
  vim.fn.setreg('+', filepath)
  print('Copied: ' .. filepath)
end, {})

-- disable auto-indent when escaping to normal mode
local function apply_ts_indent_if_blank()
  local buf = vim.api.nvim_get_current_buf()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]

  local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
  if line ~= '' then return end

  -- get indent from indentexpr (Tree-sitter or fallback)
  local old_lnum = vim.v.lnum
  vim.v.lnum = lnum
  local indent = vim.fn.eval(vim.bo.indentexpr)
  vim.v.lnum = old_lnum

  if indent > 0 then vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { string.rep(' ', indent) }) end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('$', true, false, true), 'n', true)
end

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = apply_ts_indent_if_blank,
})
