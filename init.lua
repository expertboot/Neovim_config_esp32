-- Кодировка UTF-8
vim.opt.encoding = 'utf-8'

vim.g.mapleader = " " -- Пробел в качестве спец клавиши SPC - leader

-- Игнорировать регистр при поиске
vim.opt.ignorecase = true

-- Не игнорировать регистр, если в паттерне есть большие буквы
vim.opt.smartcase = true

-- Подсвечивать найденный паттерн
vim.opt.hlsearch = true

-- Интерактивный поиск
vim.opt.incsearch = true

-- Размер табов - 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

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


vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})

-- в режиме вставка мапим ESC на jk
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'оо', '<Esc>', { noremap = true, silent = true })
vim.opt.timeoutlen = 500 -- Время ожидания в миллисекундах (стандарт 1000)

-- Перемещение через Alt + hjkl (английская раскладка)
vim.keymap.set('i', '<A-h>', '<Left>', { noremap = true })
vim.keymap.set('i', '<A-j>', '<Down>', { noremap = true })
vim.keymap.set('i', '<A-k>', '<Up>', { noremap = true })
vim.keymap.set('i', '<A-l>', '<Right>', { noremap = true })

-- Перемещение через Alt + ролд (русская раскладка)
vim.keymap.set('i', '<A-р>', '<Left>', { noremap = true })
vim.keymap.set('i', '<A-о>', '<Down>', { noremap = true })
vim.keymap.set('i', '<A-л>', '<Up>', { noremap = true })
vim.keymap.set('i', '<A-д>', '<Right>', { noremap = true })

-- Позволяет многократно менять отступ в визуальном режиме
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- Навигация по окнам через Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- Переключение вкладок через Tab / Shift+Tab (если не используете их для другого)
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

-- В нормальном режиме мапим все русские символы на английские
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Сброс подсветки поиска при нажатии Esc в нормальном режиме
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })




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



require("config.lazy")

-- открывает neoTree при запуске программы 
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  end,
})


-- Автозагрузка project_config.lua если он есть в корне проекта
local project_config = vim.fn.getcwd() .. "/neovim_config.lua"
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end


local project_root = vim.fn.findfile(".nvim.lua", ".;")
if project_root ~= "" then
  dofile(vim.fn.fnamemodify(project_root, ":p"))
end



vim.o.exrc = true         -- разрешает локальные конфиги
vim.o.secure = true       -- запрещает запуск опасных команд в локальных exrc-файлах


-- авто фикс предепреждения в коде от LSP сервера - SPC + c + a
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })


-- ************************ Вывод диагностической информации от LSP *********************
-- Включаем всплывающее окно ошибок и предуприждения 

-- Настройка отображения диагностик (ошибок)
vim.diagnostic.config({
  virtual_text = false, -- Отключаем текст ошибки в конце строки (чтобы не загромождать)
  signs = true,         -- Оставляем иконки на боковой панели (gutter)
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded", -- Красивые закругленные края окна
    source = "always",  -- Показывать, откуда ошибка (например, lua_ls)
    header = "",
    prefix = "",
  },
})

-- Автокоманда: показывать окно с ошибкой при наведении курсора
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})



-- Переход к следующей/предыдущей ошибке
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- Открыть список всех ошибок текущего файла в стандартном окне (Quickfix)
vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Показать ошибку под курсором по нажатию 'gl' (get line/diagnostic)
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })
-- Или по нажатию заглавной K (традиционный способ в Neovim)
vim.keymap.set('n', 'K', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })



-------------------------------------- Окно вывод ком портов в WINDOWS -----------------------------------
---------------------------------------------- :SerialPorts ----------------------------------------------

-- Храним ID буфера и окна вне функции
local serial_buf = nil
local serial_win = nil

local function show_serial_ports()
    -- 1. Получаем данные
	
	local cmd = [[powershell -NoProfile -ExecutionPolicy Bypass -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -match '\(COM\d+\)' } | Select-Object -ExpandProperty Name"]]
    --local cmd = [[powershell -Command "Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -match '\(COM\d+\)' } | Select-Object -ExpandProperty Name"]]
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    if result == "" or result == nil then
        result = "No active COM ports found."
    end

    local replacements = {
        ["PCIe to High Speed Serial Port"] = "PCI",
        ["Silicon Labs CP210x USB to UART Bridge"] = "CP210x",
        ["USB-SERIAL CH340"] = "CH340",
        ["Standard Serial over Bluetooth link"] = "BT Serial",
        -- Добавляем фильтр для русской версии Windows:
        ["Стандартный последовательный порт по соединению Bluetooth"] = "Bluetooth",
        ["Стандартный последовательный порт по соединению"] = "" -- на всякий случай
    }

    local raw_lines = vim.split(result, "\r?\n")
    local clean_lines = { " Active Serial Devices:", " -----------------------" }
    
    for _, line in ipairs(raw_lines) do
        local port = line:match("%((COM%d+)%)")
        if port then
            -- 1. Очищаем описание от (COMxx)
            local desc = line:gsub("%s*%(COM%d+%)", ""):gsub("^%s*", ""):gsub("%s*$", "")

            -- 2. Умная фильтрация
            if desc:find("Bluetooth") or desc:find("Блютуз") then
                desc = "Bluetooth"
            elseif desc:find("CP210x") then
                desc = "CP210x (Silicon Labs)"
            elseif desc:find("CH340") then
                desc = "CH340 (USB-Serial)"
            elseif desc:find("PCIe") then
                desc = "PCIe Serial"
            else
                -- 3. Если ничего не совпало, просто удаляем стандартную "воду"
                desc = desc:gsub("Стандартный последовательный порт по соединению", "")
                desc = desc:gsub("Standard Serial over Bluetooth link", "")
                -- Убираем лишние пробелы по краям после вырезания
                desc = desc:gsub("^%s*", ""):gsub("%s*$", "")
            end

            -- Если описание всё же пустое
            if desc == "" then desc = "Generic Device" end
            
            table.insert(clean_lines, string.format(" %-7s │ %s", port, desc))
        end
    end

    -- 2. Управление буфером (создаем или используем старый)
    if not serial_buf or not vim.api.nvim_buf_is_valid(serial_buf) then
        serial_buf = vim.api.nvim_create_buf(false, true)
        -- Настраиваем клавиши только один раз при создании буфера
        vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, { buffer = serial_buf, silent = true })
        vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(0, true) end, { buffer = serial_buf, silent = true })
		
		vim.keymap.set('n', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    -- Ищем строго COM и цифры после него
    local port = line:match("(COM%d+)") 
    
    if port then
        -- Дополнительная подстраховка: удаляем всё, что не буквы и не цифры
        port = port:gsub("[^%w]", "")
        
        -- Используем встроенную функцию Neovim для работы с клипбордом напрямую
        -- Это надежнее, чем ручной вызов регистров в данной ситуации
        vim.schedule(function()
            local success = pcall(vim.fn.setreg, '+', port)
            if success then
                print("✅ Copied: " .. port)
            else
                print("❌ Clipboard error (win32yank failed)")
            end
        end)
        
        vim.api.nvim_win_close(0, true)
    end
end, { buffer = serial_buf, silent = true })
    end

    -- Обновляем текст в буфере
    vim.api.nvim_buf_set_lines(serial_buf, 0, -1, false, clean_lines)
	
		-- Подсветим номера портов (COMxx) зеленым цветом
	vim.api.nvim_buf_add_highlight(serial_buf, -1, "String", 0, 0, -1) 
	vim.api.nvim_buf_add_highlight(serial_buf, -1, "Comment", 1, 0, -1)
	for i = 2, #clean_lines - 1 do
		vim.api.nvim_buf_add_highlight(serial_buf, -1, "Keyword", i, 1, 8)
	end

    -- 3. Расчет геометрии
    local max_width = 30
    for _, l in ipairs(clean_lines) do
        if #l > max_width then max_width = #l end
    end

    local term_height = 0
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        if vim.bo[bufnr].buftype == 'terminal' then
            term_height = vim.api.nvim_win_get_height(win_id)
            break
        end
    end

    local opts = {
        relative = 'editor',
        width = max_width + 2,
        height = #clean_lines,
        col = vim.o.columns - max_width - 4,
        row = vim.o.lines - term_height - #clean_lines - 3, 
        style = 'minimal',
        border = 'rounded',
        title = " Ports ",
        title_pos = "center"
    }

-- 4. Управление окном (Logic: Toggle/Update)
    if serial_win and vim.api.nvim_win_is_valid(serial_win) then
        -- Если окно уже открыто, просто обновляем его содержимое и размер
        vim.api.nvim_win_set_config(serial_win, opts)
        -- Опционально: переносим фокус в окно при обновлении
        vim.api.nvim_set_current_win(serial_win)
    else
        -- Если окна нет — открываем
        serial_win = vim.api.nvim_open_win(serial_buf, true, opts)
    end
end

vim.api.nvim_create_user_command('SerialPorts', show_serial_ports, {})


-- 5. Назначение горячих клавиш
-- Открытие / Обновление (например, на F4 или <leader>p)
vim.keymap.set('n', '<F4>', ':SerialPorts<CR>', { silent = true, desc = "Toggle Serial Ports" })
vim.keymap.set('n', '<leader>p', ':SerialPorts<CR>', { silent = true, desc = "Serial Ports" })

-- Команда для принудительного закрытия, если ты не в окне (опционально)
vim.keymap.set('n', '<leader>pc', function()
    if serial_win and vim.api.nvim_win_is_valid(serial_win) then
        vim.api.nvim_win_close(serial_win, true)
    end
end, { desc = "Close Serial Ports Window" })






-- Меняем цвет всплывающего окан ввода команд CMDLINE

vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "#3d2b1f", fg = "#ebdbb2" })

-- Попробуй это, если специфичные для Noice группы не реагируют
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ff9e64", bg = "#3d2b1f" })


vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#ff9e64" })
    -- и остальные...
  end
})



