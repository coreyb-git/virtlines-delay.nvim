# Virtual_Lines Delay

NeoVim will wait until you settle on a specific line before it shows
its virtual_lines diagnostics.

Without a delay each virtual_line instantly pops-in, moving all
text below it further downwards.
This constant dynamic shifting of text can be disorienting when
navigating through a file.

By adding a delay before revealing the current lines virtual_lines
diagnostics this plugin eliminates that disorientation.
Nothing pops-in until you finally stop on a line.

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
