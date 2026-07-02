-- folke/flash.nvim — treesitter-aware jump motions.
--  - s = jump anywhere on screen (type 2 chars, then a label to teleport)
--  - S = treesitter select (expand by node)
--  - Also labels f/F/t/T and `/` search automatically.
-- NOTE: `s` was mini.surround's prefix. Surround moved to `gs` (see qol.lua)
-- to free `s` for flash, matching the modern LazyVim-style layout. To revert:
-- restore mini.surround defaults in qol.lua and drop the `s`/`S` keys below.

return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },
}
