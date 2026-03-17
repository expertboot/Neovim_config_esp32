return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.styled_parts"] = true,
        ["break.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      command_palette = true, -- Это включает центрированное окно
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    -- Настройка внешнего вида окон
    views = {
      cmdline_popup = {
        position = {
          row = "50%", -- Центр по вертикали
          col = "50%", -- Центр по горизонтали
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "62%", -- Чуть ниже окна ввода команд
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
}