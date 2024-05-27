return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
  },
  {
    "maxmx03/dracula.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      ---@type dracula
      local dracula = require "dracula"

      dracula.setup {
        transparent = false,
        on_colors = function(colors, color)
          ---@type dracula.palette
          return {
            -- override or create new colors
            mycolor = "#ffffff",
          }
        end,
        on_highlights = function(colors, color)
          ---@type dracula.highlights
          return {
            ---@type vim.api.keyset.highlight
            Normal = { fg = colors.mycolor },
          }
        end,
        plugins = {
          ["nvim-treesitter"] = true,
          ["nvim-lspconfig"] = true,
          ["nvim-navic"] = true,
          ["nvim-cmp"] = true,
          ["indent-blankline.nvim"] = true,
          ["neo-tree.nvim"] = true,
          ["nvim-tree.lua"] = true,
          ["which-key.nvim"] = true,
          ["dashboard-nvim"] = true,
          ["gitsigns.nvim"] = true,
          ["neogit"] = true,
          ["todo-comments.nvim"] = true,
          ["lazy.nvim"] = true,
          ["telescope.nvim"] = true,
          ["noice.nvim"] = true,
          ["hop.nvim"] = true,
          ["mini.statusline"] = true,
          ["mini.tabline"] = true,
          ["mini.starter"] = true,
          ["mini.cursorword"] = true,
        },
      }
      vim.cmd.colorscheme "dracula"
      vim.cmd.colorscheme "dracula-soft"
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    config = function()
      local fm = require "fluoromachine"

      fm.setup {
        transparent = true,
        -- brightness = 0.5,
        glow = false,
        -- fluoromachine, retrowave, delta
        theme = "retrowave",
        overrides = {
          ["@type"] = { italic = true, bold = false },
          ["@function"] = { italic = false, bold = false },
          ["@comment"] = { italic = true },
          -- ["@keyword"] = { italic = false, underdashed = true },
          ["Comment"] = { fg = "gray" },
          ["@keyword"] = { italic = false },
          ["@constant"] = { italic = false, bold = false },
          ["@variable"] = { italic = true },
          ["@field"] = { italic = true },
          ["@parameter"] = { italic = true },
          ["@string"] = { italic = false, fg = "lightgreen" },
          ["@keyword.return"] = { bold = true },
          ["@function.call"] = { underline = true, fg="orange" },
          -- ["@function.method.call"] = { underline = true, fg="orange" },
          -- ["@property"] = { italic = false, fg="red" },
        },
        colors = function(_, d)
          return {
            red = "#ed64c6",
          }
        end,
      }

      vim.cmd.colorscheme "fluoromachine"
    end,
  },
}
