## File Explorer

- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Toggle file explorer on current file
- `<leader>ec` - Collapse file explorer
- `<leader>er` - Refresh file explorer

## Fuzzy Finding (Telescope)

- `<leader>ff` - Fuzzy find files in cwd
- `<leader>fr` - Fuzzy find recent files
- `<leader>fs` - Find string in cwd
- `<leader>fc` - Find string under cursor in cwd
(tab to select results, ctrl + q to add to quick fix list)

## Substitute Operations

- `<leader>r` - Substitute with motion (normal mode)
- `<leader>rr` - Substitute line
- `<leader>R` - Substitute to end of line
- `<leader>r` - Substitute in visual mode
## Number Operations

- `<leader>+` - Increment number
- `<leader>-` - Decrement number
## Window Splits

- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split
- `<leader>sm` - Maximize/restore window
## Tabs

- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` - Go to next tab
- `<leader>tp` - Go to previous tab
- `<leader>tf` - Open current buffer in new tab
## Sessions/Workspaces

- `<leader>wr` - Restore session for cwd
- `<leader>ws` - Save session for auto session root dir

## Surround
- **Add** - `ys{motion}{char}`
- **Delete** - `ds{char}`
- **Change** - `cs{target}{replacement}`

|Old text|Command|New text|
|---|---|---|
|`surr*ound_words`|`ysiw)`|`(surround_words)`|
|`surr*ound_words`|`ysiw(`|`( surround_words )`|
|`*make strings`|`ys$"`|`"make strings"`|
|`[delete ar*ound me!]`|`ds]`|`delete around me!`|
|`remove <b>HTML t*ags</b>`|`dst`|`remove HTML tags`|
|`'change quot*es'`|`cs'"`|`"change quotes"`|
|`<b>or tag* types</b>`|`csth1<CR>`|`<h1>or tag types</h1>`|
|`delete(functi*on calls)`|`dsf`|`function calls`|
# LSP
## Navigation

- `gR` - Show LSP references (Telescope)
- `gD` - Go to declaration
- `gd` - Show LSP definition
- `gi` - Show LSP implementations (Telescope)
- `gt` - Show LSP type definitions (Telescope)
- `K` - Show documentation for what is under cursor

## Code Actions

- `<leader>ca` - See available code actions (normal/visual mode)
- `<leader>rn` - Smart rename

## Diagnostics

- `<leader>D` - Show buffer diagnostics (Telescope)
- `<leader>d` - Show line diagnostics (floating window)
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic

## LSP Management

- `<leader>rs` - Restart LSP

# Autocompletion (nvim-cmp) Keymaps

## Completion Menu Navigation

- `<C-k>` - Select previous suggestion
- `<C-j>` - Select next suggestion
- `<C-b>` - Scroll documentation up
- `<C-f>` - Scroll documentation down

## Completion Actions

- `<C-Space>` - Trigger/show completion suggestions
- `<CR>` (Enter) - Confirm selected completion
- `<C-e>` - Close completion window/abort
