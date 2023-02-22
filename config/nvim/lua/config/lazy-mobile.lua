local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup({

  "dstein64/vim-startuptime",
  "folke/which-key.nvim",
  "nvim-orgmode/orgmode",
  "anuvyklack/hydra.nvim",
  "anuvyklack/vim-smartword",
  "chaoren/vim-wordmotion",
  "drzel/vim-split-line",
  "mzlogin/vim-markdown-toc",
  "ervandew/supertab",
  "farmergreg/vim-lastplace",
  "lukas-reineke/indent-blankline.nvim",
  {
    "phaazon/hop.nvim",
    config = true,
  },
  -- "easymotion/vim-easymotion",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" } ,
  "nvim-telescope/telescope-file-browser.nvim",
  "crispgm/telescope-heading.nvim",
  "junegunn/vim-easy-align",
  {
    "kylechui/nvim-surround",
    config = true
  },
  "tpope/vim-commentary",
  "kyazdani42/nvim-web-devicons",
  {
    "itchyny/lightline.vim",
    lazy = false,
    dependencies = {
      {
        "challenger-deep-theme/vim",
        pin = true,
      },
    }
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "windwp/nvim-autopairs",
  "chrisbra/Colorizer",

  -- THEMES
  "ray-x/aurora",
  "theniceboy/nvim-deus",
  "mhartington/oceanic-next",
  "wuelnerdotexe/vim-enfocado",
  "savq/melange",
  "nyoom-engineering/oxocarbon.nvim",
  "EdenEast/Nightfox.nvim",
  {
    "sainnhe/edge",
  }

  -- 'junnplus/lsp-setup.nvim',
},
{
  defaults = {
  },
})

require("config.telescope")
require("config.pairs")
require("config.treesitter")
require("config.blankline")
require("config.hydra")

require("orgmode").setup{}
require("orgmode").setup_ts_grammar()

-- vim:sw=2:ts=2
