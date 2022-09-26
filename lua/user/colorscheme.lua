local cs_name = "kanagawa"

local cs_ok, cs = pcall(require, cs_name)
if not cs_ok then
   return
end

local utils = require("utils")

if cs_name == "catppuccin" then
   vim.g.catppuccin_flavour = "mocha"
   cs.setup()
end

if cs_name == "kanagawa" then
   local palette_colors = require("kanagawa.colors").setup()
   local darkening_percentage = 0.095
   local ucolors = utils.colors

   local bg = palette_colors.sumiInk1
   local error = palette_colors.samuraiRed
   local warn = palette_colors.roninYellow
   local info = palette_colors.waveAqua1
   local hint = palette_colors.dragonBlue

   local set_hl = function(color)
      return {
         fg = color,
         bg = ucolors.darken(color, darkening_percentage, bg),
         italic = true,
      }
   end

   cs.setup({
      theme = "default",
      typeStyle = { italic = true },
      overrides = {
         StatusLineNC  = { bg = "#ffffff"},
         DiagnosticVirtualTextError = set_hl(error),
         DiagnosticVirtualTextWarn = set_hl(warn),
         DiagnosticVirtualTextInfo = set_hl(info),
         DiagnosticVirtualTextHint = set_hl(hint),
      },
   })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. cs_name)
if not status_ok then
   return
end
