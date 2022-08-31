local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
   return
end

local M = {}

M.copilot_active = false

local function diff_source()
   local gitsigns = vim.b.gitsigns_status_dict
   if gitsigns then
      return {
         added = gitsigns.added,
         modified = gitsigns.changed,
         removed = gitsigns.removed,
      }
   end
end

local colors = {
   green = "#98be65",
   red = "#ec5f67",
   yellow = "#ECBE7B",
}

local hide_in_width = function()
   return vim.fn.winwidth(0) > 80
end

local branch = {
   "b:gitsigns_head",
   icon = " ",
   color = { gui = "bold" },
}

local diagnostics = {
   "diagnostics",
   sources = { "nvim_diagnostic" },
   sections = { "error", "warn" },
   symbols = { error = " ", warn = " " },
   colored = false,
   always_visible = true,
}

local diff = {
   "diff",
   source = diff_source,
   symbols = { added = "  ", modified = " ", removed = " " },
   diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
   },
}

local filetype = {
   "filetype",
   icons_enabled = false,
}

local location = {
   "location",
   padding = 0,
}

local treesitter = {
   function()
      return ""
   end,
   color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
   end,
}

local hl_str = function(str, hl)
   return "%#" .. hl .. "#" .. str .. "%*"
end

local lsp = {
   function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()

      if next(buf_clients) == nil then
         -- TODO: clean up this if statement
         if type(msg) == "boolean" or #msg == 0 then
            return "LS Inactive"
         end
         return msg
      end

      local buf_ft = vim.bo.filetype
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

      local s = require("null-ls.sources")
      local available_sources = s.get_available(buf_ft)
      local buf_fmt_names = {}

      -- add formatter
      for _, source in ipairs(available_sources) do
         for method in pairs(source.methods) do
            table.insert(buf_fmt_names, source.name)
         end
      end

      local unique_client_names = vim.fn.uniq(buf_client_names)
      local unique_fmt_names = vim.fn.uniq(buf_fmt_names)

      local str_client = table.concat(unique_client_names, ", ") or "No LS"
      local str_fmt = table.concat(unique_fmt_names, ", ") or "No Formatter"

      return "[" .. str_client .. " ▍ " .. str_fmt .. "]"
   end,
   color = { gui = "bold" },
}

local copilot = {
   function()
      return ""
   end,
   color = function()
      return { fg = M.copilot_active and colors.green or colors.red }
   end,
}

local spaces = function()
   return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
   options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { branch, "filename" },
      lualine_c = { diff, diagnostics },
      lualine_x = { treesitter, copilot, lsp, "encoding", filetype },
      lualine_y = { location },
      lualine_z = { "progress" },
   },
})
