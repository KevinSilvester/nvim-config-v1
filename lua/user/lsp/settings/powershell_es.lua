local opts = {}

local IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"

local function bundle_path(path)
   path = path or ""

   local bp = "/mason/packages/powershell-editor-services/PowerShellEditorServices" .. path
   if IS_WINDOWS then
      bp = vim.fn.substitute(bp, "/", "\\", "g")
   end

   return vim.fn.stdpath("data") .. bp
end

local function log_path(file_name)
   file_name = IS_WINDOWS and vim.fn.substitute(file_name, "/", "\\", "g") or file_name
   return vim.fn.stdpath("cache") .. file_name
end

local pses_command = bundle_path("/Start-EditorServices.ps1")
   .. " -BundledModulesPath "
   .. bundle_path()
   .. " -LogPath "
   .. log_path("/pses.log")
   .. " -SessionDetailsPath "
   .. log_path("/pses-session.json")
   .. " -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal"

if vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16") then
   opts = {
      bundle_path = "C:/Users/kevin/lsp/PSES",
      cmd = {
         "pwsh",
         "-NoLogo",
         "-NoProfile",
         "-Command",
         pses_command,
      },
   }
end

return opts
