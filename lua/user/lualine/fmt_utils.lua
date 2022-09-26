local M = {}

M.active_fmts = {}

M.get_active_fmts = function()
   local buf_ft = vim.bo.filetype
   local s = require("null-ls.sources")
   local available_sources = s.get_available(buf_ft)
   local buf_fmt_names = {}

   -- add formatter
   for _, source in ipairs(available_sources) do
      for _ in pairs(source.methods) do
         table.insert(buf_fmt_names, source.name)
      end
   end

   return vim.fn.uniq(buf_fmt_names)
end

return M
