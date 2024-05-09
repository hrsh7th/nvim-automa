local Event = {}

Event.prototype = {
  __tostring = function(self)
    return string.format(
      '%s: %s(%s)%s %s %s',
      self.bufnr,
      self.mode,
      vim.fn.keytrans(self.char),
      self.edit and '#' or '',
      self.undo and 'U' or '',
      self.dummy and 'Dummy' or ''
    )
  end
}

---@type automa.Event
Event.dummy = setmetatable({
  separator = true,
  fixed = true,
  char = '',
  mode = '',
  edit = false,
  bufnr = -1,
  changenr = -1,
  changedtick = -1,
}, Event.prototype)

return Event
