return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 	lua-language-server, typescript-language-server, rust-analyzer, gdtoolkit
      -- 	stylua, eslint_d, prettierd, css-lsp

      local no_config_servers = { "lua_ls", "ts_ls", "cssls", "gdscript" }

      for _, lsp in ipairs(no_config_servers) do
        vim.lsp.config(lsp, capabilities)
        vim.lsp.enable(lsp)
      end

      vim.lsp.config('rust_analyzer', {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      })
      vim.lsp.enable('rust_analyzer')

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, async = false })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd" },
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("none-ls.diagnostics.eslint_d"),
        },
      })
    end,
  },
}
