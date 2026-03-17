return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    -- 1. Хоткеи при подключении LSP
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

    -- 2. Capabilities (для автодополнения)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    -- 3. Настройка CLANGD через новый API
    -- Берем путь из глобальной переменной (которую мы задаем в .nvim.lua проекта)
    local clang_cmd = vim.g.esp_path or "clangd"

    vim.lsp.config('clangd', {
      capabilities = capabilities,
      install = {
        cmd = {
          clang_cmd,
          "--background-index",
          "--offset-encoding=utf-16",
          "--query-driver=**",
          "--log=error",
        },
      },
      -- Файлы-маркеры корня проекта
      root_markers = { "compile_commands.json", "sdkconfig", ".git" },
    })
    
    -- Включаем clangd
    vim.lsp.enable('clangd')

    -- 4. Настройка LUA_LS
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { checkThirdParty = false },
        },
      },
    })
    
    -- Включаем lua_ls
    vim.lsp.enable('lua_ls')
  end
}