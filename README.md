nvim-automa
============================================================

Automatic macro recording and playback for Neovim.

## Installation

```vim
Plug 'nvim-automa'
```

## Usage

```lua
local automa = require'automa'
automa.setup({
  mapping = {
    ['.'] = {
      queries = {
        -- wide-range dot-repeat definition.
        automa.query_v1({ '!n(h,j,k,l)+' }),
      }
    },
  }
})
```

## Status

It works but query grammar is not stable.

## FAQ

### What's the benefit of this plugin?

1. The macro is more powerful than dot-repeat. Because it covers complex insert-mode key sequences.<br>
   For example, if you type `<Up>/<Down>` in insert-mode, dot-repeat will not work, but the macro will include and repeat `<Up>/<Down>`.

2. This plugin allows you to specify the range of dot-repeat.<br>
   For example, the `README.md`'s setting repeats all key sequences up to `h/j/k/l` in normal-mode.<br>
   In other words, `h/j/k/l` becomes the macro recording boundary.


### How to debug queries?

You can use `:AutomaToggleDebugger` for it.


### `README.md`'s setting is not suitable to me.

You can change query definition by yourself.

```lua
local automa = require('automa')
automa.setup({
  mapping = {
    ['.'] = {
      queries = {
        -- for `diwi***<Esc>`
        automa.query_v1({ 'n', 'no+', 'n', 'i*' }),
        -- for `x`
        automa.query_v1({ 'n#' }),
        -- for `i***<Esc>`
        automa.query_v1({ 'n', 'i*' }),
        -- for `vjjj>`
        automa.query_v1({ 'n', 'v*' }),
      }
    },
  }
})
```

### How to replace captured repeat keys?

There are two ways to accomplish this.

##### 1. You can define your own `automa.Query` function.

```lua
local automa = require('automa')
automa.setup {
  mapping = {
    ['.'] = {
      queries = {

        ...

        function(events)
          local result = automa.query_v1({ 'n', 'V*' })(events)
          if result then
            return {
              s_idx = result.s_idx,
              e_idx = result.e_idx,
              typed = vim.keycode('<Cmd>normal! .<CR>')
            }
          end
        end,

        ...

      }
    },
  }
}
```

##### 2. You can use `convert` option.

```lua
local automa = require('automa')
automa.setup {
  mapping = {
    ['.'] = {
      convert = function(result)
        if result.typed:match('[><]$') then
          result.typed = vim.keycode('<Cmd>normal! .<CR>')
        end
        return result
      end,
      queries = {

        ...

        automa.query_v1({ 'n', 'V*' })

        ...

      }
    },
  }
}
```
