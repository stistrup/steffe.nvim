return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")
    local api = require("nvim-tree.api")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Custom on_attach function for keymaps
    local function on_attach(bufnr)
      local opts = { buffer = bufnr }
      
      -- Load default mappings first
      api.config.mappings.default_on_attach(bufnr)
      
      -- Custom h/l navigation
      local lefty = function()
        local node = api.tree.get_node_under_cursor()
        if (node.name == ".." or node.nodes) and node.open then
          api.node.open.edit()
        else
          api.node.navigate.parent()
        end
      end
      
      local righty = function()
        local node = api.tree.get_node_under_cursor()
        if (node.name == ".." or node.nodes) and not node.open then
          api.node.open.edit()
        end
      end
      
      vim.keymap.set("n", "h", lefty, opts)
      vim.keymap.set("n", "<Left>", lefty, opts)
      vim.keymap.set("n", "l", righty, opts)
      vim.keymap.set("n", "<Right>", righty, opts)
    end

    nvimtree.setup({
      on_attach = on_attach,
      view = {
        width = 50,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
