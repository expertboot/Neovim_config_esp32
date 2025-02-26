return {
  {
    "aveplen/ruscmd.nvim",
    config = function()
      require("ruscmd").setup({
        abbreviations = true, -- Поддержка сокращений команд
        keymaps = true,       -- Поддержка команд в нормальном режиме
      })
    end
  }
}

