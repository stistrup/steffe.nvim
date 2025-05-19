-- lua/custom/plugins/init.lua (or your main plugin file)
return {
  -- Your existing plugins:
  require 'custom.plugins.lsp-config', -- Ensure this is correctly set up for your LSPs
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    event = 'VeryLazy', -- Or ft = { "cs", "fs", "csproj", "fsproj", "sln" }
    config = function()
      require('easy-dotnet').setup()
    end,
  },

  -- NVIM-DAP AND DAP-UI (from previous response - keep this)
  {
    'mfussenegger/nvim-dap',
    -- ... (rest of the nvim-dap configuration as provided before) ...
    -- Make sure to include the full dap config from the previous answer
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
      {
        'rcarriga/nvim-dap-ui',
        config = function()
          require('dapui').setup()
        end,
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dotnet = require 'easy-dotnet'
      -- ... (rest of the dap configuration, rebuild_project, listeners, adapters, configurations for cs/fsharp)
      -- For brevity, I'm not repeating the full DAP config here, but you should include it.
      -- Refer to the previous response for the full block.
      -- Remember the part for dap.adapters.coreclr and dap.configurations[language]
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg', -- Ensure netcoredbg is installed and in PATH
        args = { '--interpreter=vscode' },
      }
      -- (Include the rest of the DAP setup: listeners, configurations for cs/fsharp, etc.)
    end,
  },

  -- ADD NVIM-CMP AND RELATED PLUGINS HERE
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- Load cmp when you enter insert mode
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- Source for LSP completions
      'hrsh7th/cmp-buffer', -- Source for buffer words
      'hrsh7th/cmp-path', -- Source for file system paths
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Integrates LuaSnip with nvim-cmp
      'rafamadriz/friendly-snippets', -- A good collection of snippets
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- This loads snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {} -- Basic luasnip setup

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- Previous item
          ['<C-j>'] = cmp.mapping.select_next_item(), -- Next item
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- Show completion suggestions
          ['<C-e>'] = cmp.mapping.abort(), -- Close completion window
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Confirm selection
        },
        -- Order of sources matters!
        sources = cmp.config.sources {
          { name = 'nvim_lsp' }, -- LSP suggestions
          { name = 'luasnip' }, -- Snippets
          { name = 'easy-dotnet' }, -- For .NET package completion in .csproj/.fsproj
          { name = 'buffer' }, -- Words from current buffer
          { name = 'path' }, -- File paths
        },
        experimental = {
          ghost_text = true, -- Shows a preview of the completion inline (requires Neovim 0.10+)
        },
      }

      -- IMPORTANT: Register the easy-dotnet source for package autocomplete
      -- This line tells nvim-cmp how to get completions from easy-dotnet.
      cmp.register_source('easy-dotnet', require('easy-dotnet').package_completion_source)
    end,
  },
}
