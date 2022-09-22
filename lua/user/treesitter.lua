local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
   return
end

local ensure_installed = {
   "bash",
   "c",
   "cmake",
   "comment",
   "cpp",
   "css",
   "dockerfile",
   "elvish",
   "fish",
   "gitattributes",
   "gitignore",
   "go",
   "graphql",
   "html",
   "http",
   "java",
   "javascript",
   "jsdoc",
   "json",
   "json5",
   "JSON with comments",
   "kotlin",
   "lua",
   "markdown",
   "markdown_inline",
   "meson",
   "nix",
   "python",
   "rasi",
   "regex",
   "ruby",
   "rust",
   "scss",
   "sql",
   "toml",
   "tsx",
   "typescript",
   "vim",
   "vue",
   "yaml",
}

configs.setup({
   ensure_installed,
   auto_install = true,
   ignore_install = { "" }, -- List of parsers to ignore installing
   highlight = {
      enable = true, -- false will disable the whole extension
   },
   autopairs = {
      enable = true,
   },
   indent = { enable = true, disable = { "python", "css" } },
})
