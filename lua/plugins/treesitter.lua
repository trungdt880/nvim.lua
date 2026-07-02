return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      -- Ensure basic parsers installed up front.
      -- Union of the previous list + upstream additions (markdown/bash/etc.).
      local parsers = {
        'bash',
        'c',
        'diff',
        'go',
        'html',
        'java',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'typescript',
        'vim',
        'vimdoc',
      }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)

        -- Indent: fall back to vim builtin if no indent query exists
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
        if has_indent_query then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- Auto-install missing parser, then attach
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            -- Parser may exist outside nvim-treesitter; try anyway
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  -- treesitter-context: sticky header showing the enclosing function/class as
  -- you scroll.
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    opts = {
      enable = true,
      max_lines = 10, -- 0 for no limit
      multiline_threshold = 1,
      trim_scope = 'outer',
    },
  },

  -- Treesitter text objects (main branch API — manual keymaps, no `keymaps`
  -- table). Select/swap/move by syntax node. Keys chosen to avoid mini.ai
  -- (owns brackets/quotes/f-call, aa/ii for next) and gitsigns (]c/[c hunks).
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local swap = require 'nvim-treesitter-textobjects.swap'
      local move = require 'nvim-treesitter-textobjects.move'

      -- Select: am/im = function (m for method), ac/ic = class.
      local sel = function(obj)
        return function() select.select_textobject(obj, 'textobjects') end
      end
      vim.keymap.set({ 'x', 'o' }, 'am', sel '@function.outer', { desc = 'a function' })
      vim.keymap.set({ 'x', 'o' }, 'im', sel '@function.inner', { desc = 'inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', sel '@class.outer', { desc = 'a class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', sel '@class.inner', { desc = 'inner class' })

      -- Swap the parameter under cursor with the next/previous one.
      vim.keymap.set('n', '<leader>cx', function() swap.swap_next '@parameter.inner' end, { desc = '[C]ode swap param ne[X]t' })
      vim.keymap.set('n', '<leader>cX', function() swap.swap_previous '@parameter.inner' end, { desc = '[C]ode swap param pre[X]' })

      -- Move: ]m/[m function start, ]M/[M function end, ]k/[k class start.
      local moves = {
        { ']m', move.goto_next_start, '@function.outer', 'Next function start' },
        { '[m', move.goto_previous_start, '@function.outer', 'Prev function start' },
        { ']M', move.goto_next_end, '@function.outer', 'Next function end' },
        { '[M', move.goto_previous_end, '@function.outer', 'Prev function end' },
        { ']k', move.goto_next_start, '@class.outer', 'Next class start' },
        { '[k', move.goto_previous_start, '@class.outer', 'Prev class start' },
      }
      for _, m in ipairs(moves) do
        vim.keymap.set({ 'n', 'x', 'o' }, m[1], function() m[2](m[3], 'textobjects') end, { desc = m[4] })
      end
    end,
  },
}
