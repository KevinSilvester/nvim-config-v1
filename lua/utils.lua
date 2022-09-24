local fn = vim.fn

local M = {}

---check whether executable is callable
---@param name string name of executable
---@return boolean
M.executable = function(name)
   if fn.executable(name) == 1 then
      return true
   end
   return false
end

---check whether a feature exists in Nvim
---@param feat string the feature name, like `nvim-0.7` or `unix`
---@return boolean
M.has = function(feat)
   if fn.has(feat) == 1 then
      return true
   end
   return false
end

return M
