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


--           ТЕРМИНАЛ ДЛЯ ESP-IDF

-- ******************************************************************************************************************


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


