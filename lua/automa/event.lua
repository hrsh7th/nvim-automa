local Event = {}

Event.prototype = {
  __tostring = function(self)
    return string.format(
      '%s%s(%s)%s',
      self.separator and '---------- ' or '',
      self.mode,
      self.char == Event.dummy and 'dummy' or vim.fn.keytrans(self.char),
      self.edit and '#' or ''
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
