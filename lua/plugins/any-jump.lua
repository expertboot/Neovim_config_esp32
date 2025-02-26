-- Установка плагина any-jump.vim с помощью Lazy
return {
    {
        "pechorin/any-jump.vim",  -- Репозиторий плагина
        config = function()
            -- Дополнительные настройки плагина, если нужно
            -- Например, включить поиск после ввода команды
            vim.g.any_jump_enable_jump_after_search = 1  -- Пример настройки
        end
    }
}

