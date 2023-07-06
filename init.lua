return {
  polish = function()
    -- create an augroup for easy management of autocommands
    vim.api.nvim_create_augroup("autohidetabline", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      desc = "Hide tabline when only one buffer and one tab",
      pattern = "AstroBufsUpdated",
      group = "autohidetabline",
      callback = function()
        local new_showtabline = #vim.t.bufs > 1 and 2 or 1
        if new_showtabline ~= vim.opt.showtabline:get() then
          vim.opt.showtabline = new_showtabline
        end
      end
    })
    vim.api.nvim_create_augroup("disableCapsLock", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Disable Caps Lock when starting AstroNvim",
      group = "disableCapsLock",
      callback = function()
        os.execute(
          "xmodmap -e 'keycode 0x42 = Escape'"
        )
      end
    })
    vim.api.nvim_create_augroup("enableCapsLock", { clear = true })
    vim.api.nvim_create_autocmd("VimLeave", {
      desc = "Enable Caps Lock when exiting AstroNvim",
      group = "enableCapsLock",
      callback = function()
        os.execute(
          "xmodmap -e 'keycode 0x42 = Caps_Lock'"
        )
      end
    })

    -- Carry out a command, similar to using ":"
    -- vim.api.nvim_command('highlight Normal guibg=none')
    -- Above command is similar to the next one
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalSB", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
  end,

  highlights = {
    -- set highlights for all themes
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
      ["<leader>tt"] = { "<cmd>ToggleTerm<CR>", desc = "ToggleTerminal" },
      ["ff"] = { "<cmd>HopChar1<CR>", desc = "hop-char" },
      ["fl"] = { "<cmd>HopLine<CR>", desc = "hop-line" },
      ["H"] = { "<cmd>bprevious<CR>", desc = "Move to prev Buffer" },
      ["L"] = { "<cmd>bnext<CR>", desc = "Move to prev Buffer" },
      ["<leader>Y"] = { "\"+y", desc = "Yank to System Clipboard" },
      ["<leader>D"] = { "\"+d", desc = "Delete to System Clipboard" },
      ["<leader>q"] = { "<nop>", desc = "Do Nothing" },
      ["<S-Up>"] = { "<S-Up>zz", desc = "Move Up & Center Cursor" },
      ["<S-Down>"] = { "<S-Down>zz", desc = "Move Down & Center Cursor" },
      ["<leader>;"] = { "<Esc><S-a>;<Esc>", desc = "Insert ; & Esc" },
      ["<leader>fqo"] = { "<cmd>copen<CR>", desc = "Open the QuickFix List" },
      ["<leader>fqc"] = { "<cmd>cclose<CR>", desc = "Close the QuickFix List" },
      ["<leader>fql"] = { "<cmd>call setqflist([],'r')<CR>", desc = "Clear the QuickFix List" },
      [""] = { "10kzz", desc = "Move up by 10" },
      [""] = { "10jzz", desc = "Move down by 10" },

    },
    t = {},
    v = {
      ["<leader>Y"] = { "\"+y", desc = "Yank to System Clipboard" },
      ["<leader>D"] = { "\"+d", desc = "Delete to System Clipboard" },
      ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move block of text down" },
      ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move block of text up" }
    },
    i = {
      [""] = { "<Esc><S-a>;<CR>", desc = "Insert ; & cont" },
      [""] = { "<Esc>", desc = "Insert ; & cont" },
    }
  },
  lsp = {
    setup_handlers = {
    },
    config = {
      html = {
        filetypes = { "html", "php" },
        -- single_filesupport = true
      },
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
      end,
      intelephense = {
        filetypes = { "php" },
        single_filesupport = true,
        stubs = {
          "wordpress-stubs",
          "woocommerce-stubs",
          "wp-cli-stubs"
        }
      }
    },
  },
  -- ,
  colorscheme = "catppuccin",
}


-- Plugin Specific Changes:
-- 1. Notify: Disable Opacity warning in configs
-- 2. Edit Statusline to include name of the file
-- 1. Notify: Disable Opacity warning in configs
-- 2. Edit Statusline to include name of the file
-- 1. Notify: Disable Opacity warning in configs
-- 2. Edit Statusline to include name of the file
-- 1. Notify: Disable Opacity warning in configs
-- 2. Edit Statusline to include name of the file
-- 1. Notify: Disable Opacity warning in configs
-- 2. Edit Statusline to include name of the file
