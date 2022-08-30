local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
   return
end

local actions = require("telescope.actions")

telescope.setup({
   defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },

      sorting_order = "descending",
      layout_strategy = "horizontal",
      layout_config = {
         width = 0.75,
         preview_cutoff = 120,
         horizontal = {
            preview_width = function(_, cols, _)
               if cols < 120 then
                  return math.floor(cols * 0.5)
               end
               return math.floor(cols * 0.6)
            end,
            mirror = false,
         },
         vertical = { mirror = false },
      },

      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
         "--hidden",
         "--glob=!.git/",
      },

      set_env = { ["COLORTERM"] = "truecolor" },
      border = {},
      -- file_ignore_patterns = { "/^.git/" },

      mappings = {
         i = {
            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
         },
      },
   },
   pickers = {
      find_files = {
         hidden = true,
      },
      live_grep = {
         --@usage don't include the filename in the search results
         only_sort_text = true,
      },
   },
   extensions = {
      fzf = {
         fuzzy = true, -- false will only do exact matching
         override_generic_sorter = true, -- override the generic sorter
         override_file_sorter = true, -- override the file sorter
         case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
   },
})
