return {
  {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy =false,
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
  },
  {
    "preservim/tagbar",
    lazy = false,
  },
  {
    'rmagatti/goto-preview',
    event = "User AstroFile",
    config = function()
      require('goto-preview').setup {}
    end
  },
  {
      "dnlhc/glance.nvim",
      event = "User AstroFile",
      enabled = false,
      config = function()
        require('glance').setup({
          -- your configuration
        })
      end,
  },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      table.insert(vimgrep_arguments, "!**/build/*")
    end,
  },
}
