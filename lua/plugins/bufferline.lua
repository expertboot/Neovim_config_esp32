return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",               -- Режим вкладок
        separator_style = "rounded",
        show_buffer_close_icons = false,
        show_close_icon = false,
        
        -- СТАНДАРТ: Bufferline сам решит, что писать (обычно имя файла)
        -- Мы просто отключаем лишние приписки путей
        show_duplicate_prefix = false, 
        enforce_regular_tabs = true,
      }
    })
  end
}