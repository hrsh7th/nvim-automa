nvim-automa
============================================================

Automatic macro recording and playback for Neovim.

## Installation

```vim
Plug 'nvim-automa'
```

## Usage

```lua
require'automa'.setup({
  mapping = {
    ['.'] = {
      -- wide-range dot-repeat definition.
      { '!n(h,j,k,l)+' },
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
require'automa'.setup({
  mapping = {
    ['.'] = {
      -- for `diwi***<Esc>`
      { 'n', 'no+', 'n', 'i*' },
      -- for `x`
      { 'n#' },
      -- for `i***<Esc>`
      { 'n', 'i*' },
      -- for `vjjj>`
      { 'n', 'v*' },
    },
  }
})
```

