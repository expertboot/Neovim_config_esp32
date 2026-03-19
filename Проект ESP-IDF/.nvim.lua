
-- УКАЗЫВАЕМ ИСПОЛЬЗУЕМЫЙ CLANG
vim.g.lsp_clangd_binary = "C:/Espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd.exe"




-- ---------------------------------------------------------------------------
-- 🚀 ТЕРМИНАЛ ESP-IDF С ПРИВЯЗКОЙ К ВКЛАДКАМ (TABS)
-- ---------------------------------------------------------------------------

local term_bufs = {} -- Таблица для хранения ID буферов терминалов {tab_id = buf_id}
local term_wins = {} -- Таблица для хранения ID окон терминалов {tab_id = win_id}

-- Функция для получения ID текущей вкладки
local function get_tab()
  return vim.api.nvim_get_current_tabpage()
end

-- 1. Команда запуска терминала
vim.api.nvim_create_user_command('TerminalEsp', function()
  local current_tab = get_tab()

  if term_bufs[current_tab] and vim.api.nvim_buf_is_valid(term_bufs[current_tab]) then
    print("Терминал для этой вкладки уже существует. Используйте :ShowTerminalEsp")
    return
  end

  vim.cmd('botright split')
  vim.cmd('resize 12')

  local util = require("lspconfig.util")
  local root_dir = util.root_pattern(".git", ".nvim.lua", "sdkconfig")(vim.fn.expand("%:p"))

  if root_dir then
    -- Запуск терминала с экспортом окружения
    vim.cmd('terminal cmd.exe /K "cd /d ' .. root_dir .. ' && call C:\\Espressif\\frameworks\\esp-idf-v5.4\\export.bat"')
    
    local buf_id = vim.api.nvim_get_current_buf()
    local win_id = vim.api.nvim_get_current_win()
    
    -- Сохраняем ID именно для ЭТОЙ вкладки
    term_bufs[current_tab] = buf_id
    term_wins[current_tab] = win_id
    
    vim.api.nvim_buf_set_name(buf_id, "ESP-Terminal-" .. current_tab)
  else
    print("❗ Не удалось определить корень проекта")
  end
end, { desc = "Запуск терминала ESP-IDF для текущей вкладки" })

-- 2. Скрытие терминала
vim.api.nvim_create_user_command('HideTerminalEsp', function()
  local current_tab = get_tab()
  local win_id = term_wins[current_tab]

  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, true)
    term_wins[current_tab] = nil
  else
    print("Окно терминала на этой вкладке не найдено!")
  end
end, { desc = "Скрыть терминал текущей вкладки" })

-- 3. Показ скрытого терминала
vim.api.nvim_create_user_command('ShowTerminalEsp', function()
  local current_tab = get_tab()
  local buf_id = term_bufs[current_tab]

  if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
    -- Проверяем, не открыт ли он уже
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == buf_id then
        vim.api.nvim_set_current_win(win)
        term_wins[current_tab] = win
        return
      end
    end

    -- Если скрыт — воссоздаем окно
    vim.cmd('botright split')
    vim.cmd('resize 12')
    local new_win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(new_win_id, buf_id)
    term_wins[current_tab] = new_win_id
  else
    print("Терминал для этой вкладки еще не создан!")
  end
end, { desc = "Показать терминал текущей вкладки" })

-- Горячие клавиши (остаются прежними, но работают контекстно)
vim.keymap.set("n", "<leader>te", ":TerminalEsp<CR>", { silent = true })
vim.keymap.set("n", "<leader>th", ":HideTerminalEsp<CR>", { silent = true })
vim.keymap.set("n", "<leader>ts", ":ShowTerminalEsp<CR>", { silent = true })