# Vim Key Mappings Reference

**Leader Key:** `<Space>`

## Leader Key Mappings (spc = Space)

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
spc spc    Enter command mode (:)                          i2-base.vim
spc m      Toggle markdown rendering                       i3-vim.vim
spc l      Create file in current directory (Dirvish)     i3-vim.vim
spc k      Toggle buffer modifiable/view mode              i2-base.vim
spc h      Toggle highlight search with status             i2-base.vim
spc n      Toggle line numbers                             i2-base.vim
spc v      Split window vertically                         i2-base.vim
spc s      Split window horizontally                       i2-base.vim
spc f      Close current window/buffer                     i2-base.vim
spc t      open terminal                                   i3-vim
```

## VSCode G-Key Mappings

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
go         Execute in terminal                             i3-vscode.vim
gO         Debug run                                       i3-vscode.vim
g-         Show explorer                                   i3-vscode.vim
ga         Show command palette                            i3-vscode.vim
gf         Quick open                                      i3-vscode.vim
gt         Go to implementation                            i3-vscode.vim
gR         Go to references                                i3-vscode.vim
gr         Rename                                          i3-vscode.vim
g<CR>      Quick fix                                       i3-vscode.vim
g=         Format document                                 i3-vscode.vim
gh         Show hover                                      i3-vscode.vim
ge         Next error                                      i3-vscode.vim
gE         Previous error                                  i3-vscode.vim
```

## Neovim G-Key Mappings

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
gs         Replace current word                            i3-vim.vim
gF         Find files by type (Python/Markdown)           i4-fzf.vim
gf         Ripgrep search in files                         i4-fzf.vim
gp         Paste from yank register                        i2-base.vim
```

## Custom Mark System

**Note:** Overrides standard `<C-o>`/`<C-i>` jumplist navigation

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
mm         Set next mark in rotation (Q,W,E,R,T,Y,U,I,O,P) i2-extended*.vim
<C-o>      Jump to previous mark                           i2-extended*.vim
<C-i>      Jump to next mark                               i2-extended*.vim
:C         Clear all marks                                 i2-extended*.vim
:S         Show mark status                                i2-extended*.vim
```

## Navigation & Movement

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
<Up>       Move to previous blank line ({)                 i2-base.vim
<Down>     Move to next blank line (})                     i2-base.vim
s          Forward search (/)                              i2-base.vim
S          Backward search (?)                             i2-base.vim
j/k        Smart line navigation (visual/logical)          i3-*.vim
<CR>       Focus next window/editor group                  i2-base.vim / i3-vscode.vim
<Home>     Go to first non-blank character (^)             i2-base.vim
1v-9v      Select 1-9 visual lines                         i2-base.vim
```

## System Clipboard

```
Mapping    Function                                         Source
--------   ------------------------------------------       ---------------
<C-x>      Copy visual selection to system clipboard       i3-vim.vim
<C-a>      Yank entire buffer to system clipboard          i3-vim.vim
<C-p>      Replace entire buffer with clipboard            i3-vim.vim
```

## FZF Functions (g<Space>)

Type function name after `g<Space>`:

```
Function        Description                                  Source
-------------   ------------------------------------------   ---------------
BufferDiff      Compare current buffer with saved file      i4-fzf.vim
BufferList      Show buffer list via FZF                    i4-fzf.vim
OpenFinder      Open current file's directory in Finder     i4-fzf.vim
FilePath        Copy current file's full path to clipboard  i4-fzf.vim
FindFileAny     Open FZF file finder in any directory       i4-fzf.vim
FindFileLocal   Open FZF file finder in current directory   i4-fzf.vim
```

## Commands

```
Command    Function                                         Source
--------   ------------------------------------------       ---------------
:Byword    Open current file in Byword                     i3-vim.vim
```
