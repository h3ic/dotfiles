return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "markdown",
          "markdown_inline",
          "regex",
          "yaml",
          "dockerfile",
          "javascript",
          "typescript",
          "tsx",
          "css",
          "html",
          "rust",
          "kotlin",
          "java",
          "sql",
          "gdscript",
          "godot_resource",
          "gdshader",
        },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, {})
      vim.keymap.set("n", "<leader>tg", builtin.git_files, {})
      vim.keymap.set("n", "<leader>s", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>b", builtin.buffers, {})

      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = "top",
            width = 0.8,
            height = 0.95,
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["d"] = "delete_buffer",
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local config = require("lualine")
      config.setup({
        sections = {
          lualine_b = {
            {
              "branch",
              fmt = function(str)
                local ticket = str:match("(%d+)")
                return ticket or str
              end,
            },
          },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            "encoding",
            "selectioncount",
          },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader><leader>tf", ":Neotree filesystem left toggle<CR>")
      vim.keymap.set("n", "<leader>tf", ":Neotree filesystem float toggle<CR>")
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          mappings = {
            ["Y"] = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local filename = node.name
              local modify = vim.fn.fnamemodify

              local results = {
                filename,
                filepath,
                modify(filepath, ":."),
                modify(filepath, ":~"),
              }

              vim.ui.select({
                "1. Filename: " .. results[1],
                "2. Absolute path: " .. results[2],
                "3. Path relative to CWD: " .. results[3],
                "4. Path relative to HOME: " .. results[4],
              }, { prompt = "Choose to copy to clipboard:" }, function(choice)
                local i = tonumber(choice:sub(1, 1))
                local result = results[i]
                vim.fn.setreg("+", result)
                vim.notify("Copied: " .. result)
              end)
            end,
          },
        },
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      {
        "<leader>e",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
