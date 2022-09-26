local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
   return
end

local status_navic, navic = pcall(require, "nvim-navic")
if not status_navic then
   return
end

-- local lualine_theme = vim.g.colors_name
local lualine_theme = "kanagawa"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_theme)
if not status_theme_ok then
   return
end

local utils = require("utils")
local mode_utils = require("user.lualine.mode_utils")
local diff_utils = require("user.lualine.diff_utils")
local lsp_utils = require("user.lualine.lsp_utils")
local fmt_utils = require("user.lualine.fmt_utils")

local SL = {
   sep = { left = "", right = "" },
   hl_str = function(str, hl)
      return "%#" .. hl .. "#" .. str .. "%*"
   end,
   colors = {
      green = "#98be65",
      red = "#ec5f67",
      yellow = "#ECBE7B",
      win_bg = string.format("#%x", vim.api.nvim_get_hl_by_name("Normal", true).background),
      sl_comp = string.format("#%x", vim.api.nvim_get_hl_by_name("StatusLine", true).background),
   },
}

SL.set_hl = function(mode)
   vim.api.nvim_set_hl(0, "SLTextPrimary", { bg = theme[mode].a.bg, fg = theme[mode].a.fg })
   vim.api.nvim_set_hl(0, "SLTextSecondary", { bg = theme[mode].b.bg, fg = theme[mode].b.fg })
   vim.api.nvim_set_hl(0, "SLSepPrimaryOuter", { bg = SL.colors.win_bg, fg = theme[mode].a.bg })
   vim.api.nvim_set_hl(0, "SLSepPrimaryInner", { bg = SL.colors.sl_comp, fg = theme[mode].a.bg })
   vim.api.nvim_set_hl(0, "SLSepSecondaryInner", { bg = SL.colors.sl_comp, fg = theme[mode].b.bg })
end

local sl_base = utils.colors.darken("#2a2a37", 0.5, SL.colors.sl_comp)

--
--[[ Section a ]]
local mode = {
   "mode",
   fmt = function(str)
      mode_utils.refresh()
      SL.set_hl(mode_utils.highlight)
      return SL.hl_str(mode_utils.label, "SLTextPrimary")
   end,
   color = { gui = "bold" },
   separator = {
      left = SL.hl_str(SL.sep.left, "SLSepPrimaryOuter"),
      right = SL.hl_str(SL.sep.right, "SLSepPrimaryInner"),
   },
   padding = 0,
}

--
--[[ Section b ]]
local branch = {
   "b:gitsigns_head",
   icon = " ",
   color = { gui = "bold", bg = SL.colors.sl_comp },
}

local filename = {
   "filename",
   separator = { left = "", right = SL.sep.right },
   icons_enabled = true,
   icon = " ",
   color = { gui = "bold", bg = SL.colors.sl_comp },
   padding = { left = 0, right = 1 },
}

--
--[[ Section c ]]
local diff = {
   "diff",
   source = diff_utils.diff_source,
   symbols = { added = "  ", modified = " ", removed = " " },
   diff_color = {
      added = { fg = SL.colors.green },
      modified = { fg = SL.colors.yellow },
      removed = { fg = SL.colors.red },
   },
   color = { bg = sl_base },
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
   color = { bg = sl_base },
   always_visible = true,
   update_in_insert = true,
}

--
------------------------------------------------------------------------
--                           Right Section                            --
------------------------------------------------------------------------
--
--[[ Section x ]]
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
      return { fg = lsp_utils.copilot_active and SL.colors.green or SL.colors.red, bg = sl_base }
   end,
}

local lsp = {
   function()
      local active_lsp_clients = lsp_utils.get_active_clients()
      local active_fomatters = fmt_utils.get_active_fmts()

      local str_client = #active_lsp_clients > 0 and table.concat(active_lsp_clients, ", ") or "No LS"
      local str_fmt = #active_fomatters > 0 and table.concat(active_fomatters, ", ") or "No Formatter"

      return "[" .. str_client .. "][" .. str_fmt .. "]"
   end,
   icons_enabled = false,
   icon = "",
   color = { bg = sl_base, gui = "bold" },
}

--[[ Section y ]]
local encoding = {
   "encoding",
   icons_enabled = false,
   icon = "",
   color = { bg = SL.colors.sl_comp },
   -- padding = { left = 1, right = 1 },
   padding = { left = 0, right = 1 },
}

local fileformat = {
   "fileformat",
   symbols = {
      unix = "", -- ebc6
      mac = "", -- e302
      dos = "", -- e70f
   },
   separator = { left = SL.sep.left, right = "" },
   color = { bg = SL.colors.sl_comp },
   padding = { left = 1, right = 1 },
}

local filetype = {
   "filetype",
   icons_enabled = true,
   color = { gui = "bold", bg = SL.colors.sl_comp },
}

--
--[[ Section z ]]
local progress = {
   "progress",
   fmt = function(str)
      return "%l/%L"
   end,
   icons_enabled = true,
   color = { gui = "bold" },
   icon = "",
   separator = {
      left = SL.hl_str(SL.sep.left, "SLSepPrimaryInner"),
      right = SL.hl_str(SL.sep.right, "SLSepPrimaryOuter"),
   },
   padding = 0,
}

lualine.setup({
   options = {
      globalstatus = true,
      icons_enabled = true,
      theme = lualine_theme,
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
      lualine_y = { fileformat, encoding, filetype },
      lualine_z = { progress },
   },
})

vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = sl_base, fg = "#ffffff" })
