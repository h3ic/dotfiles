return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			transparent_background = true,
	-- 		})
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	-- {
	-- 	"doums/darcula",
	-- 	priority = 1000,
	-- 	config = function()
	-- vim.cmd.colorscheme("darcula")
	-- 	end,
	-- },
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function()
			vim.g.everforest_transparent_background = 1
			vim.g.everforest_current_word = "underline"
			vim.g.everforest_better_performance = 1
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VimEnter",
		enabled = true,
		init = false,
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				[[                               __                ]],
				[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
				[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
				[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
				[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
				[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
			}

			-- stylua: ignore
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " find file", "<cmd> Telescope find_files <cr>"),
				dashboard.button("n", " " .. " new file", "<cmd> ene <BAR> startinsert <cr>"),
				dashboard.button("r", " " .. " recent files", "<cmd> Telescope oldfiles <cr>"),
				dashboard.button("g", " " .. " find text", "<cmd> Telescope live_grep <cr>"),
				dashboard.button("s", " " .. " restore session", [[<cmd> lua require("persistence").load() <cr>]]),
				dashboard.button("q", " " .. " quit", "<cmd> qa <cr>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,

		config = function(_, dashboard)
			--[=====[
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end
		--]=====]
			require("alpha").setup(dashboard.opts)
		end,
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			plugins = {
				options = {
					laststatus = 3,
				},
			},
		},
	},
}
