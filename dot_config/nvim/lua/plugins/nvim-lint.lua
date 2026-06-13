return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
