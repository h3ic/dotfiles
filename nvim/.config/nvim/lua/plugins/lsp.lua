return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"stylua",
					"lua-language-server",
					"eslint_d",
					"prettierd",
					"typescript-language-server",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" }, -- tailwindcss
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local servers = { "lua_ls", "ts_ls", "cssls" } -- tailwindcss

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({ capabilities = capabilities })
			end

			-- *** godot ***

			vim.keymap.set("n", "<leader>DD", function()
				vim.fn.serverstart("127.0.0.1:6004")
			end, { noremap = true })
			lspconfig.gdscript.setup({ capabilities = capabilities })

			-- *** end of godot ***

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					-- vim.keymap.set("n", "<C-s>", function()
					-- 	vim.lsp.buf.format({ async = true })
					-- end, opts)
					vim.keymap.set("n", "<C-s>", function() end, opts)
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
