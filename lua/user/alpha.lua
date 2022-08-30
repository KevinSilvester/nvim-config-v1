local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
   return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠶⠶⢦⣤⡀⣀⣀⣀⣀⣀⡀⣤⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡋⠀⠀⠀⠀⠀⠼⠟⣻⣶⣾⣽⠋⠹⠿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠡⠞⢻⠟⠛⠯⣅⣀⠀⠀⠉⠉⠀⠁⠀⠀⠀⠻⠟⠷⢦⣶⣶⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣁⡄⠀⠀⠀⠀⠀⠀⠙⢻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠀⢾⣿⣽⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⢀⡴⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⢁⣿⣇⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⠿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⢠⡾⠀⡶⠚⠀⠀⠀⠀⣀⠀⣠⣤⡀⠀⣴⢷⠀⣷⣀⠀⢠⣼⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠆⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⣿⢡⣼⠁⠀⠀⠀⠀⣾⣿⡿⠿⠋⠛⠓⠿⣦⣤⣿⣿⣷⣾⣿⣿⣶⣿⣿⠃⢀⠀⣶⣀⡄⠀⢻⣿⣿⣶⡾⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⢠⣧⡿⠃⠀⢠⢶⣶⡟⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣿⡿⢅⣵⣶⣤⣿⣿⡉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⢠⣿⠟⠀⣰⣾⠿⣻⠟⠁⠀⠀⠀⠀⠀⠀⠀⣀⣶⣿⣿⣿⣿⣿⣿⣿⠿⢉⠉⣹⡿⢿⣿⣯⣯⢉⣟⡋⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠨⠏⣴⠞⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⢠⣤⣤⣿⣿⣿⣿⣿⣿⣿⣹⠃⠀⠘⢁⣽⣯⣯⡅⠼⠏⠸⢿⡇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⢠⣇⣿⠏⠀⣼⣿⡾⠃⠀⠀⠀⠀⣠⣄⣟⣿⣿⣿⣿⣿⣟⣻⣿⣿⡏⠀⠀⠀⠈⠉⠃⠙⢿⡆⠀⠀⠀⠉⣧⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⣾⡟⡗⣰⠿⠛⠀⠀⣀⣐⢻⣞⣿⣿⣿⣿⣿⣿⣾⡟⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⢀⣴⣫⣿⣷⠃⠀⠀⠀⠀⢳⣾⣿⣿⣿⣿⣿⡿⢿⣟⣿⣷⣿⣿⣿⡟⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⢸⣧⡄⠀⣬⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⡿⣮⣿⡏⠈⠀⠀⠈⣿⣮⣳⡄⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⡆⠀]],
   [[⠈⢻⣇⢠⠏⠀⠀⠀⢸⣿⣯⣿⣽⣿⣿⣿⠛⠙⠻⣿⠀⢀⣀⢀⠀⣿⣿⣿⠿⣢⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡶⢶⣆⣀⣤⣤⣴⣶⠿⠟⠋⠁⠀⡀]],
   [[⠀⢸⣏⣸⣤⠄⣴⣾⣿⢿⣿⣿⣿⠿⠉⠀⢠⣴⣗⡀⢀⣼⣿⣿⣿⠿⣞⠋⠳⢜⣳⢽⣛⣓⢀⣀⣶⣚⣻⣿⣿⠀⠘⣿⣿⣿⣿⡯⣴⣖⡷⢴⠚⠋⠀]],
   [[⠀⠈⠻⣼⢿⠘⠛⡟⢿⣄⢿⣿⡇⠀⠀⠀⢙⣿⣿⣿⣿⣿⣿⣷⡿⣷⡈⠳⢶⣚⠻⣷⣾⣿⣿⣧⠬⠿⣿⣿⣉⣿⣷⣿⣿⣿⣿⣿⣷⣤⠤⠀⠀⠀⠀]],
   [[⠀⠀⠀⠸⣾⠛⠀⣷⣿⣾⣿⠷⠂⠀⠀⠀⢹⣿⣿⣿⣿⣿⣯⣿⣝⢮⡙⢯⣅⡛⠻⠷⠿⢿⣿⣿⣿⣿⣿⡟⠉⢹⣿⣽⣿⡿⣿⡶⠶⠶⠂⢀⣤⠀⠀]],
   [[⠀⠀⠀⠀⠘⣇⡀⢻⣻⡟⠀⢠⣤⣤⣠⣤⣼⣿⣿⣿⣿⣿⣿⣿⡟⢿⣮⣍⠉⠉⠉⠛⠲⣶⣿⣿⣿⡿⠃⠀⠲⠟⣿⣷⣾⣻⣿⠿⠀⠈⠉⠁⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠘⠻⣼⣿⣿⠀⠀⣿⣿⣿⣿⣿⣿⢻⡷⣌⠛⢿⢿⡛⠶⣬⣍⣑⣂⣀⣀⣠⣶⡶⠟⠉⠀⢀⣷⣶⣿⣟⢛⣛⡛⠉⠀⠀⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠘⠋⠛⢦⣀⣿⣿⣿⣿⣏⣿⣷⣝⣌⠳⡀⢀⠙⣖⣾⠟⠻⣟⣉⣉⣉⣉⣀⣀⣤⡖⠋⠉⠙⠛⢿⣿⣋⣿⣶⣶⣦⣤⡄⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣯⡿⣯⢿⡛⢫⣛⣻⣾⣿⣿⣴⡯⠷⣤⣄⠙⢻⡧⢤⡴⠶⢛⣁⣠⠄⠀⠀⢀⣠⣿⣿⣾⣿⣿⣭⡿⠇⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⠾⢾⣿⣶⣬⣿⣿⡽⠟⠀⠀⣼⣿⡟⠿⣦⣿⣦⣽⣾⠿⠷⠖⠛⠛⠋⠉⠀⠀⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀]],
   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠉⠈⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}
dashboard.section.buttons.val = {
   dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
   dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
   dashboard.button(
      "p",
      " " .. " Find project",
      ":lua require('telescope').extensions.projects.projects()<CR>"
   ),
   dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
   dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
   dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
   dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
local function footer()
   return "Kevin Silvester"
end

-- dashboard.section.footer.val = os.date("%Y-%m-%d  %H:%M:%S")
-- dashboard.section.footer.val = {
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀            " .. os.date("%Y-%m-%d  %H:%M:%S") .. "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
-- }

dashboard.section.footer.val = {
   os.date("%Y-%m-%d  %H:%M:%S"),
   "   Kevin Silvester",
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.buttons.opts.position = "right"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
