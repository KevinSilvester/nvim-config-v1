local M = {}

---@param plugin_name string
---@return nil|table
M.load_plugin = function(plugin_name)
   local is_present, plugin = pcall(require, plugin_name)

   if is_present then
      return plugin
   else
      vim.notify(
         "Plugin " .. plugin_name .. " not found",
         vim.log.levels.ERROR,
         { title = "nvim-config" }
      )
      return nil
   end
end

return M
