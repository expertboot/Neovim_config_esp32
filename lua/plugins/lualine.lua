return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Для отображения иконок
  config = function()

    -- Загружаем стандартную тему gruvbox и изменяем её
    local custom_gruvbox = require('lualine.themes.gruvbox')
    
    -- Изменение цвета фона для секции lualine_c в нормальном режиме
    custom_gruvbox.normal.c.bg = '#112233'
    custom_gruvbox.insert.c.bg = '#223344'  -- Можно настроить и для других режимов
    custom_gruvbox.visual.c.bg = '#334455'


    require('lualine').setup({
      options = {
        theme = custom_gruvbox,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },

      inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    })
  end
}

