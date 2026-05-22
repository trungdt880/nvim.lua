local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

-- Parse a Python parameter list into `self.x = x` assignments.
-- Strips defaults (`= ...`), type hints (`: ...`), and *args/**kwargs prefixes;
-- skips `self` / `cls`.
local function args_to_self(args)
  local raw = args[1][1] or ''
  local out = {}

  for part in raw:gmatch '[^,]+' do
    part = part:gsub('^%s+', ''):gsub('%s+$', '')
    part = part:gsub('=.*$', '')
    part = part:gsub(':%s*.+$', '')
    part = part:gsub('^%*+', '')
    part = part:gsub('^%s+', ''):gsub('%s+$', '')

    if part ~= '' and part ~= 'self' and part ~= 'cls' then
      table.insert(out, 'self.' .. part .. ' = ' .. part)
    end
  end

  return #out > 0 and out or { '' }
end

return {
  s(
    'pinit',
    fmt(
      [[
def __init__(self, {}):
    super().__init__()
    {}
]],
      {
        i(1),
        f(args_to_self, { 1 }),
      }
    )
  ),
}
