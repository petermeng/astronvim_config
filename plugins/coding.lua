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
        picker = "fzf-lua", -- "telescope", "fzf-lua" or "quickfix"
      }
    },
  },
  {
    "preservim/tagbar",
    lazy = false,
    config = function()
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register({
          ["<leader>T"] = {
            name = "TagBar",
            t = { "<cmd>TagbarToggle<CR>", "Tagbar toggle" },
          }
        })
      end
    end
  },
  {
    'rmagatti/goto-preview',
    event = "User AstroFile",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 15; -- Height of the floating window
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        };
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true; -- Focus the floating window when opening it.
        dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      }
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register({
          ["<Leader>G"] = {
	          name = "GotoPreview",
	          pd = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview definition" },
	          pt = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Preview Type definition" },
	          pi = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Implementation" },
	          P = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all windows" },
	          pr = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "References" },
          }
      })
      end

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
    opts = function()
      local actions = require "telescope.actions"
      local get_icon = require("astronvim.utils").get_icon
      return {
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          prompt_prefix = get_icon("Selected", 1),
          selection_caret = get_icon("Selected", 1),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          previewer = false,
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<RightMouse>"] = actions.close,
              ["<LeftMouse>"] = actions.select_default,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
        },
      }
    end,
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      local egrep_actions = require "telescope._extensions.egrepify.actions"

      require("telescope").setup {
        extensions = {
          egrepify = {
            -- intersect tokens in prompt ala "str1.*str2" that ONLY matches
            -- if str1 and str2 are consecutively in line with anything in between (wildcard)
            AND = true,                     -- default
            permutations = false,           -- opt-in to imply AND & match all permutations of prompt tokens
            lnum = true,                    -- default, not required
            lnum_hl = "EgrepifyLnum",       -- default, not required, links to `Constant`
            col = false,                    -- default, not required
            col_hl = "EgrepifyCol",         -- default, not required, links to `Constant`
            title = true,                   -- default, not required, show filename as title rather than inline
            filename_hl = "EgrepifyFile",   -- default, not required, links to `Title`
            -- suffix = long line, see screenshot
            -- EXAMPLE ON HOW TO ADD PREFIX!
            prefixes = {
              -- ADDED ! to invert matches
              -- example prompt: ! sorter
              -- matches all lines that do not comprise sorter
              -- rg --invert-match -- sorter
              ["!"] = {
                flag = "invert-match",
              },
              -- HOW TO OPT OUT OF PREFIX
              -- ^ is not a default prefix and safe example
              ["^"] = false
            },
            -- default mappings
            mappings = {
              i = {
                -- toggle prefixes, prefixes is default
                ["<C-z>"] = egrep_actions.toggle_prefixes,
                -- toggle AND, AND is default, AND matches tokens and any chars in between
                ["<C-a>"] = egrep_actions.toggle_and,
                -- toggle permutations, permutations of tokens is opt-in
                ["<C-r>"] = egrep_actions.toggle_permutations,
              },
            },
          },
        },
      }
      require("telescope").load_extension "egrepify"
    end
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "User AstroFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require('refactoring').setup({
          -- prompt for return type
          prompt_func_return_type = {
              go = true,
              cpp = true,
              c = true,
              java = true,
          },
          -- prompt for function parameters
          prompt_func_param_type = {
              go = true,
              cpp = true,
              c = true,
              java = true,
          },
      })
      vim.keymap.set(
	      {"n", "x"},
	      "<leader>rt",
	      function() require('telescope').extensions.refactoring.refactors() end
      )
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register({
          ["<Leader>R"] = {
	          name = "Refactoring",
	          e = { function() require('refactoring').refactor('Extract Function') end , "Extract Function", mode = "x" },
	          f = { function() require('refactoring').refactor('Extract Function To File') end , "Extract Function To File", mode = "x" },
	          v = { function() require('refactoring').refactor('Extract Variable') end , "Extract Variable", mode = "x" },
	          i = { function() require('refactoring').refactor('Inline Variable') end , "Inline Variable", mode = {"x", "n"} },
	          b = { function() require('refactoring').refactor('Extract Block') end , "Extract Variable", mode = "n" },
	          bf = { function() require('refactoring').refactor('Extract Block To File') end , "Extract Variable To File", mode = "n" },
	          r = { function() require('telescope').extensions.refactoring.refactors() end , "Telescope", mode = {"n", "x"} },
          }
      })
      end
    end,
  },
  {
    "daishengdong/calltree.nvim",
    event = "User AstroFile",
    dependencies = {
      "dhananjaylatkar/cscope_maps.nvim",
      "folke/which-key.nvim", -- optional [for whichkey hints]
    },
    opts = {
      -- USE EMPTY FOR DEFAULT OPTIONS
      -- DEFAULTS ARE LISTED BELOW
      prefix = "<leader>O", -- keep consistent with cscope_maps
      tree_style = "brief", -- alternatives: detailed, detailed_paths
    },
  },
}
