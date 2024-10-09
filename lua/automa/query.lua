local kit = require('automa.kit')

local Query = {}

do
  local P, Cs, Cg, Ct = vim.lpeg.P, vim.lpeg.Cs, vim.lpeg.Cg, vim.lpeg.Ct

  local function text(chars, esc)
    chars = kit.to_array(chars)
    esc = esc or '\\'

    local escaped = vim.iter(chars):fold(P(esc .. esc), function(acc, char)
      return acc + P(esc .. char)
    end) / function(v)
      return v:sub(2)
    end
    local onechar = vim.iter(chars):fold(P(1) - P(esc), function(acc, char)
      return acc - P(char)
    end)

    return Cs(escaped + onechar)
  end

  local mode = Cg(
    P('t') +
    P('!') +
    P('r?') +
    P('rm') +
    P('r') +
    P('cvr') +
    P('cv') +
    P('cr') +
    P('c') +
    P('Rvx') +
    P('Rvc') +
    P('Rv') +
    P('Rx') +
    P('Rc') +
    P('R') +
    P('ix') +
    P('ic') +
    P('i') +
    P('') +
    P('S') +
    P('s') +
    P('s') +
    P('') +
    P('Vs') +
    P('V') +
    P('vs') +
    P('v') +
    P('ntT') +
    P('nt') +
    P('niV') +
    P('niR') +
    P('niI') +
    P('no') +
    P('noV') +
    P('nov') +
    P('no') +
    P('n')
  ) / function(mode)
    if mode == 'C-v' then
      return ''
    end
    return mode
  end

  local char1 = P('<') * text('>') ^ 1 * P('>')
  local char2 = text({ ',', ')' }) ^ 1
  local char = Cs(char1 + char2)

  local chars = P('(') * Ct(char * (P(',') * char) ^ 0) * P(')')

  local edit = Cg(P('#'))

  local negate = Cg(P('!'))

  local many = Cg(P('+') + P('*'))

  local grammer = P({
    'query',
    query = (Cg(negate ^ -1) * Cg(mode) * Cg(chars ^ -1) * Cg(edit ^ -1) * Cg(many ^ -1)) / function(_negate, _mode, _chars, _edit, _many)
      return {
        negate = _negate,
        mode = _mode,
        chars = _chars,
        edit = _edit,
        many = _many,
      }
    end
  })

  Query.grammer = grammer
end


---@param q string
---@return automa.Matcher
local function make_matcher(q)
  local parsed = Query.grammer:match(q)
  assert(parsed, 'Failed to parse query: ' .. q)
  return setmetatable({
    negate = parsed.negate,
    mode = parsed.mode,
    chars = parsed.chars,
    edit = parsed.edit,
    many = parsed.many,
  }, {
    ---@param events automa.Event[]
    ---@param index integer
    ---@return boolean, integer
    __call = function(self, events, index)
      ---@param idx integer
      ---@return boolean
      local function match(idx)
        local event = events[idx]
        if not event then
          return false
        end
        if event.separator then
          return false
        end

        if self.edit == '#' then
          if not event.edit then
            return false
          end
        end

        local result = (function()
          if self.mode ~= '' then
            if event.mode ~= self.mode then
              return false
            end
          end
          if #self.chars > 0 then
            if not kit.contains(kit.map(self.chars, vim.keycode), event.char) then
              return false
            end
          end
          return true
        end)()

        -- negate `mode` and `chars` condition.
        if self.negate == '!' then
          result = not result
        end

        return result
      end

      -- single match.
      if self.many == '' then
        if match(index) then
          return true, index + 1
        end
        return false, index
      end

      -- many match.
      local match_count = 0
      while index + match_count <= #events do
        if not match(index + match_count) then
          break
        end
        match_count = match_count + 1
      end

      if self.many == '+' and match_count == 0 then
        return false, index
      end

      return true, index + match_count
    end
  })
end

---@param query_source string[]
---@return fun(events: automa.Event[]): { s_idx: integer, e_idx: integer }?
function Query.make_query(query_source)
  local matchers = kit.map(query_source, make_matcher)

  ---@param events automa.Event[]
  ---@param index integer
  local function match(events, index)
    local s_event = events[index]
    for _, matcher in ipairs(matchers) do
      local matched, next_index = matcher(events, index)
      if not matched then
        return false, index
      end
      index = next_index
    end

    -- check the range of key-sequence makes text edit.
    local e_event = events[index - 1]
    if s_event and e_event then
      local is_same_event = s_event == e_event
      if (is_same_event and not s_event.edit) or (not is_same_event and s_event.changedtick == e_event.changedtick) then
        return false, index
      end
    end
    return true, index
  end

  ---@type automa.Query
  return function(events)
    local candidates = {} --[=[@type { s_idx: integer, e_idx: integer }[]]=]

    local s_idx, e_idx = #events, -1
    while s_idx > 0 do
      local curr_matched, curr_e_idx = match(events, s_idx)
      if curr_matched then
        if e_idx <= curr_e_idx then
          e_idx = curr_e_idx
          table.insert(candidates, { s_idx = s_idx, e_idx = e_idx - 1 })
        else
          break
        end
      end
      s_idx = s_idx - 1
    end

    if #candidates == 0 then
      return
    end

    local target = candidates[1] ---@type automa.QueryResult
    for _, candidate in ipairs(candidates) do
      if target.e_idx < candidate.e_idx then
        target = candidate
      elseif target.e_idx == candidate.e_idx then
        if target.s_idx > candidate.s_idx then
          target = candidate
        end
      end
    end

    target.reginfo = events[target.s_idx].reginfo
    target.typed = ''
    for i = target.s_idx, target.e_idx do
      target.typed = target.typed .. events[i].char
    end
    return target
  end
end

return Query
