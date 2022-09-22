local M = {}

-- bootstrap packer
M.bootstrap = function()
   local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
