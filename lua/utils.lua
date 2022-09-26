local popup_ok, Popup = pcall(require, "nui.popup")
local split_ok, Split = pcall(require, "nui.split")
local autocmd_ok, nui_autocmd = pcall(require, "nui.utils.autocmd")
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

---print vim.inspect output to a popup window/buffer
---@param input any input can by anything that vim.inspect is able to parse
---@param yank boolean|nil wheather to copy the ouput to clipboard
---@param open_split boolean|nil whether to use popup window
---@return nil
M.inspect = function(input, yank, open_split)
   if input == nil then
      vim.notify("No input provided", vim.log.levels.WARN, { title = "nvim-config" })
      return
   end
   if not popup_ok or not split_ok or not autocmd_ok then
      vim.notify("Failed to load 'nui' modules", vim.log.levels.ERROR, { title = "nvim-config" })
      return
   end
   open_split = (open_split == nil) and false or open_split
   yank = (yank == nil) and false or yank

   local output = vim.inspect(input)
   local component

   if open_split then
      component = Split({
         enter = true,
         relative = "win",
         position = "bottom",
         size = "20%",
         buf_options = { modifiable = true, readonly = false },
      })
   else
      component = Popup({
         enter = true,
         focusable = true,
         border = { style = "rounded" },
         position = "50%",
         size = { width = "80%", height = "60%" },
         buf_options = { modifiable = true, readonly = false },
      })
   end

   vim.defer_fn(function()
      component:mount()

      component:map("n", "q", function()
         component:unmount()
      end, { noremap = true })

      component:on({ "BufLeave", "BufDelete", "BufWinLeave" }, function()
         vim.schedule(function()
            component:unmount()
         end)
      end, { once = true })

      vim.api.nvim_buf_set_lines(component.bufnr, 0, 1, false, vim.split(output, "\n"))

      if yank then
         vim.cmd(component.bufnr .. "b +%y")
      end
   end, 750)
end

--
------------------------------------------------------------------------
--                  utility functions for colours                     --
------------------------------------------------------------------------
-- ref: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/colors.lua
M.colors = {}

---convert hex colour to rgb
---@param hex_str string hex colour (e.g.'#7E9CD8')
---@return table {r, g, b} color values
M.colors.hex_to_rgb = function(hex_str)
   local hex = "[abcdef0-9][abcdef0-9]"
   local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
   hex_str = string.lower(hex_str)

   assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

   local red, green, blue = string.match(hex_str, pat)
   return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
M.colors.blend = function(fg, bg, alpha)
   bg = M.colors.hex_to_rgb(bg)
   fg = M.colors.hex_to_rgb(fg)

   local blendChannel = function(i)
      local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
      return math.floor(math.min(math.max(0, ret), 255) + 0.5)
   end

   return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

---darken a hex colour
---@param hex string hex colour (e.g.'#7E9CD8')
---@param amount number 
---@param bg string background colour
---@return string
M.colors.darken = function(hex, amount, bg)
   return M.colors.blend(hex, bg, math.abs(amount))
end

return M
