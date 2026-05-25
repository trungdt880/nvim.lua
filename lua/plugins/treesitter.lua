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
  -- you scroll. Disabled; uncomment to enable.
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   opts = {
  --     enable = true,
  --     max_lines = 10, -- 0 for no limit
  --     multiline_threshold = 1,
  --     trim_scope = 'outer',
  --   },
  -- },
}
