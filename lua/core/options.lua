-- local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
-- vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"
--
-- -- use filetype.lua instead of filetype.vim. it's enabled by default in neovim 0.8 (nightly)
-- if vim.version().minor < 8 then
--    vim.g.did_load_filetypes = 0
--    vim.g.do_filetype_lua = 1
-- end
--
-- -- to use windows clipboard in WSL add path of win32yank bundled with neovim for windows
-- if vim.fn.has("wsl") then
--    vim.g.clipboard = {
--       copy = {
--          ["+"] = "win32yank.exe -i --crlf",
--          ["*"] = "win32yank.exe -i --crlf",
--       },
--       paste = {
--          ["+"] = "win32yank.exe -o --lf",
--          ["*"] = "win32yank.exe -o --lf",
--       },
--    }
-- end
--
-- -- options for neovide
-- if vim.fn.exists("g:neovide") then
--    vim.g.neovide_refresh_rate = 60
--    vim.g.neovide_transparancey = 1
--    vim.g.neovide_fullscreen = false
--    vim.g.neovide_remember_window_size = true
-- end

vim.opt.laststatus = 3 -- global status
vim.opt.showmode = false

vim.opt.title = true
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cursorline = true -- highlight the current line

-- Numbers
vim.opt.relativenumber = true -- show relative numbers
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.ruler = false

-- Indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 3 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 3 -- insert 3 spaces for a tab
vim.opt.softtabstop = 3
vim.opt.showtabline = 0 -- always show tabs
vim.opt.smartindent = true -- make indenting smarter again

vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.fillchars.eob = " " -- characters to fill the statuslines and vertical separators
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.mouse = "a" -- allow the mouse to be used in neovim

vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.wrap = true -- don't display lines as one long line

-- interval for writing swapfile to disk, also used by gitsigs plgin
vim.opt.updatetime = 250

vim.opt.swapfile = false -- creates a swapfile
vim.opt.backup = false -- creates a backup file
vim.cmd("set nofsync")

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.showcmd = false
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = { "JetBrainsMono NF", ":h9" } -- the font used in graphical neovim applications

-- don't give the intro message when starting Vim |:intro|
-- http://vimdoc.sourceforge.net/htmldoc/options.html#'shortmess'
vim.opt.shortmess:append("I")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

vim.opt.iskeyword:append("-")

if vim.opt.filetype == "python" then
   vim.opt.shiftwidth = 4
   vim.opt.tabstop = 4
end

if vim.fn.executable("rg") == 1 then
   vim.opt.grepprg = "rg --vimgrep"
end

if is_windows then
   -- ref: https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#windows
   local powershell_options = {
      shell = vim.fn.executable("pwsh") and "pwsh" or "powershell",
      shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
      shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
      shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
      shellquote = "",
      shellxquote = "",
   }

   for option, value in pairs(powershell_options) do
      vim.opt[option] = value
   end
else
   vim.opt.shell = "fish"
end
