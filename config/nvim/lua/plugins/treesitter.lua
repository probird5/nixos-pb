return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				-- Requested languages
				"go",
				"python",
				"bash",
				"yaml",
				"rust",
				"c",
				"javascript",
				"typescript",
				"markdown",
				"markdown_inline",
				"nix",
				-- Additional useful parsers
				"lua",
				"vim",
				"vimdoc",
				"html",
				"css",
				"json",
				"toml",
				"query",
				"regex",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
