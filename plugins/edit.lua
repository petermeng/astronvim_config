vim.cmd([[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]])
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require "rainbow-delimiters.setup"(opts) end,
  },
  {
      "smoka7/multicursors.nvim",
      event = "VeryLazy",
      dependencies = {
          'smoka7/hydra.nvim',
      },
      opts = function()
          local N = require 'multicursors.normal_mode'
          local I = require 'multicursors.insert_mode'
          return {
              normal_keys = {
                  -- to change default lhs of key mapping change the key
                  ['b'] = {
                      -- assigning nil to method exits from multi cursor mode
                      method = N.clear_others,
                      -- description to show in hint window
                      desc = 'Clear others'
                  },
              },
              insert_keys = {
                  -- to change default lhs of key mapping change the key
                  ['<CR>'] = {
                      -- assigning nil to method exits from multi cursor mode
                      method = I.Cr_method,
                      -- description to show in hint window
                      desc = 'new line'
                  },
              },
          }
      end,
      keys = {
              {
                  '<Leader>L',
                  '<cmd>MCstart<cr>',
                  desc = 'Create a selection for word under the cursor',
              },
          },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User AstroFile",
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "space:󰇘"
      vim.opt.listchars:append "eol:󱞣"

      require("indent_blankline").setup {
          space_char_blankline = " ",
          char_highlight_list = {
              "IndentBlanklineIndent1",
              "IndentBlanklineIndent2",
              "IndentBlanklineIndent3",
              "IndentBlanklineIndent4",
              "IndentBlanklineIndent5",
              "IndentBlanklineIndent6",
          },
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
      vim.opt.termguicolors = true
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
          s = s .. n .. sym
        end
        return s
      end
      require("bufferline").setup()
    end
  },
  {
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require('illuminate').configure({
				providers = {
					-- 'lsp',
					-- 'treesitter',
					'regex',
				},
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
		end
	},
	{
		"dkarter/bullets.vim",
		lazy = false,
		ft = { "markdown", "txt" },
	},
	-- {
	-- 	"psliwka/vim-smoothie",
	-- 	init = function()
	-- 		vim.cmd([[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]])
	-- 		vim.cmd([[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]])
	-- 	end
	-- },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,       -- #RGB hex codes
				RRGGBB = true,    -- #RRGGBB hex codes
				names = true,     -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		}
	},
	{
	  'theniceboy/antovim',
	  lazy = false,
	},
	{
	  'gcmt/wildfire.vim',
	  lazy = false,
	},
	-- {
 --    "fedepujol/move.nvim",
 --    lazy = false,
 --    config = function()
 --      local opts = { noremap = true, silent = true }
 --      -- Normal-mode commands
 --      vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
 --      vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
 --      vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
 --      vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
 --      vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
 --      vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)
	--
 --      -- Visual-mode commands
 --      vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
 --      vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
 --      vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
 --      vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
 --    end
	-- },
	{
		"gbprod/substitute.nvim",
		config = function()
			local substitute = require("substitute")
			substitute.setup({
				on_substitute = require("yanky.integration").substitute(),
				highlight_substituted_text = {
					enabled = true,
					timer = 200,
				},
			})
			vim.keymap.set("n", "s", substitute.operator, { noremap = true })
			vim.keymap.set("n", "sh", function() substitute.operator({ motion = "e" }) end, { noremap = true })
			vim.keymap.set("x", "s", require('substitute.range').visual, { noremap = true })
			vim.keymap.set("n", "ss", substitute.line, { noremap = true })
			vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
			vim.keymap.set("x", "s", substitute.visual, { noremap = true })
		end
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async", },
		config = function() require('ufo').setup() end
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
	  "tpope/vim-surround",
    event = "User AstroFile",
	},
	{
	  "tpope/vim-repeat",
    event = "User AstroFile",
	},
	{
	  "glts/vim-radical",
    event = "User AstroFile",
    dependencies = "glts/vim-magnum",
	},
	{
    "azabiong/vim-highlighter",
    event = "User AstroFile",
    config = function()
      vim.cmd([[
          let HiSet   = 'L<CR>'
          let HiErase = 'L<BS>'
          let HiClear = 'L<C-L>'
          let HiFind  = 'L<Tab>'
          let HiSetSL = 't<CR>'
      ]])
    end
	},
	{
	  "chentoast/marks.nvim",
    event = "User AstroFile",
	  config = function()
	    require'marks'.setup {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions. 
      -- higher values will have better performance but may cause visual lag, 
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
    }
	  end
	},
	{
	  "jesseleite/vim-agriculture",
    event = "User AstroFile",
	},
	{
    "rainbowhxch/accelerated-jk.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require('accelerated-jk').setup({
          mode = 'time_driven',
          enable_deceleration = false,
          acceleration_motions = {},
          acceleration_limit = 150,
          acceleration_table = { 7,12,17,21,24,26,28,30 },
          -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
          deceleration_table = { {150, 9999} }
      })
      vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
      vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end
	},
	{
	  "anuvyklack/windows.nvim",
	  lazy = false,
        dependencies = {
          "anuvyklack/middleclass",
          "anuvyklack/animation.nvim"
        },
        config = function()
          vim.api.nvim_set_keymap('n', '<C-w>z', '<cmd> WindowsMaximize<CR>', { desc = "Max the current Window" })
          vim.o.winwidth = 10
          vim.o.winminwidth = 10
          vim.o.equalalways = false
          require('windows').setup()
        end
  },
  {
    'anuvyklack/pretty-fold.nvim',
    lazy = false,
    enabled = false,
    config = function()
      require('pretty-fold').setup {
        sections = {
          left = {
             '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
          },
          right = {
             '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
          }
        },

        fill_char = '━',

        remove_fold_markers = false,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = 'spaces',

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
          '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = true, -- true, 'last_line' or false

        matchup_patterns = {
          {  '{', '}' },
          { '%(', ')' }, -- % to escape lua pattern char
          { '%[', ']' }, -- % to escape lua pattern char
        },

        ft_ignore = { 'neorg' },
      }
    end
  },
  {
    "RaafatTurki/hex.nvim",
    lazy = false,
    config = function()
      require("hex").setup()
    end
  }
}
