local os_name = vim.loop.os_uname().sysname

local opts = {}

if os_name == "Windows_NT" then
   opts = {
      bundle_path = "C:/Users/kevin/lsp/PSE",
      cmd = {
         "pwsh",
         "-NoLogo",
         "-NoProfile",
         "-Command",
         "$env:HOMEPATH/lsp/PSES/Start-EditorServices.ps1 -BundledModulesPath $env:HOMEPATH/lsp/PSES -LogPath $env:TMP/logs.log -SessionDetailsPath $env:TMP/session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 1.0.0 -Stdio -LogLevel Normal",
      },
   }
end

return opts
