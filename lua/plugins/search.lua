-- MagicDuck/grug-far.nvim — buffer-based project-wide search & replace.
-- Full ripgrep power (globs, flags, regex). Edit the results buffer live,
-- then apply. Fills the gap snacks.picker.grep can't (it searches, not replaces).
--  - <leader>sr (normal) = open empty search/replace buffer
--  - <leader>sr (visual) = seed the search with the current selection

return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      { '<leader>sr', function() require('grug-far').open() end, mode = 'n', desc = '[S]earch and [R]eplace (project)' },
      { '<leader>sr', function() require('grug-far').with_visual_selection() end, mode = 'x', desc = '[S]earch and [R]eplace selection' },
    },
    opts = {},
  },
}
