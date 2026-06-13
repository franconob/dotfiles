return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  config = function()
    vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>")
    vim.keymap.set("n", "<leader>er", ":Neotree reveal<CR>")

    require('neo-tree').setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules"
          }
        }
      }
    })
  end
}
