return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    -- Настройки плагина NeoTree
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,  -- Показывать скрытые файлы (начинающиеся с .)
          hide_gitignored = false, -- Показывать файлы, игнорируемые git
        },
      },
      window = {
        mappings = {
          ['<leader>o'] = 'open',  -- Открывает файл в новой вкладке
          ['<leader>h'] = 'open_split',  -- Открывает файл в горизонтальном разделении
          ['<leader>m'] = 'toggle',  -- Закрыть или открыть NeoTree
        },
      },
    })
  end,
}

