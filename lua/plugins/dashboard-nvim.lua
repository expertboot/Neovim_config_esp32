return {
  'nvimdev/dashboard-nvim',
  lazy = false,
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            icon = '󰊄 ',
            desc = 'Недавние файлы',
            group = '@property',
            action = 'Telescope oldfiles', -- Закрываем дерево перед поиском
            key = 'r',
          },
          {
            icon = '󰱼 ',
            desc = 'Поиск текста',
            group = 'Label',
            action = 'Telescope live_grep',
            key = 'g',
          },
          {
            icon = ' ',
            desc = 'Новый файл',
            group = 'DiagnosticHint',
            action = 'startinsert',
            key = 'n',
          },
          {
            icon = '󰒲 ',
            desc = 'Обновить плагины',
            key = 'u',
            action = 'Lazy update',
          },
          {
            icon = ' ',
            desc = 'Настройки',
            key = 'c',
            action = 'edit $MYVIMRC',
          },
        },
        project = { enable = true, limit = 8, icon = '󱏒 ', label = ' Проекты:' },
        footer = { '⚡ Neovim загружен быстро!' },
      },
    })

    -- АВТОМАТИЧЕСКОЕ ЗАКРЫТИЕ NEO-TREE ДЛЯ ЦЕНТРИРОВАНИЯ
    -- Этот скрипт сработает, когда открывается буфер дашборда
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if vim.bo.filetype == "dashboard" then
          local ok, nt_command = pcall(require, "neo-tree.command")
          if ok then
            nt_command.execute({ action = "close" })
          end
        end
      end,
    })
  end,
}
