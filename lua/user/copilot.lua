-- -- config of 'github/copilot.vim'
-- vim.g.copilot_filetypes = { markdown = false }
-- vim.g.copilot_no_tab_map = true
-- vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- config for 'zbirenbaum/copilot.lua'
local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
   return
end

copilot.setup({
   cmp = {
      enabled = true,
      method = "getCompletionsCycling",
   },
   panel = { -- no config options yet
      enabled = false,
   },
   ft_disable = { "markdown" },
   plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
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
