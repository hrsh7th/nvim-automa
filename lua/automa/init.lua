local kit = require('automa.kit')
local Query = require('automa.query')
local Event = require('automa.event')
local Keymap = require('automa.kit.Vim.Keymap')

---@class automa.Event
---@field separator boolean
---@field fixed boolean
---@field char string
---@field mode string
---@field edit boolean
---@field bufnr integer
---@field changenr integer
---@field changedtick integer

---@class automa.Matcher
---@field negate boolean
---@field mode string
---@field chars string[]
---@field many boolean
---@field __call fun(events: automa.Event[], index: integer): boolean, integer

---@class automa.QueryResult
---@field s_idx integer
---@field e_idx integer
---@field typed string
---@alias automa.Query fun(events: automa.Event[]): automa.QueryResult?

---@class automa.Config
---@field mapping table<string, { convert?: fun(result: automa.QueryResult): automa.QueryResult, queries: automa.Query[] }>

local P = {
  ---@type automa.Config
  config = {
    mapping = {}
  },

  ---@type automa.Event[]
  events = {},

  ---@type { win: integer, buf: integer }
  debugger = {
    win = -1,
    buf = vim.api.nvim_create_buf(false, true),
  },

  ---@type integer
  namespace = vim.api.nvim_create_namespace("automa"),

  ---@type automa.Event
  prev_event = kit.clone(Event.dummy),
}

---Add debug message
---@param s string
function P.debug(s)
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(P.debugger.win) then
      vim.api.nvim_buf_set_lines(P.debugger.buf, 0, 0, false, { s })
      vim.api.nvim_win_set_cursor(P.debugger.win, { 1, 0 })
    end
  end)
end

---On key event
function P.on_key(_, typed)
  if typed == '' or typed == nil then
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  local bufnr = vim.api.nvim_get_current_buf()
  local changenr = vim.fn.changenr()
  local changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
  local is_separator = typed == Event.dummy
  local is_automa_key = not is_separator and (mode == 'n' and P.config.mapping[Keymap.normalize(vim.fn.keytrans(typed))] ~= nil)

  -- ignore automa defined key.
  if is_automa_key then
    return
  end

  -- fix changedtick & changenr when accepting next key event.
  if not P.prev_event.fixed then
    local is_undo = P.prev_event.mode and P.prev_event.changenr > changenr
    local is_moved = P.prev_event.bufnr ~= bufnr
    P.prev_event.separator = P.prev_event.separator or is_undo or is_moved
    P.prev_event.fixed = true
    P.prev_event.edit = P.prev_event.mode and P.prev_event.changedtick ~= changedtick
    P.prev_event.changenr = changenr
    P.prev_event.changedtick = changedtick
    do
      local e = P.prev_event
      P.debug(('%s: %s'):format(#P.events, tostring(e)))
    end
  end

  local e = setmetatable({
    separator = is_separator,
    fixed = false,
    char = typed,
    mode = mode,
    move = false,
    edit = false,
    bufnr = bufnr,
    changenr = changenr,
    changedtick = changedtick,
  }, Event.prototype)
  table.insert(P.events, e)
  P.prev_event = e
end

---The automa Public API.
local M = {}

---@param user_config automa.Config
function M.setup(user_config)
  user_config = user_config or {}

  local normalized_mapping = {}
  for k, v in pairs(user_config.mapping or {}) do
    normalized_mapping[Keymap.normalize(k)] = v
  end
  user_config.mapping = normalized_mapping
  P.config = kit.merge(user_config, P.config)

  -- Initialize mappings.
  do
    for key in pairs(P.config.mapping) do
      vim.keymap.set('n', key, function()
        return vim.fn.keytrans(M.fetch(key))
      end, { silent = true, expr = true, remap = true, replace_keycodes = true })
    end
  end

  -- Initialize `vim.on_key`
  do
    vim.on_key(P.on_key, P.namespace)
  end
end

---Query function for the old style configuration.
---@param query_source string[]
---@return automa.Query
function M.query_v1(query_source)
  return Query.make_query(query_source)
end

---Get events
function M.events()
  return P.events
end

---Clear events
function M.clear()
  P.events = {}
  for key in pairs(P.config.mapping) do
    vim.keymap.del('n', key)
  end
end

---@param key string
---@return string
function M.fetch(key)
  P.on_key(_, Event.dummy)

  local queries = kit.get(P.config, { 'mapping', key, 'queries' }) --[=[@as automa.Query[]]=]
  if not queries then
    error('The specified key is not defined in the mapping.')
  end

  local candidates = {} ---@type automa.QueryResult[]
  for _, query in ipairs(queries) do
    local candidate = query(P.events)
    if candidate then
      table.insert(candidates, candidate)
    end
  end

  if #candidates == 0 then
    return ''
  end

  local target = candidates[1]
  for _, candidate in ipairs(candidates) do
    if target.e_idx < candidate.e_idx then
      target = candidate
    elseif target.e_idx == candidate.e_idx then
      if target.s_idx > candidate.s_idx then
        target = candidate
      end
    end
  end

  local convert = kit.get(P.config, { 'mapping', key, 'convert' })
  if convert then
    target = convert(target)
  end

  P.debug(('>>> s%s:e%s `%s`'):format(target.s_idx, target.e_idx, target.typed))

  return target.typed
end

---Toggle debug panel.
function M.toggle_debug_panel()
  if vim.api.nvim_win_is_valid(P.debugger.win) then
    vim.api.nvim_win_close(P.debugger.win, true)
    P.debugger.win = -1
  else
    vim.cmd([[botright vertical 40new +wincmd\ p]])
    P.debugger.win = vim.fn.win_getid(vim.fn.winnr('#'))
    vim.api.nvim_win_set_buf(P.debugger.win, P.debugger.buf)
  end
end

return M
