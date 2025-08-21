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

## G-Key Mappings

### Navigation & File Operations
- `gf` - Find files
  - **VSCode**: Quick open (`workbench.action.quickOpen`)
  - **Vim**: Ripgrep search in files (RG command)
- `gF` - Find files by type (vim only - Python/Markdown files)
- `g-` - **VSCode**: Show explorer (`workbench.view.explorer`)
- `ga` - **VSCode**: Show command palette (`workbench.action.showCommands`)

### Code Navigation
- `gd` - Go to definition (built-in vim/VSCode)
- `gI` - **VSCode**: Go to implementation (`editor.action.goToImplementation`)
- `gR` - **VSCode**: Go to references (`editor.action.goToReferences`)

### Code Actions & Refactoring  
- `gr` - **VSCode**: Rename (`editor.action.rename`)
- `g<CR>` - **VSCode**: Quick fix (`editor.action.quickFix`)
- `g=` - **VSCode**: Format document (`editor.action.formatDocument`)

### Documentation & Hover
- `gh` - **VSCode**: Show hover (`editor.action.showHover`)
- `gt` - **VSCode**: Show hover (`editor.action.showHover`)

### Error Navigation
- `ge` - **VSCode**: Next error (`editor.action.marker.nextInFiles`)
- `gE` - **VSCode**: Previous error (`editor.action.marker.prevInFiles`)

### Debugging & Running
- `go` - **VSCode**: Execute in terminal (`python.execInTerminal-icon`)
- `gO` - **VSCode**: Debug run (`workbench.action.debug.run`)

### Text Operations
- `gs` - Replace current word (vim only - starts replace command for word under cursor)
- `gp` - Paste from yank register (register "0)

### Standard Vim (not overridden)
- `g;` - Jump to last change (changelist backward)
- `g,` - Jump to next change (changelist forward)

## Custom Mark System

**Note**: Overrides standard `<C-o>`/`<C-i>` jumplist navigation

### Mark Management
- `mm` - Set next mark in rotation (uses marks Q,W,E,R,T,Y,U,I,O,P)
  - **VSCode**: Uses VSCode Bookmarks extension
  - **Vim**: Custom rotating mark system
- `<C-o>` - Jump to previous mark
- `<C-i>` - Jump to next mark

### Mark Commands
- `:C` - Clear all marks
- `:S` - Show mark status/list all bookmarks

## Movement & Navigation

### Arrow Key Remaps
- `<Up>` - Move to previous blank line (`{`)
- `<Down>` - Move to next blank line (`}`)

### Search Shortcuts
- `s` - Forward search (`/`)
- `S` - Backward search (`?`)

### Smart Line Navigation
- `j` - Visual line down (or logical line with count)
- `k` - Visual line up (or logical line with count)

### Visual Line Selection Shortcuts
- `1v` through `9v` - Select 1-9 visual lines
  - Example: `3v` selects current line + 2 below (`V2j`)

### Window Navigation
- `<CR>` - Focus next window/split (vim) / Focus next editor group (VSCode)

### Home Key
- `<Home>` - Go to first non-blank character (`^`)

## Insert Mode Mappings

### Completion Navigation
- `<Down>` - Next completion item (`<C-n>`)
- `<Up>` - Previous completion item (`<C-p>`)
- `<Shift-Left>` - Exit completion menu or move cursor left

### macOS Compatibility
- `<C-d>` - Delete character forward (like macOS)

## System Clipboard Operations

### Copy to Clipboard
- `<C-x>` - Copy visual selection to system clipboard (visual mode)

### Special Paste
- `<F5>` - Replace entire buffer with clipboard (with confirmation prompt)

## FZF Functions (Available via `g<leader>`)

Type the function name after `g<Space>`:

- **BufferDiff** - Compare current buffer with saved file on disk
- **OpenFinder** - Open current file's directory in macOS Finder
- **FilePath** - Copy current file's full path to system clipboard
- **FindFileAny** - Open FZF file finder in any directory
- **FindFileLocal** - Open FZF file finder in current file's directory

## File Type Support

### Current Focus
- **Python** (`.py`) files
- **Markdown** (`.md`) files

### Excluded Directories
- `Library/`
- `Pictures/`
- Target directories (build artifacts)

## Environment-Specific Features

### VSCode Only
- All `g`-prefixed VSCode commands
- VSCode Bookmarks integration
- Editor group management

### Terminal Vim Only  
- FZF file operations
- Custom mark rotation system
- Dirvish file browser integration
- Custom statusline with undo tracking

### macOS Terminal vs Other Terminals
- **Apple Terminal**: PaperColor theme, basic clipboard ops
- **Other terminals**: VSCode theme, enhanced clipboard operations
