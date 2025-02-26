-- Кодировка UTF-8
vim.opt.encoding = 'utf-8'

-- Игнорировать регистр при поиске
vim.opt.ignorecase = true

-- Не игнорировать регистр, если в паттерне есть большие буквы
vim.opt.smartcase = true

-- Подсвечивать найденный паттерн
vim.opt.hlsearch = true

-- Интерактивный поиск
vim.opt.incsearch = true

-- Размер табов - 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Превратить табы в пробелы
vim.opt.expandtab = true

-- Таб перед строкой будет вставлять количество пробелов, определённое в shiftwidth
vim.opt.smarttab = true

-- Копировать отступ на новой строке
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Показывать номера строк
vim.opt.number = true

-- Автокомплиты в командной строке
vim.opt.wildmode = { 'longest', 'list' }

-- Подсветка синтаксиса
vim.cmd('syntax on')

-- Разрешить использование мыши
vim.opt.mouse = 'a'

-- Использовать системный буфер обмена
vim.opt.clipboard = 'unnamedplus'

-- Быстрый скроллинг
vim.opt.ttyfast = true

 vim.opt.termguicolors = true -- Включаем поддержку 24-битных цветов 
-- Цветовая схема
 vim.cmd('colorscheme habamax')
--vim.cmd('colorscheme sonokai')


-- Встроенный плагин для распознавания отступов
vim.cmd('filetype plugin indent on')

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.tabpagenr('$') == 1 and vim.fn.winnr('$') == 1 and vim.b.NERDTree and vim.b.NERDTree.isTabTree() then
      vim.cmd('quit')
    end
  end
})


vim.g.mapleader = " " -- Пробел в качестве спец клавиши SPC - leader

--   Копирование сообщения ошибки/предупредления
vim.keymap.set("n", "<leader>ce", function()
  local diag = vim.diagnostic.get(0)  -- Получаем все диагностики в текущем буфере
  if #diag > 0 then
    vim.fn.setreg("+", diag[1].message)  -- Копируем в системный буфер
    print("Скопировано: " .. diag[1].message)
  else
    print("Нет диагностики на текущей строке.")
  end
end, { silent = true })


--           ТЕРМИНАЛ ДЛЯ ESP-IDF


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
 -- vim.cmd('terminal cmd.exe /K "C:\\Espressif\\frameworks\\esp-idf-v5.4\\export.bat"')
  vim.cmd('terminal cmd.exe /K "export.bat"')

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


require("config.lazy")

-- открывает neoTree при запуске программы 
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  end,
})


