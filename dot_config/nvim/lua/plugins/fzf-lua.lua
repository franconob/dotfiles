return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		local fzf_lua = require("fzf-lua")
		fzf_lua.setup({
			lsp = {
				code_actions = {
					previewer = "codeaction_native",
					preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
				},
			},
			oldfiles = {
				cwd_only = true,
			},
		})

		vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Fzf Files" })
		vim.keymap.set("n", "<leader>fs", fzf_lua.live_grep, { desc = "Fzf live grep" })
		vim.keymap.set("n", "<leader>fr", fzf_lua.oldfiles, { desc = "Fzf recent files" })
		vim.keymap.set("n", "<C-o>", fzf_lua.lsp_workspace_symbols, { desc = "Fzf workspace symbols" })
		vim.keymap.set("n", "<leader>ca", function()
			fzf_lua.lsp_code_actions({
				winopts = {
					relative = "cursor",
					width = 0.8,
					height = 0.6,
					row = 1,
					preview = { vertical = "up:70%" },
				},
			})
		end, { desc = "Fzf code actions" })
	end,
}
