return {
  "ofirgall/ofirkai.nvim",
  priority = 1000, -- Загружать тему раньше других плагинов
  config = function()
    require("ofirkai").setup({
      -- Здесь можно настроить тему (необязательно)
      italics = true,  -- Включить курсив
    --  theme = "dark",  -- Основная тема (вариант: "dark")
    })

    -- Применяем цветовую схему
    --vim.cmd("colorscheme ofirkai")
  end
}

