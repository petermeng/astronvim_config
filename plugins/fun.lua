return {
	{
		"Eandrju/cellular-automaton.nvim",
		keys = "<leader>rr",
		config = function()
			vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
		end,
	},
	{
		'tamton-aquib/zone.nvim',
		config = function()
			require('zone').setup {
    			style = "treadmill",
    			after = 30,          -- Idle timeout
    			exclude_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "dashboard", "lazy" },
    			-- More options to come later

    			treadmill = {
        			direction = "left",
        			headache = true,
        			tick_time = 30,     -- Lower, the faster
        			-- Opts for Treadmill style
    			},
    			epilepsy = {
        			stage = "aura",     -- "aura" or "ictal"
        			tick_time = 100,
    			},
    			dvd = {
        			-- text = {"line1", "line2", "line3", "etc"}
        			tick_time = 100,
        			-- Opts for Dvd style
    			},
    			-- etc
			}
		end
	},
	{
		'tamton-aquib/keys.nvim',
		cmd="KeysToggle",
		config = function()
			require('keys').setup {
	    		enable_on_startup = true,
    			win_opts = {
        			width = 25
        			-- etc
    			},
    		}
		end
	},
	{
		'tamton-aquib/duck.nvim',
		keys = {
			"<leader>rd",
			"<leader>rk"
		},
		config = function()
        	vim.keymap.set('n', '<leader>rd', function() require("duck").hatch("🐈", 0.75) end, {})
        	vim.keymap.set('n', '<leader>rk', function() require("duck").cook() end, {})
	    end
	},
}
