## Karibiner Elements

Karabiner is good for mapping the capslock as it's working at a os level.
Keyboard Maestro could also map most of these keys, but it's one more dependency.

### karabiner_editme.json
Karabiner Elements insists on "sometimes" formatting the karabiner.json file and will make it hard to read.
To address this, the karabiner_editme.json file is formated in a way that is compressed and easy to read. Run mkKarabiner to create the karabiner.json file.
The karabiner.json file will be overwritten when you run mkKarabiner so don't edit it directly.


Note: You could use Goku, if your happy with adding a new dependency and learning another tool and syntax [here](https://github.com/yqrashawn/GokuRakuJoudo)

### Karabiner mappings

```
1)  <caps_lock> key to <hyp>, <hyp-.> to nothing, <hyp-;> to <c-x><c-j>, <hyp-,> to <c-x><c-k>",
2)  <hyp-u> to pageup, <hyp-d> to pagedown",
3)  <hyp-h>, <hyp-j>, <hyp-k>, <hyp-l> to left, down, up, right arrows",
4)  <hyp-del> to delete word, <hyp-9> to startOfLine, <hyp-0> to endOfLine",
5)  <hyp-c>, <hyp-r>, <hyp-t> to corresponding control keys",
6)  <hyp-y> to <c-x><c-y>, <cmd-c> to <c-x><c-y><cmd-c>, yank to system clipboard",
7)  <hyp-[>, <hyp-]>  prev next tab",
8)  <hyp-b> to <opt,cmd,leftarrow>, <hyp-n> to <opt,cmd,downarrow>",
9)  <hyp-ret> to <shift,cmd,return> in iterm2",
```
