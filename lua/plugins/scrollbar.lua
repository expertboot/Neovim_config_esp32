return {
  "petertriho/nvim-scrollbar",
  event = "BufReadPost",
  config = function()
    require("scrollbar").setup({
      handle = {
        color = "#555555", -- Цвет полосы прокрутки
      },
      marks = {
        Search = { color = "#FFCC00" }, -- Подсветка поиска
        Error = { color = "#FF0000" },  -- Ошибки
        Warn  = { color = "#FFA500" },  -- Предупреждения
        Info  = { color = "#00FFFF" },  -- Информация
        Hint  = { color = "#ADFF2F" },  -- Подсказки
      },
    })
  end
}

