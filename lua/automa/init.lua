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

---@alias automa.Query fun(events: automa.Event[]): { s_idx: integer, e_idx: integer, typed: string }?

---@class automa.Config
---@field mapping table<string, string[][]>

local P = {
  ---@type automa.Config
  config = {
    mapping = {}
  },

  ---@type table<string, automa.Query[]>
  queries = {},

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
      P.debug(('%s -> %s'):format(#P.events, tostring(e)))
    end
  end

  local is_separator = false
  is_separator = is_separator or typed == Event.dummy
  is_separator = is_separator or 'n' and P.config.mapping[Keymap.normalize(vim.fn.keytrans(typed))] ~= nil
  local e = setmetatable({
    separator = is_separator,
    fixed = false,
    char = is_separator and '' or typed,
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

  -- Initialize queries.
  do
    for key, query_sources in pairs(P.config.mapping) do
      P.queries[key] = kit.map(query_sources, Query.make_query)
    end
  end

  -- Initialize `vim.on_key`
  do
    vim.on_key(P.on_key, P.namespace)
  end
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

  local queries = kit.get(P.queries, key) --[=[@as automa.Query[]]=]
  if not queries then
    error('The specified key is not defined in the mapping.')
  end

  local candidates = {}
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

  local s_event = P.events[target.s_idx]
  local e_event = P.events[target.e_idx]
  P.debug(('>>> %s:%s / %s -> %s /  %s'):format(target.s_idx, target.e_idx, s_event.changedtick, e_event.changedtick, target.typed))

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