-- ThePrimeagen/harpoon (v2) — pinned file list with quick-select slots.

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: [H]arpoon menu' })
      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon: [Add] file' })

      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon: View file ' .. i })
      end

      -- Cycle prev/next file in the Harpoon list.
      -- <leader>hn/hp = primary; <C-S-N/P> = legacy (many terminals drop them).
      vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end, { desc = 'Harpoon: [N]ext file' })
      vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end, { desc = 'Harpoon: [P]rev file' })
      vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
      vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)
    end,
  },
}
