return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig", -- Добавляем явную зависимость
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    
    -- Получаем возможности от cmp (чтобы автодополнение не падало)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    mason_lspconfig.setup({
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          if server_name == "clangd" then return end

          -- Используем новый метод настройки через vim.lsp.config
          -- Но явно передаем capabilities, чтобы работал nvim-cmp
          vim.lsp.config(server_name, {
            capabilities = capabilities,
          })
          
          -- Включаем сервер
          vim.lsp.enable(server_name)
        end,
      },
    })
  end,
}