vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.relativenumber = true
vim.opt.number = true

if vim.g.neovide then
  vim.opt.guifont = "BerkeleyMono Nerd Font:h12"
end

require("lazy").setup("plugins", {})
