local M = {}
-- stylua: ignore
M.map = {
   ["n"]    = "NORMAL",
   ["no"]   = "O-PENDING",
   ["nov"]  = "O-PENDING",
   ["noV"]  = "O-PENDING",
   ["no\22"] = "O-PENDING",
   ["niI"]  = "NORMAL",
   ["niR"]  = "NORMAL",
   ["niV"]  = "NORMAL",
   ["nt"]   = "NORMAL",
   ["ntT"]  = "NORMAL",
   ["v"]    = "VISUAL",
   ["vs"]   = "VISUAL",
   ["V"]    = "V-LINE",
   ["Vs"]   = "V-LINE",
   ["\22"]  = "V-BLOCK",
   ["\22s"] = "V-BLOCK",
   ["s"]    = "SELECT",
   ["S"]    = "S-LINE",
   ["\19"]  = "S-BLOCK",
   ["i"]    = "INSERT",
   ["ic"]   = "INSERT",
   ["ix"]   = "INSERT",
   ["R"]    = "REPLACE",
   ["Rc"]   = "REPLACE",
   ["Rx"]   = "REPLACE",
   ["Rv"]   = "V-REPLACE",
   ["Rvc"]  = "V-REPLACE",
   ["Rvx"]  = "V-REPLACE",
   ["c"]    = "COMMAND",
   ["cv"]   = "EX",
   ["ce"]   = "EX",
   ["r"]    = "REPLACE",
   ["rm"]   = "MORE",
   ["r?"]   = "CONFIRM",
   ["!"]    = "SHELL",
   ["t"]    = "TERMINAL",
}

-- stylua: ignore
M.mode_to_highlight = {
   ["VISUAL"]  = "visual",
   ["V-BLOCK"] = "visual",
   ["V-LINE"]  = "visual",
   ["SELECT"]  = "visual",
   ["S-LINE"]  = "visual",
   ["S-BLOCK"] = "visual",
   ["REPLACE"] = "replace",
   ["V-REPLACE"] = "replace",
   ["INSERT"]  = "insert",
   ["COMMAND"] = "command",
   ["EX"]      = "command",
   ["MORE"]    = "command",
   ["CONFIRM"] = "command",
   ["TERMINAL"] = "normal",
}

---@return string current mode name
M.get_mode_label = function()
   local code = vim.api.nvim_get_mode().mode
   if M.map[code] == nil then
      return code
   end
   return M.map[code]
end

---@return string highlight group name
M.get_mode_highlight = function()
   local mode = M.get_mode_label()
   if M.mode_to_highlight[mode] == nil then
      return "normal"
   end
   return M.mode_to_highlight[mode]
end

M.refresh = function()
   M.label = M.get_mode_label()
   M.highlight = M.get_mode_highlight()
end

M.label = M.get_mode_label()
M.highlight = M.get_mode_highlight()

return M
