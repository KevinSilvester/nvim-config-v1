local opts = {}

if vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16")then
   opts = {
      bundle_path = "C:/Users/kevin/lsp/PSES",
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
