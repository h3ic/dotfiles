return {
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_current_word = "underline"
      vim.g.everforest_better_performance = 1
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        options = {
          laststatus = 3,
        },
      },
    },
  },
}
