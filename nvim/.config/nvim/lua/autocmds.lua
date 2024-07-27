vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost" }, { command = "silent! update" })
-- vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost" }, {
-- 	callback = function()
-- 		vim.cmd("silent! update")
-- 		vim.lsp.buf.format({ async = false })
-- 	end,
-- })
--

-- see vim-settings.lua
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		-- if require("nvim-treesitter.parsers").has_parser() then
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		-- end
	end,
})
