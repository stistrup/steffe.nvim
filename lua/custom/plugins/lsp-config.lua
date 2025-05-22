return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    -- Setup mason to manage our LSP servers
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { "omnisharp" }
    })
    
    -- Define servers configuration
    local servers = {
      -- Vue 3
      volar = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
        settings = {
          typescript = {
            inlayHints = {
              enumMemberValues = {
                enabled = true,
              },
              functionLikeReturnTypes = {
                enabled = true,
              },
              propertyDeclarationTypes = {
                enabled = true,
              },
              parameterTypes = {
                enabled = true,
                suppressWhenArgumentMatchesName = true,
              },
              variableTypes = {
                enabled = false,
              },
            },
          },
        },
      },
      
      -- TypeScript (fixed the server name)
      ts_ls = { -- Changed from ts_ls to tsserver
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
              languages = { 'vue' },
            },
          },
        },
        settings = {
          typescript = {
            server = {
              useSyntaxServer = false,
            },
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
    }
    
    -- Set up each LSP server
    local lspconfig = require 'lspconfig'
    
    -- Set up non-OmniSharp servers
    for server_name, server_settings in pairs(servers) do
      lspconfig[server_name].setup {
        filetypes = server_settings.filetypes,
        init_options = server_settings.init_options,
        settings = server_settings.settings,
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      }
    end
    
    -- Set up OmniSharp separately with its specific configuration
    lspconfig.omnisharp.setup {
      -- Use the Mason-installed OmniSharp executable with correct parameters
      cmd = { 
        vim.fn.stdpath("data") .. "/mason/bin/omnisharp", 
        "--languageserver", 
        "--hostPID", 
        tostring(vim.fn.getpid())
      },
      
      -- Important: Define root_dir to detect .NET projects properly
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
      
      -- Settings for OmniSharp
      settings = {
        RoslynExtensionsOptions = {
          enableAnalyzersSupport = true,
        },
        FormattingOptions = {
          enableEditorConfigSupport = true,
        },
        OmniSharp = {
          useModernNet = true,
          enableImportCompletion = true,
          organizeImportsOnFormat = true,
        },
      },
      
      -- Get enhanced capabilities for completion, etc.
      capabilities = require('blink.cmp').get_lsp_capabilities(),
      
      -- File types (default is fine, but being explicit)
      filetypes = { "cs", "vb" },
    }
    
    -- Enable inlay hints
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end
      end,
    })
  end,
}
