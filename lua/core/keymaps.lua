-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local M = {}

-- Normal --
M.n = {
   -- Better window navigation
   ["<C-h>"] = "<C-w>h",
   ["<C-j>"] = "<C-w>j",
   ["<C-k>"] = "<C-w>k",
   ["<C-l>"] = "<C-w>l",

   -- Resize with arrows
   ["<A-J>"] = ":resize -2<CR>",
   ["<A-K>"] = ":resize +2<CR>",
   ["<A-H>"] = ":vertical resize -2<CR>",
   ["<A-L>"] = ":vertical resize +2<CR>",

   -- Navigate buffers
   ["<S-l>"] = ":bnext<CR>",
   ["<S-h>"] = ":bprevious<CR>",

   -- Move text up and down
   ["<A-j>"] = "<Esc>:m .+1<CR>==",
   ["<A-k>"] = "<Esc>:m .-2<CR>==",

   -- Clear highlights
   -- keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)
   -- ["<leader>h"] = "<cmd>nohlsearch<CR>",

   -- Close buffers
   ["<S-q>"] = "<cmd>Bdelete!<CR>",

   -- Delete Word
   ["<C-BS>"] = "<C-W>",

   -- Refresh NvimTree
   ["nr"] = "<cmd>NvimTreeRefresh<cr>",

   -- Copilot
   ["<S-CR>"] = "<cmd>copilot#Accept('\\<CR>')<CR><CR>",
}

-- Insert --
M.i = {
   -- Press jk fast to enter
   ["jk"] = "<ESC>",

   -- Move text up and down
   ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
   ["<A-k>"] = "<Esc>:m .-2<CR>==gi",

   -- Delete Word
   ["<C-BS>"] = "<C-W>",
}

-- Visual --
M.v = {
   -- Stay in indent mode
   ["<"] = "<gv",
   [">"] = ">gv",

   -- Better paste
   ["p"] = '"_dP',

   -- Delete Word
   ["<C-BS>"] = "<C-W>",
}

-- Visual Block --
M.x = {
   -- move selected line / block of text in visual mode
   ["J"] = ":move '>+1<CR>gv-gv",
   ["K"] = ":move '<-2<CR>gv-gv",
   ["A-j"] = ":move '>+<CR>gv-gv",
   ["A-k"] = ":move '<-2<CR>gv-gv",

   -- Comment
   ["<leader>/"] = "<esc><cmd>lua require('comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
}

-- Terminal Mode
M.t = {}

-- Command Mode
M.c = {}

-- Set keymaps
for mode, mode_values in pairs(M) do
   for lsh, rsh in pairs(mode_values) do
      keymap(mode, lsh, rsh, opts)
   end
end
