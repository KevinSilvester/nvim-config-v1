local utils = require("plugins.utils")
local packer_util = utils.load_plugin("packer.util")

if packer_util == nil then
   return
end

return {
   max_jobs = 50,
   display = {
      open_fn = function()
         return packer_util.float({ border = "rounded" })
      end,
   },
   prompt_border = "rounded",
   compile_path = packer_util.join_paths(vim.fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
}
