local utils = require("utils")

-- command to act as alias for custom inspect function
vim.api.nvim_create_user_command("Inspect", function(opts)
   vim.cmd("lua require('utils').inspect(" .. opts.args .. ")")
   -- utils.inspect(opts.args)
end, {
   nargs = 1,
   complete = function(ArgLead, CmdLine, CursorPo)
      return { "lua" }
   end,
})

-- command to get the hex colour values for Hl group
vim.api.nvim_create_user_command("InspectHl", function(opts)
   -- list all highlight groups
   local hl_groups = vim.api.nvim_exec(":highlight", true)
   hl_groups.gsub(hl_groups, " ", "")
   local hs = vim.api.nvim_get_hl_by_name(opts.args, true)
   hs.bg_hex = string.format("#%x", hs.bg)
   hs.fb_hex = string.format("#%x", hs.fg)
   utils.inspect(hs)
   -- vim.cmd("lua require('utils').inspect(" .. opts.args .. ")")
end, {
   nargs = 1,
   complete = function(ArgLead, CmdLine, CursorPo)
      return { "highlight" }
   end,
})
