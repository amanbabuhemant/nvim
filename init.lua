--[[ init.lua ]]--


vim.cmd.colorscheme("zaibatsu")


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

 -- options and mappings
require("options")
require("mappings")

-- helpers
require("helpers")

-- Plugins

require("lazy").setup({
    require("plugins.treesitter"),
    require("plugins.blink"),
    require("plugins.lsp_config"),
    require("plugins.nerdtree"), -- file tree
    require("plugins.indent_line"), -- Indent line hint
    require("plugins.fzf"), -- fuzzy finder
    require("plugins.leetcode"), -- leetcode
    { "tmhedberg/SimpylFold" }, -- better codefolding
    { "jnurmine/Zenburn" }, -- colorscheme
    { "altercation/vim-colors-solarized" }, -- colorscheme
    { "danilo-augusto/vim-afterglow" }, -- colorscheme
    { "tribela/vim-transparent" }, -- Transparent
    { "kien/ctrlp.vim" }, -- Searching through vim
    { "tpope/vim-fugitive" }, -- git intigration
    { "Lokaltog/powerline" }, -- git powrline
    { "mattn/emmet-vim" }, -- HTML emmiting
    { "ap/vim-css-color" }, -- CSS colol preview
    { "wfxr/minimap.vim" }, -- code minimap
    { "preservim/tagbar" }, -- Class outline viewer
    { "vim-airline/vim-airline" }, -- Vim Airline
    { "tpope/vim-commentary" }, -- Commenting Shortcut
    {
        "wakatime/vim-wakatime", -- wakatime tracking
        lazy = false
    },
})

