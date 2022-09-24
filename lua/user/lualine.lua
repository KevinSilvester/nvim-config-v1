local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
   return
end

local lualine_scheme = "kanagawa"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
   return
end

local SL = {}

SL.copilot_active = false

SL.available_modes = {
   ["n"] = { "NORMAL", "normal" },
   ["niI"] = { "NORMAL i", "normal" },
   ["niR"] = { "NORMAL r", "normal" },
   ["niV"] = { "NORMAL v", "normal" },
   ["no"] = { "N-PENDING", "normal" },
   ["i"] = { "INSERT", "insert" },
   ["ic"] = { "INSERT (completion)", "insert" },
   ["ix"] = { "INSERT completion", "insert" },
   ["t"] = { "TERMINAL", "command" },
   ["nt"] = { "NTERMINAL", "command" },
   ["v"] = { "VISUAL", "visual" },
   ["V"] = { "V-LINE", "visual" },
   ["Vs"] = { "V-LINE (Ctrl O)", "visual" },
   [""] = { "V-BLOCK", "visual" },
   ["R"] = { "REPLACE", "replace" },
   ["Rv"] = { "V-REPLACE", "replace" },
   ["s"] = { "SELECT", "replace" },
   ["S"] = { "S-LINE", "replace" },
   [""] = { "S-BLOCK", "replace" },
   ["c"] = { "COMMAND", "command" },
   ["cv"] = { "COMMAND", "command" },
   ["ce"] = { "COMMAND", "command" },
   ["r"] = { "PROMPT", "visual" },
   ["rm"] = { "MORE", "visual" },
   ["r?"] = { "CONFIRM", "visual" },
   ["!"] = { "SHELL", "command" },
}

SL.set_mode = function()
   local key = vim.api.nvim_get_mode().mode
   local title = SL.available_modes[key][1]
   local colors = SL.available_modes[key][2]

   if title == nil or colors == nil then
      title = "UNKNOWN"
      colors = "normal"
   end

   return { key = key, title = title, colors = colors }
end

SL.cur_mode = SL.set_mode()

SL.sep = { left = "", right = "" }

SL.hl_str = function(str, hl)
   return "%#" .. hl .. "#" .. str .. "%*"
end

SL.diff_source = function()
   local gitsigns = vim.b.gitsigns_status_dict
   if gitsigns then
      return {
         added = gitsigns.added,
         modified = gitsigns.changed,
         removed = gitsigns.removed,
      }
   end
end

SL.colors = {
   green = "#98be65",
   red = "#ec5f67",
   yellow = "#ECBE7B",
   win_bg = string.format("#%x", vim.api.nvim_get_hl_by_name("Normal", true).background),
   sl_bg = string.format("#%x", vim.api.nvim_get_hl_by_name("StatusLine", true).background),
}

-- Abbreviations:
--    - SL: Status Line
--    - AP: Accent Primary
--    - AS: Accent Secondary
--    - RI: Right Inner
--    - RO: Right Outer
--    - LI: Left Inner
--    - LO: Left Outer
--    - S: Separator
--    - T: Text
SL.set_dynamic_hl = function(mode)
   vim.api.nvim_set_hl(0, "SL_AP_T", { bg = theme[mode].a.bg, fg = theme[mode].a.fg })
   vim.api.nvim_set_hl(0, "SL_AS_T", { bg = theme[mode].b.bg, fg = theme[mode].b.fg })
   vim.api.nvim_set_hl(0, "SL_AP_O_S", { bg = SL.colors.win_bg, fg = theme[mode].a.bg })
   vim.api.nvim_set_hl(0, "SL_AP_I_S", { bg = SL.colors.sl_bg, fg = theme[mode].a.bg })
   vim.api.nvim_set_hl(0, "SL_AS_I_S", { bg = SL.colors.sl_bg, fg = theme[mode].b.bg })
end

-- local left_pad = {
--   function()
--     return " "
--   end,
--   padding = 0,
--   color = function()
--     return { fg = gray }
--   end,
-- }
--
-- local right_pad = {
--   function()
--     return " "
--   end,
--   padding = 0,
--   color = function()
--     return { fg = dark_gray }
--   end,
-- }
--
-- local left_pad_alt = {
--   function()
--     return " "
--   end,
--   padding = 0,
--   color = function()
--     return { fg = gray }
--   end,
-- }
--
local right_pad_alt = {
   function()
      return ""
   end,
   padding = 0,
   color = { bg = SL.colors.sl_bg },
}

local mode = {
   "mode",
   fmt = function(str)
      SL.cur_mode = SL.set_mode()
      SL.set_dynamic_hl(SL.cur_mode.colors)
      return SL.hl_str(SL.cur_mode.title, "SL_AP_T")
   end,
   color = { gui = "bold" },
   separator = { left = SL.hl_str(SL.sep.left, "SL_AP_O_S"), right = SL.hl_str(SL.sep.right, "SL_AP_I_S") },
   padding = 0,
}

local branch = {
   "b:gitsigns_head",
   icon = " ",
   color = { gui = "bold", bg = SL.colors.sl_bg },
}

local filename = {
   "filename",
   separator = { left = "", right = SL.sep.right },
   icons_enabled = true,
   icon = " ",
   color = { gui = "bold", bg = SL.colors.sl_bg },
   padding = { left = 0, right = 1 },
}
local diff = {
   "diff",
   source = SL.diff_source,
   symbols = { added = "  ", modified = " ", removed = " " },
   diff_color = {
      added = { fg = SL.colors.green },
      modified = { fg = SL.colors.yellow },
      removed = { fg = SL.colors.red },
   },
   color = { bg = "#252535" },
}

local diagnostics = {
   "diagnostics",
   sources = { "nvim_diagnostic" },
   sections = { "error", "warn" },
   symbols = { error = " ", warn = " " },
   diagnostics_color = {
      error = { fg = SL.colors.red },
      warn = { fg = SL.colors.yellow },
   },
   colored = true,
   color = { bg = "#252535" },
   always_visible = true,
   update_in_insert = true,
}

local treesitter = {
   function()
      return ""
   end,
   color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and SL.colors.green or SL.colors.red }
   end,
}

local copilot = {
   function()
      return ""
   end,
   color = function()
      return { fg = SL.copilot_active and SL.colors.green or SL.colors.red }
   end,
}
local lsp = {
   function()
      local buf_clients = vim.lsp.buf_get_clients(0)
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
         if client.name ~= "copilot" and client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
         end
         if client.name == "copilot" then
            SL.copilot_active = true
         end
      end

      local s = require("null-ls.sources")
      local available_sources = s.get_available(buf_ft)
      local buf_fmt_names = {}

      -- add formatter
      for _, source in ipairs(available_sources) do
         for _ in pairs(source.methods) do
            table.insert(buf_fmt_names, source.name)
         end
      end

      local unique_client_names = vim.fn.uniq(buf_client_names)
      local unique_fmt_names = vim.fn.uniq(buf_fmt_names)

      local str_client = #unique_client_names > 0 and table.concat(unique_client_names, ", ") or "No LS"
      local str_fmt = #unique_fmt_names > 0 and table.concat(unique_fmt_names, ", ") or "No Formatter"

      return "[" .. str_client .. "][" .. str_fmt .. "]"
   end,
   icons_enabled = true,
   icon = "",
   color = { gui = "bold" },
}

local formatters = {
   icons_enabled = true,
   icon = "",
}

local encoding = {
   "encoding",
   separator = { left = SL.sep.left, right = "" },
   icons_enabled = true,
   icon = "",
   color = { bg = SL.colors.sl_bg },
   padding = { left = 1, right = 1 },
}

local filetype = {
   "filetype",
   icons_enabled = true,
   color = { gui = "bold", bg = SL.colors.sl_bg },
}

local progress = {
   "progress",
   fmt = function(str)
      return "%l/%L"
   end,
   icons_enabled = true,
   color = { gui = "bold" },
   icon = "",
   separator = { left = SL.hl_str(SL.sep.left, "SL_AP_I_S"), right = SL.hl_str(SL.sep.right, "SL_AP_O_S") },
   padding = 0,
}

lualine.setup({
   options = {
      globalstatus = true,
      icons_enabled = true,
      theme = lualine_scheme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
   },
   sections = {
      lualine_a = { mode },
      lualine_b = { branch, filename },
      lualine_c = { diff, diagnostics },
      lualine_x = { lsp, copilot, treesitter },
      lualine_y = { encoding, filetype },
      lualine_z = { progress },
   },
})
