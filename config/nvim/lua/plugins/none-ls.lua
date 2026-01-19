return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			sources = {
				-- Lua
				formatting.stylua,

				-- Go
				formatting.gofumpt,
				formatting.goimports,
				diagnostics.golangci_lint,

				-- Python
				formatting.ruff,
				diagnostics.ruff,

				-- Bash (diagnostics provided by bashls)
				formatting.shfmt.with({
					extra_args = { "-i", "2", "-ci" }, -- 2-space indent, indent case statements
				}),

				-- Rust (rustfmt is handled by rust-analyzer)

				-- C/C++ (clang-format)
				formatting.clang_format,

				-- JavaScript/TypeScript/JSON/YAML/Markdown
				formatting.prettierd.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"json",
						"yaml",
						"markdown",
						"html",
						"css",
					},
				}),

				-- Nix
				formatting.nixfmt,
			},
		})

		-- Format on save (optional - comment out if you prefer manual formatting)
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Manual format keymap
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" })
	end,
}
