return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    -- Setup mason to manage our LSP servers
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- Define servers configuration exactly as in the guide
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
      -- TypeScript
      ts_ls = { -- Note: nvim-lspconfig uses 'tsserver', not 'ts_ls'
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
      -- You can add other servers here if needed
    }

    -- Set up each LSP server
    local lspconfig = require 'lspconfig'
    for server_name, server_settings in pairs(servers) do
      lspconfig[server_name].setup {
        filetypes = server_settings.filetypes,
        init_options = server_settings.init_options,
        settings = server_settings.settings,
      }
    end

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
