local cmd = { "rustup", "run", "stable" }

if vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16") then
   table.insert(cmd, vim.fn.stdpath("data") .. "mason\\bin\\rust_analyzer.cmd")
else
   table.insert(cmd, vim.fn.stdpath("data") .. "mason/bin/rust_analyzer")
end

return {
   tools = {
      -- autoSetHints = false,
      on_initialized = function()
         vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            pattern = { "*.rs" },
            callback = function()
               vim.lsp.codelens.refresh()
            end,
         })
      end,

      inlay_hints = {
         -- automatically set inlay hints (type hints)
         -- default: true
         auto = true,

         -- Only show inlay hints for the current line
         only_current_line = false,

         -- whether to show parameter hints with the inlay hints or not
         -- default: true
         show_parameter_hints = true,

         -- prefix for parameter hints
         -- default: "<-"
         parameter_hints_prefix = "<- ",

         -- prefix for all the other hints (type, chaining)
         -- default: "=>"
         other_hints_prefix = "=> ",

         -- whether to align to the lenght of the longest line in the file
         max_len_align = false,

         -- padding from the left if max_len_align is true
         max_len_align_padding = 1,

         -- whether to align to the extreme right or not
         right_align = false,

         -- padding from the right if right_align is true
         right_align_padding = 7,

         -- The color of the hints
         highlight = "Comment",
      },
      hover_actions = {
         auto_focus = false,
         border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
         },
      },
   },
   server = {
      cmd = cmd,
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,

      settings = {
         ["rust-analyzer"] = {
            lens = {
               enable = true,
            },
            checkOnSave = {
               command = "clippy",
            },
         },
      },
   },
}
-- return {
--   settings = {
--     rust_analyzer = {
--       inlayHints = {
--         bindingModeHints = {
--           enable = true,
--         },
--         typeHints = {
--           enable = true,
--           hideClosureInitialization = false,
--           hideNamedConstructor = false,
--         },
--         chainingHints = {
--           enable = true,
--         },
--         closingBraceHints = {
--           enable = true,
--           minLines = 25,
--         },
--         closureReturnTypeHints = {
--           enable = "never",
--         },
--         lifetimeElisionHints = {
--           enable = "never",
--           useParameterNames = false,
--           maxLength = 25,
--         },
--         parameterHints = {
--           enable = true,
--         },
--         reborrowHints = {
--           enable = "never",
--         },
--         renderColons = true,
--       },
--     },
--   },
-- }
