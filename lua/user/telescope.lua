local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
   vim.notify("telescope not found", vim.log.levels.ERROR)
   return
end

local actions = require("telescope.actions")

telescope.setup({
   defaults = {
      prompt_prefix = "  ",
      selection_caret = " ",
      path_display = { "truncate" },
      file_ignore_patterns = { "node_modules", "^.git/" },
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         width = 0.75,
         preview_cutoff = 120,
         horizontal = {
            prompt_position = "top",
            preview_width = function(_, cols, _)
               return (cols < 120) and math.floor(cols * 0.5) or math.floor(cols * 0.6)
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
         "--glob",
         "!.git/*",
      },

      set_env = { ["COLORTERM"] = "truecolor" },
      border = {},

      mappings = {
         i = {
            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
         },
      },

      preview = {
         mime_hook = function(filepath, bufnr, opts)
            local is_image = function(filepath)
               local image_extensions = { "png", "jpg", "jpeg", "ico", "gif" } -- Supported image formats
               local split_path = vim.split(filepath:lower(), ".", { plain = true })
               local extension = split_path[#split_path]
               return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
               local term = vim.api.nvim_open_term(bufnr, {})
               local function send_output(_, data, _)
                  for _, d in ipairs(data) do
                     vim.api.nvim_chan_send(term, d .. "\r\n")
                  end
               end
               vim.fn.jobstart({
                  "viu",
                  filepath, -- Terminal image viewer command
               }, { on_stdout = send_output, stdout_buffered = true })
            else
               require("telescope.previewers.utils").set_preview_message(
                  bufnr,
                  opts.winid,
                  "Binary cannot be previewed"
               )
            end
         end,
      },
   },
   pickers = {
      find_files = {
         hidden = true,
         find_command = {
            "rg",
            "--files",
            "--color=never",
            "--no-heading",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!.git/*",
         },
      },
      live_grep = {
         --@usage don't include the filename in the search results
         only_sort_text = true,
      },
      colorscheme = { enable_preview = true },
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
