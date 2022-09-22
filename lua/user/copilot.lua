-- -- config of 'github/copilot.vim'
-- vim.g.copilot_filetypes = { markdown = false }
-- vim.g.copilot_no_tab_map = true
-- vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- config for 'zbirenbaum/copilot.lua'
local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
   return
end

local status_ok_1, copilot_cmp = pcall(require, "copilot_cmp")
if not status_ok then
   return
end

local M = {}

M.setup_copilot = function()
   copilot.setup({
      panel = {
         enabled = false,
      },
      ft_disable = { "markdown" },
      plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
      copilot_node_command = "node",
      server_opts_overrides = {
         trace = "verbose",
         settings = {
            advanced = {
               listCount = 10, -- #completions for panel
               inlineSuggestCount = 3, -- #completions for getCompletions
            },
         },
      },
   })
end

M.setup_copilot_cmp = function()
   copilot_cmp.setup({
      method = "getCompletionsCycling",
      force_autofmt = false,
      formatters = {
         label = require("copilot_cmp.format").format_label_text,
         insert_text = require("copilot_cmp.format").format_insert_text,
         preview = require("copilot_cmp.format").deindent,
      },
   })
end

return M
