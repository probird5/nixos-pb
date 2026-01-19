return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configure LSP servers with capabilities for better completion
			local servers = {
				"gopls",
				"pyright",
				"bashls",
				"yamlls",
				"rust_analyzer",
				"clangd",
				"ts_ls",
				"nixd",
				"lua_ls",
				"marksman",
				"html",
				"cssls",
				"jsonls",
			}

			for _, server in ipairs(servers) do
				local opts = { capabilities = capabilities }

				-- Server-specific settings
				if server == "lua_ls" then
					opts.settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					}
				elseif server == "yamlls" then
					opts.settings = {
						yaml = {
							schemas = {
								["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
							},
							validate = true,
							completion = true,
						},
					}
				elseif server == "rust_analyzer" then
					opts.settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
							cargo = {
								allFeatures = true,
							},
						},
					}
				end

				lspconfig[server].setup(opts)
			end

			-- Global LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					-- Navigation
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

					-- Hover and signature
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

					-- Code actions and refactoring
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					-- Diagnostics
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
				end,
			})

			-- Configure diagnostics display
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				float = {
					border = "rounded",
					source = "always",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
