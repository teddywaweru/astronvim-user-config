return {
  highlights = {
    -- set highlights for all themes
    -- use a function override to let us use lua to retrieve colors from highlight group
    -- there is no default table so we don't need to put a parameter for this function
    init = function()
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      -- get highlights from highlight groups
      local normal = get_hlgroup "Normal"
      local fg, bg = normal.fg, normal.bg
      local bg_alt = get_hlgroup("Visual").bg
      local green = get_hlgroup("String").fg
      local red = get_hlgroup("Error").fg
      -- return a table of highlights for telescope based on colors gotten from highlight groups
      return {
        TelescopeBorder = { fg = bg_alt, bg = bg },
        TelescopeNormal = { bg = bg },
        -- TelescopePreviewBorder = { fg = bg, bg = bg },
        -- TelescopePreviewNormal = { bg = bg },
        TelescopePreviewTitle = { fg = bg, bg = green },
        TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
        TelescopePromptNormal = { fg = fg, bg = bg_alt },
        TelescopePromptPrefix = { fg = red, bg = bg_alt },
        TelescopePromptTitle = { fg = bg, bg = red },
        TelescopeResultsBorder = { fg = bg, bg = bg },
        TelescopeResultsNormal = { bg = bg },
        TelescopeResultsTitle = { fg = bg, bg = bg },
      }
    end,
  },
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
      cmdheight = 1,
      clipboard = "unnamed"
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
      ["H"] = { "<cmd>bprevious<CR>", desc = "Move to prev Buffer" },
      ["L"] = { "<cmd>bnext<CR>", desc = "Move to prev Buffer" },
      ["<leader>Y"] = { "\"+y", desc = "" },
      ["<leader>D"] = { "\"+d", desc = "" },
      ["<leader>q"] = { "<nop>", desc = "Do Nothing" },
      ["<S-Up>"] = { "<S-Up>zz", desc = "Move Up & Center Cursor" },
      ["<S-Down>"] = { "<S-Down>zz", desc = "Move Down & Center Cursor" },

      -- vim.keymap.set("n", "<leader>Y", [["+Y]])
    },
    t = {
      -- ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
      ["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    },
    v = {
      ["<leader>Y"] = { "\"+y", desc = "Paste to System Clipboard" },
    }
  },
  lsp = {
    setup_handlers = {
      rust_analyzer = function(_, opts)
        opts = {
          tools = {
            inlay_hints = {
              auto = false,
              only_current_line = false,
              show_parameter_hints = true,
              RustSetInlayHints = true,
              RustEnableInlayHints = true,
              parameter_hint_prefix = ": ",
              other_hints_prefix = "--> "
            },
          },
        }
        require("rust-tools").setup { server = opts }
        -- require("rust-tools").setup(opts)
      end
    },
    config = {
      html = {
        filetypes = { "html", "php" },
        single_filesupport = false
      }
    },
  },
  plugins = {
    {
      ---Plugins to Consider
      -- treesitter-context, nvim-bqf, treesj, trouble
    },
    {
      "f-person/git-blame.nvim",
      event = "VeryLazy"
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      opts = {}
    },
    {
      "phaazon/hop.nvim",
      branch = 'v2', -- optional but strongly recommended
      cmd = { "HopChar1", "HopLine" },
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
      after = "mason-lspconfig.nvim",
      config = function()
        require("rust-tools").setup({
          -- server = astronvim.lsp.server_settings "rust_analyzer",
          opts = {
            tools = {
              inlay_hints = {
                auto = false,
                only_current_line = false,
                show_parameter_hints = true,
                RustSetInlayHints = true,
                RustEnableInlayHints = true,
                parameter_hint_prefix = ": ",
                other_hints_prefix = "--> "
              },
            },
          },
        })
      end,
    },
    -- {
    --   "simrat39/rust-tools.nvim",
    --   after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
    --   config = function()
    --     require("rust-tools").setup {
    --       server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
    --       tools = {
    --         inlay_hints = { },
    --       },
    --     }
    --   end,
    -- },
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
      colorscheme = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
        require("catppuccin").setup {
          flavour = "mocha"
        }
      end
    },
    -- {
    --   "folke/tokyonight.nvim",
    --   as = "tokyonight",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     require("tokyonight").setup {
    --       style = "night",
    --       on_colors = function(colors)
    --         colors.hint = colors.orange
    --         colors.git.add = "#58F139"
    --         colors.gitSigns.add = "#58F139"
    --         colors.git.change = colors.orange
    --         colors.gitSigns.change = colors.orange
    --       end
    --     }
    --   end
    -- }, --install tokyonight
    --       -- {'CRAG666/code_runner.nvim'} --install code_runner
    --     -- },
    --     -- ["mason-lspconfig"] = {
    --     --   ensure_installed = {
    --     --     "rust_analyzer",
    --     --     "tsserver",
    --     --     -- "clangd"
    --     --   }, -- install rust_analyzer
    -- },
  },
  --   -- colorscheme = "tokyonight",
  --   -- lazy = false,
  --   -- require("tokyonight").setup({
  --   --   style = "night",
  --   --   on_colors = function(colors)
  --   --     colors.hint = colors.orange
  --   --     colors.git.add = "#58F139"
  --   --     colors.gitSigns.add = "#58F139"
  --   --     colors.git.change = colors.orange
  --   --     colors.gitSigns.change = colors.orange
  --   --   end
  --   -- }),
  colorscheme = "catppuccin",
  -- require("catppuccin").setup({
  --   flavour = "mocha"
  -- })
}
-- return {
--   -- require("plugin.options"),
--   updater = {
--     channel = "stable",
--     auto_reload = false,
--     auto_quit = false,
--   },
--   options = {
--     opt = {
--       wrap = true,
--       guifont = "Hack:h10",
--       tabstop = 2,
--       softtabstop = 2,
--       expandtab = false,
--       cmdheight = 1
--     },
--     g = {
--       neovide_refresh_rate = 50,
--     }
--   },
--   mappings = {
--     n = {
--       ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
--       ["ff"] = { "<cmd>HopChar1<CR>", desc = "hop-char" },
--       ["fl"] = { "<cmd>HopLine<CR>", desc = "hop-line" },
--     },
--     t = {
--       -- ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
--       ["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
--     },
--   },
--   lsp = {
--     skip_setup = { "rust_analyzer", "tsserver" }, -- skip lsp setup because rust-tools will do it itself
--     -- skip_setup = { "tsserver" },      --skip lsp setup because rust-tools will do it itself
--     -- skip_setup = { "clangd" },
--     ["server-settings"] = {
--       -- clangd = {
--       --   capabilities = {
--       --     offsetEncoding = "utf-8",
--       --   },
--       -- },
--       html = {
--         filetypes = { "html", "php" },
--         -- single_filesupport = false
--       }
--     },
--   },
--   plugins = {
--     init = {
--       {
--         "nvim-treesitter/nvim-treesitter-context",
--         as = "treesitter-context",
--         config = function()
--           require('treesitter-context').setup {
--             enable = true,
--             max_lines = 0,
--             min_window_height = 0,
--             line_numbers = true,
--             multiline_threshold = 20,
--             trim_scope = 'outer',
--             mode = 'cursor',
--             separator = nil,
--             zindex = 2000
--           }
--         end
--       },
--       {
--         "phaazon/hop.nvim",
--         branch = 'v2', -- optional but strongly recommended
--         config = function()
--           -- you can configure Hop the way you like here; see :h hop-config
--           require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
--         end
--       },
--       -- {
--       --   "p00f/clangd_extensions.nvim",
--       --   after = "mason-lspconfig.nvim",
--       --   config = function()
--       --     require("clangd_extensions").setup {
--       --       server = astronvim.lsp.server_settings "clangd"
--       --     }
--       --   end,
--       -- },
--       {
--         "simrat39/rust-tools.nvim",
--         after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
--         config = function()
--           require("rust-tools").setup {
--             server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
--             -- tools = {
--             --   inlay_hints = {
--             --     auto = true,
--             --     only_current_line = false,
--             --     show_parameter_hints = true,
--             --     RustSetInlayHints = true,
--             --     RustEnableInlayHints = true,
--             --     parameter_hint_prefix = ": ",
--             --     other_hints_prefix = "--> "
--             --   },
--             -- },
--           }
--         end,
--       },
--       {
--         "jose-elias-alvarez/typescript.nvim",
--         after = "mason-lspconfig.nvim",
--         config = function()
--           require("typescript").setup {
--             server = astronvim.lsp.server_settings "tsserver"
--           }
--         end,
--       },
--       {
--         "catppuccin/nvim",
--         as = "catppuccin",
--         config = function()
--           require("catppuccin").setup {}
--         end
--       },
--       {
--         "folke/tokyonight.nvim",
--         as = "tokyonight",
--         config = function()
--           require("tokyonight").setup {
--           }
--         end
--       }, --install tokyonight
--       -- {'CRAG666/code_runner.nvim'} --install code_runner
--     },
--     ["mason-lspconfig"] = {
--       ensure_installed = {
--         "rust_analyzer",
--         "tsserver",
--         -- "clangd"
--       }, -- install rust_analyzer
--     },
--   },
--   colorscheme = "tokyonight",
--   require("tokyonight").setup({
--     style = "night",
--     on_colors = function(colors)
--       colors.hint = colors.orange
--       colors.git.add = "#58F139"
--       colors.gitSigns.add = "#58F139"
--       colors.git.change = colors.orange
--       colors.gitSigns.change = colors.orange
--     end
--   }),
--   -- colorscheme = "catppuccin",
--   -- require("catppuccin").setup({
--   --   flavour = "mocha"
--   -- })
-- }
