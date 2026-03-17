return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    -- 1. Хоткеи (без изменений)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gb', '<C-t>', opts)
        vim.keymap.set('n', 'gdt', '<C-w><C-]><C-w>T', opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'F', function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set('n', '3r', vim.lsp.buf.rename, opts)
      end,
    })

    -- 2. Подготовка возможностей (capabilities)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    -- 3. Настройка clangd (ESP32 + обычный)
    local esp_path = "C:/Espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd.exe"

    vim.lsp.config('clangd', {
      -- Добавляем capabilities прямо сюда
      capabilities = capabilities,
      -- Настройки запуска
      install = {
        cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
      },
      root_markers = { "compile_commands.json", "sdkconfig", ".git" },
      
      on_new_config = function(new_config, root_dir)
        if root_dir and (root_dir:match("C:/_ESP32") or vim.fn.filereadable(root_dir .. "/sdkconfig") == 1) then
          -- В новом API меняем cmd в new_config
          new_config.cmd = { 
            esp_path, 
            "--background-index", 
            "--log=error", 
            "--offset-encoding=utf-16" 
          }
        end
      end,
    })
    vim.lsp.enable('clangd')

    -- 4. Настройка lua_ls (с поддержкой автодополнения)
    vim.lsp.config('lua_ls', {
      capabilities = capabilities, -- Обязательно добавляем сюда!
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { checkThirdParty = false },
        }
      }
    })
    vim.lsp.enable('lua_ls')
  end
}