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
      ["ggandor/leap-spooky.nvim"] = {
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = false,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        equivalence_classes = { ' \t\r\n', },
        substitute_chars = {},
        safe_labels = { 's', 'f', 'n', 'u', 't' },
        labels = { 's', 'f', 'n', 'j', 'k' },
        special_keys = {
          repeat_search = '<enter>',
          next_phase_one_target = '<enter>',
          next_target = {'<enter>', ';'},
          prev_target = {'<tab>', ','},
          next_group = '<space>',
          prev_group = '<tab>',
          multi_accept = '<enter>',
          multi_revert = '<backspace>',
        }
      } --install leap
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "rust_analyzer", "tsserver", "clangd" }, -- install rust_analyzer
    },
  },
}
