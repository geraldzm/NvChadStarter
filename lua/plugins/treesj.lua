return {
  "Wansmer/treesj",
  keys = {
    { "<leader>sm", "<cmd>TSJToggle<cr>", desc = "Toggle node under cursor" },
    { "<leader>sj", "<cmd>TSJJoin<cr>", desc = "Join node under cursor" },
    { "<leader>ss", "<cmd>TSJSplit<cr>", desc = "Split node under cursor" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup {
      use_default_keymaps = false,
      max_join_length = 500,
      langs = {
        typescript = {},
        tsx = {},
      },
    }
  end,
}
