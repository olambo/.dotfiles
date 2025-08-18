# Vim Key Mappings Reference

**Leader Key:** `<Space>`

## Leader Key Mappings (`<leader>` = `<Space>`)

### Basic Editor Functions
- `<leader>n` - Toggle line numbers (and disable relative numbers)
- `<leader>h` - Toggle highlight search with status display
- `<leader>k` - Toggle buffer modifiable/view mode with status
- `<leader><leader>` - Enter command mode (`:`)

### Window/Split Management
- `<leader>v` - Split window vertically
- `<leader>s` - Split window horizontally  
- `<leader>f` - Close current window/buffer
  - In vim: `:conf q` (confirm quit)
  - In VSCode: close active editor

### Buffer Management
- `<leader>b` - Show buffer list (FZF Buffers)

### Clipboard Operations
- `<leader>a` - Yank entire buffer to system clipboard (non-Apple Terminal only)

### FZF Functions (via `g<leader>`)
- `g<leader>` - Open FZF menu with custom functions from `lkeyFunctions`
  - **Usage**: `g<Space>` → type function name (fuzzy search) → `<Enter>`
  - Example: `g<Space>` → type "buf" → `<Enter>` to run BufferDiff

## G-Key Mappings

### Navigation & File Operations
- `g-` - Recent files (IntelliJ) / Show all editors by recently used (VSCode) / Select in project view (IntelliJ)
- `gf` - Find files
  - IntelliJ: Go to file
  - VSCode: Quick open
  - Vim: Ripgrep search in files
- `gF` - Find in path (IntelliJ) / Custom file search (Vim)
- `ga` - Search everywhere (IntelliJ) / Show commands (VSCode)

### Code Navigation
- `gd` - Go to declaration/definition
- `gi` - Go to implementation
- `gI` - Go to implementation (VSCode specific)

### Code Actions & Refactoring  
- `gr` - Refactoring quick list (IntelliJ) / Rename (VSCode)
- `gR` - Show usages (IntelliJ) / Go to references (VSCode)
- `g<CR>` - Show intention actions (IntelliJ) / Quick fix (VSCode)
- `g=` - Reformat/format code

### Documentation & Type Info
- `gh` - Quick documentation/show hover
- `gH` - Show hover info (IntelliJ)
- `gt` - Expression type info (IntelliJ) / Show hover (VSCode)

### Code Structure
- `gs` - File structure popup (IntelliJ) / Replace current word (Vim)
- `gS` - Go to super method (IntelliJ)

### Navigation History
- `g;` - Jump to last change
- `g,` - Jump to next change

### Error Navigation
- `ge` - Go to next error
- `gE` - Go to previous error

### Debugging & Running
- `go` - Context run (IntelliJ) / Execute in terminal (VSCode)
- `gO` - Debug (IntelliJ) / Debug run (VSCode)
- `gb` - Toggle line breakpoint (IntelliJ)
- `gB` - View breakpoints (IntelliJ)

### Bookmarks (IntelliJ)
- `gm` - Toggle bookmark
- `gM` - Show bookmarks

### Clipboard Operations
- `gp` - Paste from yank register (register "0)

## Other Notable Mappings

### Arrow Key Remaps
- `<Up>` - Move to previous blank line (`{`)
- `<Down>` - Move to next blank line (`}`)
- `<Left>` - Method up (IntelliJ)
- `<Right>` - Method down (IntelliJ)

### Search Shortcuts
- `s` - Forward search (`/`)
- `S` - Backward search (`?`)

### Visual Line Selection
- `1v` through `9v` - Select 1-9 visual lines (e.g., `3v` = `V2j`)

### Multiple Cursors (IntelliJ)
- `<Alt-j>` - Clone caret below
- `<Alt-k>` - Clone caret above
- `<Alt-l>` - Next whole occurrence
- `<Ctrl-Alt-l>` - Next occurrence
- `<Shift-Alt-l>` - Skip occurrence
- `<Alt-h>` - Remove occurrence

### Window Navigation
- `<CR>` - Focus next window/group

### Special Functions (via FZF menu)
Available through `g<leader>`:
- BufferDiff - Compare buffer with saved file
- OpenFinder - Open current directory in Finder
- FilePath - Copy file path to clipboard
- FindFileAny - FZF in any directory
- FindFileLocal - FZF in current file's directory

## File Type Specific

### Insert Mode
- `<Shift-Left>` - Exit completion menu or backspace

### Movement
- `j`/`k` - Smart line navigation (visual lines by default, logical with count)
- `<Home>` - Go to first non-blank character (`^`)

### Function Keys
- `<F5>` - Replace entire buffer with clipboard (with confirmation)

### System Clipboard
- `<C-x>` - Copy selection to system clipboard (visual mode)
