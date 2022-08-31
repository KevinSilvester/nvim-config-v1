-- https://github.com/pedro757/emmet
-- npm i -g ls_emmet

local cmd = {}

if vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16") then
   cmd = { "pwsh", "-c", "ls_emmet", "--stdio" }
else
   cmd = { "ls_emmet", "--stdio" }
end

return {
   cmd = { "pwsh", "-c", "ls_emmet", "--stdio" },
   filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "haml",
      "xml",
      "xsl",
      "pug",
      "slim",
      "sass",
      "stylus",
      "less",
      "sss",
      "hbs",
      "handlebars",
   },
}
