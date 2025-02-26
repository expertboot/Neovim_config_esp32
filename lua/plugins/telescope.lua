
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            -- Настройка копирования ошибки в буфер обмена
            ["<C-y>"] = function(prompt_bufnr)
              local entry = require("telescope.actions.state").get_selected_entry()
              if entry and entry.text then
                vim.fn.setreg("+", entry.text)  -- Копируем в системный буфер
                print("Скопировано: " .. entry.text)
              end
            end,
          },
        },
      },
    })
  end,
}
