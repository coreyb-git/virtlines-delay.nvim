# Virtual_Lines Delay

NeoVim will wait until you settle on a specific line before showing
its virtual_lines diagnostics.  This makes it much easier to read text
that has a lot of diagnostics, else each line vertically adjusts as you
navigate to different lines, which can be disorienting.

Using Lazy plugin manager:

```Lua
return {
  "coreyb-git/virtlines-delay.nvim",
  lazy=false,
  opts = {
    delay = 1000
  },
}
```
