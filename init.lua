
return {
  -- require("plugin.options"),
  options = {
    opt = {
      wrap = true
      clipboard = unnamedplus
    }
  },
  lsp = {
    skip_setup = { "rust_analyzer" }, -- skip lsp setup because rust-tools will do it itself
    skip_setup = { "tsserver" }, --skip lsp setup because rust-tools will do it itself
  },
  plugins = {
    init = {
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
          }
        end,
      },
      {
        "jose-elias-alvarez/typescript.nvim",
        after = "mason-lspconfig.nvim",
        config = function()
          require("typescript").setup {
            server = astronvim.lsp.server_settings "tsserver"
            }
          end,
      }
       -- {"folke/tokyonight.nvim"}, --install tokyonight
       -- {'CRAG666/code_runner.nvim'} --install code_runner
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "rust_analyzer", "tsserver" }, -- install rust_analyzer
    },
  },
}
