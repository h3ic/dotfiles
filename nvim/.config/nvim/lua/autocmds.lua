vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost" }, { command = "silent! update" })

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo.foldlevel = 99
    -- vim.wo.foldcolumn = "2"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = vim.fn.expand("~/dotfiles/*"),
  callback = function()
    vim.opt_local.backup = false
    vim.opt_local.swapfile = false
  end,
})


-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local filepath = vim.api.nvim_buf_get_name(0)
--     if filepath == "" then return end
--
--     local orange_dirs = { "/home/h3ic/rust" }
--
--     local use_orange = false
--     for _, dir in ipairs(orange_dirs) do
--       if string.find(filepath, dir) then
--         use_orange = true
--         break
--       end
--     end
--
--     if use_orange and vim.g.colors_name ~= "darcula-solid" then
--       vim.cmd.colorscheme("darcula-solid")
--     elseif not use_orange and vim.g.colors_name ~= "everforest" then
--       vim.cmd.colorscheme("everforest")
--     end
--
--     vim.opt.termguicolors = true
--   end,
-- })
