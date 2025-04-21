
--           ТЕРМИНАЛ ДЛЯ ESP-ADF


local terminal_buf_id = nil
local terminal_win_id = nil

-- Создание терминала ESP-IDF
vim.api.nvim_create_user_command('TerminalEsp', function()
  if terminal_buf_id then
    print("Терминал уже существует.")
    return
  end

  vim.cmd('botright split')
  vim.cmd('resize 12')

 -- ищем корневой каталог проекта по файлу .nvim.lua
local util = require("lspconfig.util")
local root_dir = util.root_pattern(".git", ".nvim.lua")(vim.fn.expand("%:p"))

if root_dir then
  vim.cmd('terminal cmd.exe /K "cd /d ' .. root_dir .. ' && call C:\\Espressif\\frameworks\\esp-idf-v5.4\\export.bat"')
else
  print("❗ Не удалось определить корень проекта")
end

  -- vim.cmd('terminal cmd.exe /K "startup_env.bat"')
  -- vim.cmd('terminal cmd.exe /K "C:\\Espressif\\frameworks\\esp-adf\\export.bat"')

  terminal_buf_id = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(terminal_buf_id, "term://ESP32")
  terminal_win_id = vim.api.nvim_get_current_win()
end, { desc = "Запуск терминала с ESP-IDF внизу текущей вкладки" })

-- Скрытие терминала ESP-IDF
vim.api.nvim_create_user_command('HideTerminalEsp', function()
  if terminal_win_id then
    vim.api.nvim_win_close(terminal_win_id, true)
    terminal_win_id = nil
  else
    print("Терминал не найден!")
  end
end, { desc = "Скрыть терминал ESP-IDF только если он открыт" })

-- Показ скрытого терминала ESP-IDF
vim.api.nvim_create_user_command('ShowTerminalEsp', function()
  if terminal_buf_id then
    -- Проверяем, существует ли окно с нужным буфером
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
      if vim.api.nvim_win_get_buf(win) == terminal_buf_id then
        vim.api.nvim_set_current_win(win)
        terminal_win_id = win
        return
      end
    end

    -- Если окно не найдено, создаем новое
    vim.cmd('botright split')
    vim.cmd('resize 12')
    local new_win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(new_win_id, terminal_buf_id)
    terminal_win_id = new_win_id
  else
    print("Терминал не найден!")
  end
end, { desc = "Показать терминал ESP-IDF, если он скрыт" })

-- Горячая клавиша для открытия терминала ESP-IDF
vim.keymap.set("n", "<leader>te", ":TerminalEsp<CR>", { desc = "Открыть терминал ESP-IDF" })
-- Горячая клавиша для скрытия терминала ESP-IDF
vim.keymap.set("n", "<leader>th", ":HideTerminalEsp<CR>", { desc = "Скрыть терминал ESP-IDF" })
-- Горячая клавиша для показа спрятанного терминала ESP-IDF
vim.keymap.set("n", "<leader>ts", ":ShowTerminalEsp<CR>", { desc = "Показать терминал ESP-IDF" })




-- ******************************************************************************************************************
