local M = {}

M.check_for_plugin = function(plugin_name)
   local is_present, plugin = pcall(require, plugin_name)

   if is_present then
      return true, plugin
   else
      vim.notify("Plugin " .. plugin_name .. " not found", vim.log.levels.ERROR)
      return false, nil
   end
end
