local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
   return
end

local client_notifs = {}
local function get_notif_data(client_id, token)
   if not client_notifs[client_id] then
      client_notifs[client_id] = {}
   end

   if not client_notifs[client_id][token] then
      client_notifs[client_id][token] = {}
   end

   return client_notifs[client_id][token]
end

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
   local notif_data = get_notif_data(client_id, token)

   if notif_data.spinner then
      local new_spinner = (notif_data.spinner + 1) % #spinner_frames
      notif_data.spinner = new_spinner

      notif_data.notification = vim.notify(nil, nil, {
         hide_from_history = true,
         icon = spinner_frames[new_spinner],
         replace = notif_data.notification,
      })

      vim.defer_fn(function()
         update_spinner(client_id, token)
      end, 100)
   end
end

local function format_title(title, client_name)
   return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
   return (percentage and percentage .. "%\t" or "") .. (message or "")
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

-- table from lsp severity to vim severity.
local severity = {
   "error",
   "warn",
   "info",
   "info", -- map both hint and info to info?
}

M.setup = function()
   local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
   }

   for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
   end

   vim.diagnostic.config({
      virtual_text = true, -- show virtual text
      signs = {
         active = signs, -- show signs
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
         focusable = true,
         style = "minimal",
         border = "rounded",
         source = "always",
         header = "",
         prefix = "",
      },
   })

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
   })

   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
   })

   vim.lsp.handlers["$/progress"] = function(_, result, ctx)
      local client_id = ctx.client_id

      local val = result.value

      if not val.kind then
         return
      end

      local notif_data = get_notif_data(client_id, result.token)

      if val.kind == "begin" then
         local message = format_message(val.message, val.percentage)

         -- ERROR here!!!
         notif_data.notification = vim.notify(message, "info", {
            title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
            icon = spinner_frames[1],
            timeout = false,
            hide_from_history = false,
         })

         notif_data.spinner = 1
         update_spinner(client_id, result.token)
      elseif val.kind == "report" and notif_data then
         notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
            replace = notif_data.notification,
            hide_from_history = false,
         })
      elseif val.kind == "end" and notif_data then
         notif_data.notification =
            vim.notify(val.message and format_message(val.message) or "Complete", "info", {
               icon = "",
               replace = notif_data.notification,
               timeout = 3000,
            })

         notif_data.spinner = nil
      end
   end
end

local function lsp_keymaps(bufnr)
   local opts = { noremap = true, silent = true }
   local keymap = vim.api.nvim_buf_set_keymap
   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
   keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
   keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
   keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
   keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
   keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
   keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
   keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
   keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local function attach_navic(client, bufnr)
   vim.g.navic_silence = true
   local status_ok, navic = pcall(require, "nvim-navic")
   if status_ok then
      navic.attach(client, bufnr)
   end
end

M.on_attach = function(client, bufnr)
   if client.name == "tsserver" then
      client.resolved_capabilities.document_formatting = false
   end

   if client.name == "sumneko_lua" then
      client.resolved_capabilities.document_formatting = false
   end

   if client.name == "rust_analyzer" then
      client.resolved_capabilities.document_formatting = false
   end

   if client.name == "jdt.ls" then
      vim.lsp.codelens.refresh()
      if JAVA_DAP_ACTIVE then
         require("jdtls").setup_dap({ hotcodereplace = "auto" })
         require("jdtls.dap").setup_dap_main_class_configs()
      end
   end

   lsp_keymaps(bufnr)
   attach_navic(client, bufnr)

   local status_ok, illuminate = pcall(require, "illuminate")
   if not status_ok then
      return
   end
   illuminate.on_attach(client)
end

return M
