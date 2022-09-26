local utils = require("plugins.utils")
local M = {}

-- bootstrap packer
M.bootstrap_packer = function()
   local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
   local gh_link = "https://github.com/wbthomason/packer.nvim.git"
   if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f1f28" })
      print("Cloning packer...")
      vim.fn.system({ "git", "clone", "--depth", "1", gh_link, install_path })

      print("Installing plugins...")
      vim.cmd([[packadd packer.nvim]])
      return true
   end
   return false
end

M.load_plugins = function()
   local packer = utils.load_plugin("packer")
   if packer == nil then
      return
   end

   packer.init(require("plugins.config.packer"))

   packer.startup(function(use)
      use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })

      --[[ Packer ]]
      use({
         "wbthomason/packer.nvim",
         opt = true,
         commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422",
      })

      --
      --[[ Essentials ]]
      use({ "goolord/alpha-nvim", event = "VimEnter", commit = "09e5374465810d71c33e9b097214adcdebeee49a" })
      use({ "nvim-lua/plenary.nvim", event = "VimEnter", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" })
      use({ "nvim-lua/popup.nvim", event = "VimEnter", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" })
      use({ "windwp/nvim-autopairs", event = "VimEnter", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" })
      use({
         "kyazdani42/nvim-web-devicons",
         event = "VimEnter",
         commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e",
      })
      use({ "moll/vim-bbye", event = "VimEnter", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
      use({
         "ahmedkhalf/project.nvim",
         event = "VimEnter",
         commit = "541115e762764bc44d7d3bf501b6e367842d3d4f",
      })
      use({
         "lukas-reineke/indent-blankline.nvim",
         event = "VimEnter",
         commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2",
      })
      use({ "folke/which-key.nvim", event = "VimEnter", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" })

      --
      --[[ Comments ]]
      use({ "numToStr/Comment.nvim", event = "VimEnter", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
      use({
         "JoosepAlviste/nvim-ts-context-commentstring",
         event = "VimEnter",
         commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269",
      })
      use({
         "folke/todo-comments.nvim",
         event = "VimEnter",
         commit = "02eb3019786d9083b93ab9457761899680c6f3ec",
      })

      --
      --[[ FileExplorer/Sidebar ]]
      use({
         "kyazdani42/nvim-tree.lua",
         event = "VimEnter",
         commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243",
      })

      --
      --[[ StatusLine/Windbar ]]
      use({
         "akinsho/bufferline.nvim",
         event = "VimEnter",
         commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353",
      })
      use({
         "nvim-lualine/lualine.nvim",
         requires = { "kyazdani42/nvim-web-devicons", opt = true },
         commit = "a52f078026b27694d2290e34efa61a6e4a690621",
      })
      use({
         "SmiteshP/nvim-navic",
         event = "VimEnter",
         commit = "94bf6fcb1dc27bdad230d9385da085e72c390019",
         requires = "neovim/nvim-lspconfig",
      })

      --
      --[[ Terminal ]]
      use({ "akinsho/toggleterm.nvim", opt = true, commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })

      --
      --[[ ColorShemes ]]
      use({ "folke/tokyonight.nvim", opt = true })
      use({ "lunarvim/darkplus.nvim", opt = true })
      use({ "lunarvim/onedarker.nvim", opt = true })
      use({ "rebelot/kanagawa.nvim", opt = true })
      use({
         "catppuccin/nvim",
         as = "catppuccin",
         config = function()
            require("catppuccin").setup()
         end,
         opt = true,
      })

      --
      --[[ cmp plugins ]]
      use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" })
      use({ "hrsh7th/cmp-buffer", after = "nvim-cmp", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" })
      use({ "hrsh7th/cmp-path", after = "nvim-cmp", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" })
      use({ "hrsh7th/cmp-emoji", after = "nvim-cmp", commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" })
      use({
         "saadparwaiz1/cmp_luasnip",
         after = "nvim-cmp",
         commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36",
      })
      use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
      use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
      use({ "windwp/nvim-ts-autotag", commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" })
      use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" }) -- command completions

      --
      --[[ snippets ]]
      use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" })
      use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" })

      --
      --[[ LSP ]]
      use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" })
      use({ "williamboman/mason.nvim", commit = "5e028cb5377e1c3a201d9f689d75f440e3fe468e" })
      use({
         "williamboman/mason-lspconfig.nvim",
         commit = "74c45b3663aeb4c9065a4b29355d9c1c8a8c00b5",
      })
      use({
         "jose-elias-alvarez/null-ls.nvim",
         commit = "95068cf961fe699a2ebf914e0fddce55c27519b2",
      })
      use({ "ray-x/lsp_signature.nvim", commit = "e65a63858771db3f086c8d904ff5f80705fd962b" })
      use({ "folke/lsp-colors.nvim", commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3" })
      use({ "folke/lua-dev.nvim" }) -- not commit as still in early development
      use({ "b0o/schemastore.nvim" }) -- no commit as new schemas are being added
      -- use({ "onsails/lspkind.nvim" }) -- cmp dropdown formatter

      --
      --[[ Copilot ]]
      -- use({ "github/copilot.vim" })
      use({
         "zbirenbaum/copilot.lua",
         commit = "3d3f6a312e49c8333681c8163dc32f88b120ede5",
         event = { "VimEnter" },
         config = function()
            vim.defer_fn(function()
               require("user.copilot").setup_copilot()
            end, 100)
         end,
      })
      use({
         "zbirenbaum/copilot-cmp",
         commit = "a549a24eab37d6803555f40f292280ba01e686de",
         module = "copilot_cmp",
         after = { "copilot.lua", "nvim-cmp" },
         config = function()
            require("user.copilot").setup_copilot_cmp()
         end,
      })

      --
      --[[ Telescope ]]
      use({
         "nvim-telescope/telescope.nvim",
         commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0",
         requires = { { "nvim-lua/plenary.nvim" } },
      })
      if not vim.g.is_win then
         use({
            "nvim-telescope/telescope-media-files.nvim",
            commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c",
            after = "telescope.nvim",
         })
      end

      --
      --[[ Treesitter ]]
      use({
         "nvim-treesitter/nvim-treesitter",
         commit = "3b790e7657d6bb54245b5a70c2ae9355713d0b0c",
      })

      --
      --[[ Git ]]
      use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })
      use({
         "sindrets/diffview.nvim",
         commit = "e32de2be00e0b5e23736f906f3d6d9dca14fbeb0",
         requires = "nvim-lua/plenary.nvim",
      })

      --
      --[[ DAP ]]
      use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
      use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
      use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

      --
      --[[ Find and Replace ]]
      use({ "KevinSilvester/nvim-spectre" })

      --
      --[[ Rust ]]
      use({ "simrat39/rust-tools.nvim", commit = "b696e6dee1e79a53159f1c0472289f5486ac31bc" })
      use({
         "saecki/crates.nvim",
         requires = { "nvim-lua/plenary.nvim" },
      })

      --
      --[[ Java ]]
      use({ "mfussenegger/nvim-jdtls", commit = "782867324475c451427b7d972f886620da9c5167" })

      --
      --[[ Others/Utils ]]
      use({
         "rcarriga/nvim-notify",
         commit = "cf5dc4f7095673b8402c51bf80448596d7b97fc6",
         config = function()
            require("user.notify")
         end,
         requires = { "nvim-telescope/telescope.nvim" },
      })
      use({
         "karb94/neoscroll.nvim",
         event = "VimEnter",
         config = function()
            vim.defer_fn(function()
               -- require("config.neoscroll")
            end, 2000)
         end,
      })
      use({ "RRethy/vim-illuminate", event = "VimEnter", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })
      use({
         "iamcco/markdown-preview.nvim",
         commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
         run = "cd app && yarn",
         setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
         end,
         ft = { "markdown" },
      })
      use({
         "wfxr/minimap.vim",
         opt = true,
         commit = "3801d9dfaa5431e7b83ae6f98423ac077d9f5c3f",
         run = "cargo install --locked code-minimap",
      })
      use({
         "kylechui/nvim-surround",
         event = "VimEnter",
         commit = "b9946a3585842852ac3d46e1df82802e54322295",
      })
      use({
         "mattn/emmet-vim",
         commit = "def5d57a1ae5afb1b96ebe83c4652d1c03640f4d",
         event = "VimEnter",
         branch = "master",
      })
      use({
         "mg979/vim-visual-multi",
         commit = "e23b98a8852255766e54bf7723a9d61fb5ab3143",
         branch = "master",
         event = "VimEnter",
      })
      use({
         "stevearc/dressing.nvim",
         event = "VimEnter",
         commit = "9cdb3e0f0973447b940b35d3175dc780301de427",
      })
      use({
         "j-hui/fidget.nvim",
         commit = "492492e7d50452a9ace8346d31f6d6da40439f0e",
         config = function()
            require("fidget").setup({})
         end,
      })
   end)
end
