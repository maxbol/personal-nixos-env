return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {})
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>" ,{})
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", {})
    keymap.set("n", "<leader>sg", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})
  end,

}
