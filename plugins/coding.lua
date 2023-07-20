return {
  {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy =false,
    db_file = "./.exvim.yosemite/cscope.out",
    dependencies = {
      "folke/which-key.nvim", -- optional [for whichkey hints]
      "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
      "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
      "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
    },
    opts = {
      -- USE EMPTY FOR DEFAULT OPTIONS
      -- DEFAULTS ARE LISTED BELOW
      cscope = {
        -- choose your fav picker
        picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
      }
    },
    config = function()
			vim.cmd("let tags=\"./.exvim.yosemite/tags\"")
    end,
  },
  {
    "preservim/tagbar",
    lazy = false,
  },
}
