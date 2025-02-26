return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,  -- Загружать тему раньше других плагинов
  config = function()
    -- Настройка фона
    vim.o.background = "dark"  -- Устанавливаем темный фон (можно заменить на "light" для светлой темы)

    -- Применяем цветовую схему
    --vim.cmd("colorscheme gruvbox")
  end
}

