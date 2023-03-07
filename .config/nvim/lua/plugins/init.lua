return {

  -- LIBRARIES

  "nvim-lua/plenary.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    config = false,
    opts = {
      override = {
        ["cs"] = {
          icon = "",
          color = "#95ffa4",
          name = "cs",
        },
        ["xml"] = {
          icon = "",
          color = "#ffb378",
          name = "xml",
        },
      },
      override_by_extension = {
        ["axaml"] = {
          icon = "",
          color = "#FFC3E1",
          name = "axaml",
        },
      },
    },
    dependencies = {},
  },

  -- OTHERS

  "voldikss/vim-floaterm",
  {
    "voldikss/vim-floaterm",
    config = false,
    cmd = {
      "FloatermToggle",
    },
    dependencies = {},
  },

  -- {
  --  "m00qek/baleia.nvim",
  --  config = false,
  --  dependencies = {},
  -- },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
    opts = {
      user_default_options = {
        names = false,
      },
    },
    dependencies = {},
  },

  -- MOTIONS

  "anuvyklack/vim-smartword",
  "chaoren/vim-wordmotion",
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true })
    end,
  },
  -- {
  --  "cbochs/grapple.nvim",
  --  dependencies = { "nvim-lua/plenary.nvim" },
  -- },
  {
    "anuvyklack/hydra.nvim",
    config = function()
      require("config.hydra")
    end,
  },
  {
    "phaazon/hop.nvim",
    config = true,
  },

  -- VISUAL

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.blankline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
    dependencies = {
      "ShinyZero0/challenger-deep.nvim",
    },
  },

  -- FILETYPES

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.treesitter")
    end,
    build = ":TSUpdate",
  },
  -- "Fymyte/rasi.vim",
  -- "lervag/vimtex",

  -- EDITING

  "zef/vim-cycle",
  "junegunn/vim-easy-align",

  {
    "sukima/xmledit",
    -- config = true,
    dependencies = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("config.pairs")
    end,
    dependencies = {},
  },

  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      "gc",
    },
    event = "ModeChanged *:[vV\x16]*",
  },

  {
    "tpope/vim-surround",
    config = false,
    -- opts = {},
    dependencies = {},
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = {
      "Spectre",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- "monaqa/dial.nvim",
  -- "alvan/vim-closetag",

  -- NAVIGATION

  "farmergreg/vim-lastplace",
  {
    "simrat39/symbols-outline.nvim",
    config = true,
    dependencies = {},
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   config = true,
  --   dependencies = {},
  -- },
  -- {
  --   "chentoast/marks.nvim",
  --   config = true,
  --   dependencies = {},
  -- },
  -- {
  --   "cbochs/grapple.nvim",
  --   config = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  {
    "LeonHeidelbach/trailblazer.nvim",
    config = true,
    dependencies = {},
  },
  {
    "ThePrimeagen/harpoon",
    -- config = function() end,
    -- keys = {
    --  { "<leader>m" },
    --  { "<leader>'" },
    -- },
    -- opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("config.neotree")
    end,
    branch = "v2.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = {
      "Telescope",
    },
    branch = "0.1.x",
    dependencies = {
      "crispgm/telescope-heading.nvim",
      -- "nvim-telescope/telescope-file-browser.nvim",
      "natecraddock/telescope-zf-native.nvim",
    },
  },

  -- LSP & CO

  {
    "sbdchd/neoformat",
    config = function() end,
    cmd = {
      "Neoformat",
    },
    opts = {},
    dependencies = {},
  },
  -- {
  --     "ray-x/lsp_signature.nvim",
  --     config = true,
  -- },
  -- 'junnplus/lsp-setup.nvim',
  -- "jay-babu/mason-null-ls.nvim",
  -- "jose-elias-alvarez/null-ls.nvim",
  -- "mfussenegger/nvim-lint",
  -- "mhartington/formatter.nvim",

  -- COMPLETION and SNIPPETS

  {
    "gelguy/wilder.nvim",
    config = function()
      require("wilder").setup({
        modes = { ":", "/" },
      })
     local wilder = require("wilder")
     wilder.set_option("pipeline", {
       wilder.branch(
         wilder.cmdline_pipeline({
           language = "python",
           fuzzy = 1,
         }),
         wilder.python_search_pipeline({
           pattern = wilder.python_fuzzy_pattern(),
           sorter = wilder.python_difflib_sorter(),
           engine = "re",
         })
       ),
     })
    end,
    build = {
      -- "pip install wheel && pip install pyre2"
      -- requires re2-devel
    },
    dependencies = {
      {
        "roxma/nvim-yarp",
        build = { "pip install -r requirements.txt", ":UpdateRemotePlugins" }
      }
    },
    -- event = { "CmdLineEnter" },
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    config = function()
      require("config.nvim-cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- {
      --   "hrsh7th/cmp-nvim-lua",
      --   cond = function()
      --     if vim.bo.filetype == "lua" then
      --       return true
      --     else
      --       return false
      --     end
      --   end
      -- },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-omni",
      -- {
      --  "hrsh7th/cmp-cmdline",
      --  config = function()
      --    require("config.nvim-cmp-cmd")
      --  end,
      --  dependencies = {},
      -- },
      {
        "dcampos/cmp-snippy",
        dependencies = {
          {
            "dcampos/nvim-snippy",
            name = "snippy",
            config = true,
            dependencies = {
              "honza/vim-snippets",
            },
          },
        },
      },
    },
  },

  -- THEMES

  {
    "ShinyZero0/challenger-deep.nvim",
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "sjl/badwolf",
    lazy = true,
  },
  {
    "ray-x/aurora",
    lazy = true,
  },
  {
    "wuelnerdotexe/vim-enfocado",
    lazy = true,
  },
  {
    "savq/melange",
    lazy = true,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
  {
    "EdenEast/Nightfox.nvim",
    lazy = true,
  },
}
-- vim:ts=2:sw=2
