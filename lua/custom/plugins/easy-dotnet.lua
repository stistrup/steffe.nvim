return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim' },
  config = function()
    local function get_secret_path(secret_guid)
      local path = ""
      local home_dir = vim.fn.expand('~')
      if require("easy-dotnet.extensions").isWindows() then
        local secret_path = home_dir ..
        '\\AppData\\Roaming\\Microsoft\\UserSecrets\\' .. secret_guid .. "\\secrets.json"
        path = secret_path
      else
        local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
        path = secret_path
      end
      return path
    end
    
    local dotnet = require("easy-dotnet")
    dotnet.setup({
      secrets = {
        path = get_secret_path
      },
      csproj_mappings = true,
      fsproj_mappings = false,
      auto_bootstrap_namespace = {
        type = "block_scoped",
        enabled = true
      },
      background_scanning = true
    })
  end
}
