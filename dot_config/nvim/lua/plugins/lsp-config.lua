return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "kotlin_lsp" }, -- add "html" here if you want it managed by mason
				-- optional: automatic_enable is true by default, so you can omit this
				-- automatic_enable = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Apply capabilities (and any other shared opts) to ALL LSPs
			-- This is merged with the defaults from nvim-lspconfig
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("kotlin_lsp", {
				-- cmd = "/tmp/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
				-- cmd = vim.lsp.rpc.connect("127.0.0.1", 9999),
				cmd = { "kotlin-lsp", "--stdio" },
				filetypes = { "kotlin" },
				settings = {
					kotlin = {
						compiler = {
							jvm = {
								target = "21", -- or "11", depending on your setup
							},
						},
					},
				},
			})

			-- If you want to be explicit, you can also tweak per-server configs:
			-- vim.lsp.config("lua_ls", {
			--   settings = {
			--     Lua = {
			--       diagnostics = {
			--         globals = { "vim" },
			--       },
			--     },
			--   },
			-- })

			-- Enable the servers. If you rely on mason-lspconfig's automatic_enable,
			-- this is strictly optional for mason-installed servers.
			vim.lsp.enable({ "lua_ls", "html", "kotlin_lsp" })

			-- LSP keymaps (global; you might later want them buffer-local via LspAttach)
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
