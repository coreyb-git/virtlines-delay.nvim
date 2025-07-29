NeoVim will wait for you to settle on a specific line before showing its virtual_lines diagnostics.

Using Lazy plugin manager:
```
return {
  "coreyb-git/virtlines-delay.nvim",
  lazy=false,
  opts = {
    --delay = 1000
  },
}
