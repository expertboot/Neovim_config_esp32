return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*", -- Поддержка всех файловых типов
      css = { rgb_fn = true }, -- Включает поддержку `rgb(...)` в CSS
      html = { names = false }, -- Отключает цветовые названия (например, "red")
    })
  end,
}

