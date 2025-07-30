# Virtual_Lines Delay

Intended for use with vim.diagnostic.config({virtual_lines={current_line=true}}),
and respects formatting being performed by other plugins.

With this plugin NeoVim will wait until you settle on a line before it shows
its virtual_lines diagnostics.
Without the delay each virtual_line instantly pops-in as you navigate, moving all
text below it further downwards.
This constant dynamic shifting of text can be disorienting.

By adding a delay before revealing the virtual_lines this disorientation
is eliminated - Nothing pops-in until you have stopped vertical navigation.

## Install

Using Lazy plugin manager:

```Lua
return {
  "coreyb-git/virtlines-delay.nvim",
  lazy=false,
  opts = {
    delay = 200
  },
}
```

Else call:

```Lua
require('virtlines-delay').setup()
```
