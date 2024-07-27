return {
	"nvimtools/none-ls.nvim",
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {}) -- for formatting on save
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					condition = function(utils)
						return utils.root_has_file({ ".prettierrc.js" })
					end,
					prefer_local = "node_modules/.bin",
				}),
				require("none-ls.diagnostics.eslint_d"),
				-- null_ls.builtins.diagnostics.eslint_d, -- eslint-language-server ?
			},
			-- for formatting on save https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
			-- async formatting is also possible
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
		-- vim.keymap.set("n", "<C-s>", vim.lsp.buf.format, {})
	end,
}
