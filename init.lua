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

vim.o.exrc = true

-- В нормальном режиме мапим все русские символы на английские
 vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Позволяет использовать команды на русской раскладке (Normal mode)
--local function map_rus()
 --   local utf8_chars = 'йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,'
 --   local ascii_chars = 'qwertyuiop[]asdfghjkl;\'zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
    
 --   vim.opt.langmap = vim.fn.escape(utf8_chars, ' ,."\\') .. ';' .. vim.fn.escape(ascii_chars, ' ,."\\')
--end

--map_rus()



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

-- Открывает neoTree при запуске программы (безопасный вызов через команду)
--vim.api.nvim_create_autocmd("VimEnter", {
--  callback = function()
--    local ok, nt_command = pcall(require, "neo-tree.command")
--    if ok then
--      nt_command.execute({ action = "show", source = "filesystem" })
--    end
--  end,
--})

-- Умное открытие Neo-tree или Dashboard
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Проверяем, есть ли аргументы при запуске (например, nvim file.txt или nvim .)
    local has_args = vim.fn.argc() > 0
    
    if has_args then
      -- Если мы открыли файл или папку, запускаем Neo-tree
      local ok, nt_command = pcall(require, "neo-tree.command")
      if ok then
        nt_command.execute({ action = "show", source = "filesystem" })
      end
    else
      -- Если аргументов нет, Neo-tree не трогаем (дашборд откроется сам)
      -- Но если вдруг Neo-tree открылся по дефолту, можно его явно закрыть:
      -- vim.cmd("Neotree close")
    end
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
-- *************************************************************************


-------------------------------------- Окно вывод ком портов в WINDOWS -----------------------------------
---------------------------------------------- :SerialPorts ----------------------------------------------
-- 📡 АСИНХРОННЫЙ ВЫВОД COM ПОРТОВ
local serial_buf = nil
local serial_win = nil

local function show_serial_ports()
    -- 1. Подготовка окна и буфера
    if not serial_buf or not vim.api.nvim_buf_is_valid(serial_buf) then
        serial_buf = vim.api.nvim_create_buf(false, true)
        -- Клавиши закрытия
        local close_opts = { buffer = serial_buf, silent = true }
        vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, true) end, close_opts)
        vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(0, true) end, close_opts)
        
        -- Копирование по Enter
        vim.keymap.set('n', '<CR>', function()
            local line = vim.api.nvim_get_current_line()
            local port = line:match("(COM%d+)") 
            if port then
                vim.fn.setreg('+', port)
                print("✅ Copied to clipboard: " .. port)
                vim.api.nvim_win_close(0, true)
            end
        end, close_opts)
    end

    -- 2. Сразу выводим сообщение о загрузке
    local loading_text = { " 📡 Scanning ports...", " Please wait..." }
    vim.api.nvim_buf_set_lines(serial_buf, 0, -1, false, loading_text)

    -- 3. Настройка окна (сначала маленькое для загрузки)
    local opts = {
        relative = 'editor',
        width = 25,
        height = #loading_text,
        col = vim.o.columns - 30,
        row = vim.o.lines - 10, 
        style = 'minimal',
        border = 'rounded',
        title = " Ports ",
        title_pos = "center"
    }

    if not serial_win or not vim.api.nvim_win_is_valid(serial_win) then
        serial_win = vim.api.nvim_open_win(serial_buf, true, opts)
    else
        vim.api.nvim_win_set_config(serial_win, opts)
    end

    -- 4. АСИНХРОННЫЙ ЗАПУСК POWERSHELL
    local cmd = "powershell"
    local args = {
        "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command",
        "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; " ..
        "Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -match '\\(COM\\d+\\)' } | " ..
        "Select-Object -ExpandProperty Name"
    }

    local stdout = vim.loop.new_pipe(false)
    local results = {}

    -- Запускаем процесс в фоновом режиме
    vim.loop.spawn(cmd, {
        args = args,
        stdio = {nil, stdout, nil}
    }, function()
        stdout:read_stop()
        stdout:close()
    end)

    -- Читаем вывод по мере поступления
    stdout:read_start(function(err, data)
        assert(not err, err)
        if data then
            table.insert(results, data)
        else
            -- КОГДА ДАННЫЕ ПОЛНОСТЬЮ ПОЛУЧЕНЫ:
            vim.schedule(function()
                local full_result = table.concat(results)
                
                -- Логика фильтрации (твоя оригинальная)
                local raw_lines = vim.split(full_result, "\r?\n")
                local clean_lines = { " Active Serial Devices:", " -----------------------" }
                
                for _, line in ipairs(raw_lines) do
                    local port = line:match("%((COM%d+)%)")
                    if port then
                        local desc = line:gsub("%s*%(COM%d+%)", ""):gsub("^%s*", ""):gsub("%s*$", "")
                        -- Умная фильтрация имен
                        if desc:find("Bluetooth") then desc = "Bluetooth"
                        elseif desc:find("CP210x") then desc = "CP210x (UART)"
                        elseif desc:find("CH340") then desc = "CH340 (USB)"
                        end
                        if desc == "" then desc = "Generic Device" end
                        table.insert(clean_lines, string.format(" %-7s │ %s", port, desc))
                    end
                end

                if #clean_lines <= 2 then
                    table.insert(clean_lines, " No active COM ports.")
                end

                -- 5. Обновляем буфер и размер окна финальными данными
                if vim.api.nvim_buf_is_valid(serial_buf) then
                    vim.api.nvim_buf_set_lines(serial_buf, 0, -1, false, clean_lines)
                    
                    -- Считаем ширину
                    local final_width = 25
                    for _, l in ipairs(clean_lines) do
                        if #l > final_width then final_width = #l end
                    end

                    -- Перерисовываем окно под новый контент
                    if vim.api.nvim_win_is_valid(serial_win) then
                        vim.api.nvim_win_set_config(serial_win, {
                            width = final_width + 2,
                            height = #clean_lines
                        })
                        
                        -- Добавляем подсветку
                        vim.api.nvim_buf_add_highlight(serial_buf, -1, "String", 0, 0, -1) 
                        vim.api.nvim_buf_add_highlight(serial_buf, -1, "Comment", 1, 0, -1)
                        for i = 2, #clean_lines - 1 do
                            vim.api.nvim_buf_add_highlight(serial_buf, -1, "Keyword", i, 1, 8)
                        end
                    end
                end
            end)
        end
    end)
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
-- *************************************************************************



-- *********** АВТОМАТИЧЕСКОЕ ПЕРЕКЛЮЧЕНИЕ РАСКЛАДКИ ПРИ CMD *************
vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
        -- Проверяем, что вошли именно в режим команд (:), а не поиска (/)
        if vim.v.event.cmdtype == ':' then
            vim.fn.jobstart("im-select.exe 1033")
        end
    end,
})-- *************************************************************************



-- ********* Меняем цвет всплывающего окан ввода команд CMDLINE ***********
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ff9e64", bg = "#3d2b1f" })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#ff9e64" })
  end
})
-- *************************************************************************


-- ******************** Функциона переменовывания табов ********************
function MyTabLine()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    -- Выбираем подсветку (активная или нет вкладка)
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- Номер вкладки (для кликов мышкой)
    s = s .. '%' .. i .. 'T'

    -- ЛОГИКА ИМЕНИ:
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local tab_handle = vim.api.nvim_list_tabpages()[i]
    
    -- Пытаемся взять наше ручное имя
    local ok, custom_name = pcall(vim.api.nvim_tabpage_get_var, tab_handle, "custom_name")
    
    if ok and custom_name and custom_name ~= "" then
      s = s .. '  📂 ' .. custom_name .. '  '
    else
      -- Если ручного нет, берем имя активного файла
      local name = vim.fn.bufname(bufnr)
      if name == '' then
        s = s .. ' [No Name] '
      else
        s = s .. ' ' .. vim.fn.fnamemodify(name, ':t') .. ' '
      end
    end
  end
  s = s .. '%#TabLineFill#%T'
  return s
end

-- Включаем наш кастомный таблайн
vim.opt.tabline = '%!v:lua.MyTabLine()'

vim.api.nvim_create_user_command('TabRename', function(opts)
    local current_tab = vim.api.nvim_get_current_tabpage()
    if opts.args == "" then
        pcall(vim.api.nvim_tabpage_del_var, current_tab, "custom_name")
    else
        vim.api.nvim_tabpage_set_var(current_tab, "custom_name", opts.args)
    end
    vim.cmd("redrawtabline")
end, { nargs = '?' })
-- *************************************************************************





-- ************************ Настройка цветов таблайна **********************
local function setup_tabline_colors()
    -- Активная вкладка: Текст белый, фон темно-серый/синеватый, жирный шрифт
    vim.cmd('highlight TabLineSel guifg=#FFFFFF guibg=#3b4252 gui=bold')
    
    -- Неактивные вкладки: Текст серый, фон более темный, без выделения
    vim.cmd('highlight TabLine guifg=#707070 guibg=#2e3440 gui=none')
    
    -- Фон самой полосы (пустое место): Тот же фон, что и у неактивных
    vim.cmd('highlight TabLineFill guibg=#2e3440 gui=none')
end

-- Запускаем настройку
setup_tabline_colors()

-- Чтобы цвета не слетали при смене цветовой схемы (colorscheme)
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = setup_tabline_colors
})
-- *************************************************************************


-- Если зашли в nvim без файлов, открываем Dashboard
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
      vim.cmd("Dashboard")
    end
  end,
})




-- Глобальная автокоманда для авто-открытия Neo-tree при входе в файл
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("NeotreeAutoOpen", { clear = true }),
  callback = function()
    -- Условия:
    -- 1. Это не дашборд
    -- 2. Это обычный файл (не терминал, не справка)
    -- 3. Буфер имеет имя (не пустой новый файл)
    if vim.bo.filetype ~= "dashboard" 
       and vim.bo.buftype == "" 
       and vim.api.nvim_buf_get_name(0) ~= "" then
      
      -- Используем schedule, чтобы дать Neovim закончить отрисовку файла
      vim.schedule(function()
        local ok, nt_command = pcall(require, "neo-tree.command")
        if ok then
          -- Открываем дерево, но оставляем фокус на коде (reveal = true подсветит файл)
          nt_command.execute({ 
            action = "show", 
            source = "filesystem", 
            position = "left", 
            toggle = false,
            reveal = true 
          })
        end
      end)
    end
  end,
})

-- Дополнительно: Умная команда для вызова дашборда вручную
vim.api.nvim_create_user_command('Dash', function()
  -- Сначала закрываем дерево, чтобы дашборд мог центрироваться по всей ширине
  local ok, nt_command = pcall(require, "neo-tree.command")
  if ok then
    nt_command.execute({ action = "close" })
  end
  vim.cmd("Dashboard")
end, {})



-- Принудительное чтение локального конфига при смене директории
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    local local_config = vim.fn.getcwd() .. "/.nvim.lua"
    if vim.loop.fs_stat(local_config) then
      vim.cmd("source " .. local_config)
    end
  end,
})
