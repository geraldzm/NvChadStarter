-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- This block disables completion during rename
local cmp = require "cmp"
local original_complete = cmp.complete
vim.lsp.handlers["textDocument/rename"] = function(_, result, _)
  -- Temporarily disable completion
  cmp.complete = function() end

  -- If there's a result, apply it
  if result then
    vim.lsp.util.apply_workspace_edit(result, "utf-8")
  end

  -- Restore the original complete function
  cmp.complete = original_complete
end

-- EXAMPLE
local servers = { "html", "cssls", "pylsp", "gopls", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Typescript personalized config
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Set up format on save if you want ts_ls to handle formatting
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
      },
    },
    diagnostics = {
      enable = true,
    },
  },
  init_options = {
    preferences = {
      importModuleSpecifier = "non-relative",
    },
  },
}

-- golang personalized config
lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Set up format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- python personalized config
lspconfig.pylsp.setup {
  on_attach = nvlsp.on_attach,
  -- on_attach = function(client, bufnr)
  --   nvlsp.on_attach(client, bufnr)
  --   -- Set up format on save
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ timeout_ms = 2000 })
  --     end,
  --   })
  -- end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391", "E302" },
          maxLineLength = 150,
        },
      },
    },
    black = {
      enabled = true,
      line_length = 150,
    },
  },
}

-- Rust personalized config
lspconfig.rust_analyzer.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Set up format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}
