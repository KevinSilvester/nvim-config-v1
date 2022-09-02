local status_ok, mason = pcall(require, "mason")
if not status_ok then
   return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
   return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
   return
end

local servers = {
   "awk_ls",
   "bashls",
   "cmake",
   "cssls",
   "dockerls",
   "emmet_ls",
   "grammarly",
   "gopls",
   "html",
   "intelephense",
   "jsonls",
   "marksman",
   "powershell_es",
   "rust_analyzer",
   "sqls",
   "sumneko_lua",
   "svelte",
   "tailwindcss",
   "taplo",
   "tsserver",
   "vuels",
   "yamlls",
}

mason.setup({
   ui = {
      border = "rounded",
      icons = {
         package_installed = "✓",
         package_pending = "➜",
         package_uninstalled = "✗",
      },
   },
   -- stylua: ignore
   keymaps = {
      toggle_package_expand = "<CR>",  -- Keymap to expand a package
      install_package = "i",           -- Keymap to install the package under the current cursor position
      update_package = "u",            -- Keymap to reinstall/update the package under the current cursor position
      check_package_version = "c",     -- Keymap to check for new version for the package under the current cursor position
      update_all_packages = "U",       -- Keymap to update all installed packages
      check_outdated_packages = "C",   -- Keymap to check which installed packages are outdated
      uninstall_package = "X",         -- Keymap to uninstall a package
      cancel_installation = "<C-c>",   -- Keymap to cancel a package installation
      apply_language_filter = "<C-f>", -- Keymap to apply language filter
   },
   log_level = vim.log.levels.INFO,
   max_concurrent_installers = 4,
})

mason_lspconfig.setup({
   ensure_installed = servers,
   automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
   opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
   }

   -- Advanced Configuration
   if server == "rust_analyzer" then
      local has_rust_opts, rust_opts = pcall(require, "user.lsp.settings.rust")
      local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
      if has_rust_opts and rust_tools_status_ok then
         rust_tools.setup(rust_opts)
      end
      goto continue
   end

   if server == "sumneko_lua" then
      local l_status_ok, lua_dev = pcall(require, "lua-dev")
      if not l_status_ok then
         return
      end
      local luadev = lua_dev.setup({
         lspconfig = {
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
         },
      })
      lspconfig.sumneko_lua.setup(luadev)
      goto continue
   end

   -- Basic Configuration
   local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

   if has_custom_opts then
      opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
   end

   lspconfig[server].setup(opts)

   ::continue::
end
