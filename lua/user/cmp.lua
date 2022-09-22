local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
   return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
   return
end

local kind_icons = require("user.icons")

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
   local col = vim.fn.col(".") - 1
   return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#8cdb53" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrates", { fg = "#F64D00" })

local has_words_before = function()
   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
   end
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0
      and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
   },

   mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
         elseif luasnip.jumpable(1) then
            luasnip.jump(1)
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         elseif luasnip.expandable() then
            luasnip.expand()
            -- elseif check_backspace() then
            -- fallback()
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   }),

   formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
         vim_item.kind = kind_icons[vim_item.kind]

         if entry.source.name == "copilot" then
            vim_item.kind = kind_icons.Copilot
            vim_item.kind_hl_group = "CmpItemKindCopilot"
         end

         if entry.source.name == "emoji" then
            vim_item.kind = kind_icons.Emoji
            vim_item.kind_hl_group = "CmpItemKindEmoji"
         end

         if entry.source.name == "crates" then
            vim_item.kind = kind_icons.Crate
            vim_item.kind_hl_group = "CmpItemKindCrates"
         end

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            copilot = "[Copilot]",
            nvim_lua = "[Lua]",
            luasnip = "[Luasnip]",
            buffer = "[Buffer]",
            path = "[Path]",
            emoji = "[Emoji]",
            crates = "[Crates]",
         })[entry.source.name]
         return vim_item
      end,
   },

   sources = {
      { name = "crates", group_index = 1 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "copilot", max_item_count = 3, group_index = 2 },
      { name = "nvim_lua", group_index = 2 },
      { name = "luasnip", group_index = 2 },
      { name = "buffer", group_index = 2 },
      { name = "path", group_index = 2 },
   },

   confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
   },

   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },

   experimental = {
      ghost_text = true,
   },
   sorting = {
      priority_weight = 2,
      comparators = {
         -- require("copilot_cmp.comparators").prioritize,
         -- require("copilot_cmp.comparators").score,

         -- Below is the default comparitor list and order for nvim-cmp
         cmp.config.compare.offset,
         cmp.config.compare.exact,
         cmp.config.compare.score,
         cmp.config.compare.recently_used,
         cmp.config.compare.locality,
         -- cmp.config.compare.kind,
         cmp.config.compare.sort_text,
         cmp.config.compare.length,
         cmp.config.compare.order,
      },
   },
})
