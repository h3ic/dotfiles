vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost" }, { command = "silent! update" })

-- see vim-settings.lua
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = vim.fn.expand("~/dotfiles/*"),
  callback = function()
    vim.opt_local.backup = false
    vim.opt_local.swapfile = false
  end,
})
