local M = {}

M.active_clients = {}
M.copilot_active = false

M.get_active_clients = function()
   local buf_clients = vim.lsp.buf_get_clients(0)
   local buf_client_names = {}

   -- add client
   for _, client in pairs(buf_clients) do
      if client.name ~= "copilot" and client.name ~= "null-ls" then
         table.insert(buf_client_names, client.name)
      end
      if client.name == "copilot" then
         M.copilot_active = true
      end
   end

   return vim.fn.uniq(buf_client_names)
end

return M
