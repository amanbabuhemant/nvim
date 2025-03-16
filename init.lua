--[[ init.lua ]]--

-- Old Vimrc
-- vim.cmd("source ~/.config/nvim/vimrc.vim")



-- some options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""
vim.opt.tabstop = 4      -- Number of spaces for a tab
vim.opt.shiftwidth = 4   -- Number of spaces for auto-indent
vim.opt.expandtab = true -- Convert tabs to spaces


-- Error Mesages and wornigs
vim.diagnostic.config({
    virtual_text = {
        prefix = "\t\t●",
        spacing = 4,
    },
    signs = true,
    update_in_insert = false,
})




-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"



-- Setup lazy.nvim

require("lazy").setup({
    require("config.treesitter"),
    require("config.blink"),
    require("config.lsp_config"),
})

