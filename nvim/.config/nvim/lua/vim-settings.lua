vim.opt.showmode = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = vim.fn.mode() == "i"
  end,
})

vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("o", "H", "0")
vim.keymap.set("o", "L", "$")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>tt", "<C-w>T")
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>")

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.diagnostic.config({ virtual_text = true })
