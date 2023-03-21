return {
  -- require("plugin.options"),
  updater = {
    channel = "stable",
    auto_reload = false,
    auto_quit = false,
  },
  options = {
    opt = {
      wrap = true,
      guifont = "Hack:h10",
      tabstop = 2,
      softtabstop = 2,
      expandtab = false,
      cmdheight = 1
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
    skip_setup = { "rust_analyzer", "tsserver" }, -- skip lsp setup because rust-tools will do it itself
    -- skip_setup = { "tsserver" },      --skip lsp setup because rust-tools will do it itself
    -- skip_setup = { "clangd" },
    ["server-settings"] = {
      -- clangd = {
      --   capabilities = {
      --     offsetEncoding = "utf-8",
      --   },
      -- },
      html = {
        filetypes = { "html", "php" },
        -- single_filesupport = false
      }
    },
  },
  plugins = {
    init = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        as = "treesitter-context",
        config = function()
          require('treesitter-context').setup {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
            separator = nil,
            zindex = 2000
          }
        end
      },
      {
        "phaazon/hop.nvim",
        branch = 'v2', -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
        end
      },
      -- {
      --   "p00f/clangd_extensions.nvim",
      --   after = "mason-lspconfig.nvim",
      --   config = function()
      --     require("clangd_extensions").setup {
      --       server = astronvim.lsp.server_settings "clangd"
      --     }
      --   end,
      -- },
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
            -- tools = {
            --   inlay_hints = {
            --     auto = true,
            --     only_current_line = false,
            --     show_parameter_hints = true,
            --     RustSetInlayHints = true,
            --     RustEnableInlayHints = true,
            --     parameter_hint_prefix = ": ",
            --     other_hints_prefix = "--> "
            --   },
            -- },
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
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end
      },
      {
        "folke/tokyonight.nvim",
        as = "tokyonight",
        config = function()
          require("tokyonight").setup {
          }
        end
      }, --install tokyonight
      -- {'CRAG666/code_runner.nvim'} --install code_runner
    },
    ["mason-lspconfig"] = {
      ensure_installed = {
        "rust_analyzer",
        "tsserver",
        -- "clangd"
      }, -- install rust_analyzer
    },
  },
  colorscheme = "tokyonight",
  require("tokyonight").setup({
    style = "night",
    on_colors = function(colors)
      colors.hint = colors.orange
      colors.git.add = "#58F139"
      colors.gitSigns.add = "#58F139"
      colors.git.change = colors.orange
      colors.gitSigns.change = colors.orange
    end
  }),
  -- colorscheme = "catppuccin",
  -- require("catppuccin").setup({
  --   flavour = "mocha"
  -- })
}
