return {
	"nvimtools/none-ls.nvim",
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {}) -- for formatting on save
		local null_ls = require("null-ls")

		-- avoid conflicts with lsp formatting
		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		-- local prettier_config = {
		-- 	condition = function(utils)
		-- 		return utils.root_has_file({ ".prettierrc.js" })
		-- 	end,
		-- 	prefer_local = "node_modules/.bin",
		-- }
		--
		-- local eslint_config = {
		-- 	condition = function(utils)
		-- 		return utils.root_has_file({ ".eslintrc.js" })
		-- 	end,
		-- 	prefer_local = "node_modules/.bin",
		-- }

		local eslint_config = {
			prefer_local = "node_modules/.bin",
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				})
			end,
		}

		null_ls.setup({
			debug = true,
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.prettier.with(prettier_config),
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.diagnostics.eslint,
				-- require("none-ls.diagnostics.eslint_d").with(eslint_config),
				require("none-ls.diagnostics.eslint_d"),
			},
			-- for formatting on save https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end,
		})
		-- vim.keymap.set("n", "<C-s>", vim.lsp.buf.format, { async = false })
		-- vim.keymap.set("n", "<C-s>", function()
		-- 	vim.lsp.buf.format({ async = false })
		-- end)
	end,
}
