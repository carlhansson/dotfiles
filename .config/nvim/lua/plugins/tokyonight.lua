-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
vim.pack.add({
	{
		src = gh "rose-pine/neovim",
		name = "rose-pine",
	},
})
require("rose-pine").setup()
vim.cmd("colorscheme rose-pine")
-- vim: ts=2 sts=2 sw=2 et
