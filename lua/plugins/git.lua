-- Git-side plugins (UI tools). Hunks live in plugins/gitsigns.lua;
-- :Git fugitive command lives in keymaps.lua / autocommands.lua.

return {
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- Loaded eagerly to expose :LazyGit. Snacks.lazygit (<leader>gg) is the
    -- primary entry point; this plugin is kept for the :LazyGit command and
    -- the commented <leader>gg map in keymaps.lua.
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    opts = {},
    keys = { { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iffview' } },
  },
}
