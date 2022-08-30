local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
   return
end

local servers = {
   "awk_ls",
   "bashls",
   "cmake",
   "cssls",
   "dockerls",
   "emmet_ls",
   "eslint",
   "gopls",
   "html",
   "intelephense",
   "jdtls",
   "jsonls",
   "marksman",
   "rust_analyzer",
   "sqls",
   "sumneko_lua",
   "svelte",
   "tailwindcss",
   "taplo",
   "tsserver",
   "vuels",
   "yamlls",
   "powershell_es",
}

-- local servers = lsp_installer.get_installed_servers()

lsp_installer.setup({ ensure_installed = servers })

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
   return
end

local opts = {}

for _, server in pairs(servers) do
   opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
   }

   local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

   if has_custom_opts then
      opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
   end

   lspconfig[server].setup(opts)

   -- if server == "powershell_es" then
   --    opts = vim.tbl_deep_extend(
   --       "force",
   --       {
   --          bundle_path = "C:/Users/kevin/lsp/PSES",
   --          cmd = {
   --             "pwsh",
   --             "-NoLogo",
   --             "-NoProfile",
   --             "-Command",
   --             "$env:HOMEPATH/lsp/PSES/Start-EditorServices.ps1 -BundledModulesPath $env:HOMEPATH/lsp/PSES -LogPath $env:TMP/logs.log -SessionDetailsPath $env:TMP/session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal"
   --          },
   --       },
   --       opts
   --    )
   -- end
end
