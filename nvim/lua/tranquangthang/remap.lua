vim.g.mapleader = " "

vim.keymap.set({ "s", "i" }, "<C-c>", "<Esc>")

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y')
vim.keymap.set("x", "<leader>d", '"_d')
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set(
	"n",
	"<leader>rw",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
)

vim.keymap.set("n", "<leader><leader>", function()
	if vim.bo.filetype == "lua" then
		vim.cmd("so")
	end
end)

vim.keymap.set("n", "<leader>e", function()
	local file_pattern = vim.fn.escape(vim.fn.expand("%:t"), [[\/.*~]])

	local file_absolute = vim.fn.expand("%")
	local filetype = vim.fn.getftype(file_absolute)
	local fileperm = vim.fn.getfperm(file_absolute)

	if filetype == "link" then
		file_pattern = file_pattern .. "@"
	elseif
		fileperm:sub(3, 3) == "x"
		or fileperm:sub(6, 6) == "x"
		or fileperm:sub(9, 9) == "x"
	then
		file_pattern = file_pattern .. "\\*"
	end

	vim.cmd.Explore()
	vim.fn.search(file_pattern)
end)
