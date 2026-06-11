vim.cmd("source ~/.vimrc")
vim.g.mapleader = " "

-- drag text after selecting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clipboard magic
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- for FileType autocmd and foldmethod=expr to work. See autocmds.lua
vim.cmd("filetype on")
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.foldcolumn = "1"
vim.opt.foldenable = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.diagnostic.config({ virtual_text = true })
