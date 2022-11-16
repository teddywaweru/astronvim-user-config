return {
  -- require("plugin.options"),
  updater = {
    channel = "nightly",
    auto_reload = false,
    auto_quit = false,
  },
  options = {
    opt = {
      wrap = true,
      guifont = "Hack:h10",
      tabstop = 2,
      softtabstop = 2,
      expandtab = false
    },
    g = {
      neovide_refresh_rate = 50,
    }
  },
  mappings = {
     n = {
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["ff"] = { "<cmd>HopChar1<CR>", desc = "hop-char" },
    ["fl"] = { "<cmd>HopLine<CR>", desc = "hop-line" },
  },
  t = {
    -- ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    ["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
  },
  },
  lsp = {
    skip_setup = { "rust_analyzer" }, -- skip lsp setup because rust-tools will do it itself
    skip_setup = { "tsserver" }, --skip lsp setup because rust-tools will do it itself
    skip_setup = { "clangd" },
    ["server-settings"] = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
    },
  },
  plugins = {
    init = {
      {
      "phaazon/hop.nvim",
        branch = 'v2', -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
        end
      },
      {
        "p00f/clangd_extensions.nvim",
        after = "mason-lspconfig.nvim",
        config = function()
          require("clangd_extensions").setup {
            server = astronvim.lsp.server_settings "clangd"
          }
        end,
      },
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
      },
       -- {"folke/tokyonight.nvim"}, --install tokyonight
       -- {'CRAG666/code_runner.nvim'} --install code_runner
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "rust_analyzer", "tsserver", "clangd" }, -- install rust_analyzer
    },
  },
}
