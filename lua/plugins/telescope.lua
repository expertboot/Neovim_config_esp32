return {
  "nvim-telescope/telescope.nvim",
  -- Исправил dependencies: обычно это plenary.nvim
  dependencies = { "nvim-lua/plenary.nvim" },
  
  -- Секция маппингов для вызова Telescope
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" }, 
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Search Diagnostics" },
  },

  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            -- Ваша настройка копирования в буфер обмена
            ["<C-y>"] = function(prompt_bufnr)
              local entry = require("telescope.actions.state").get_selected_entry()
              if entry and (entry.text or entry.value) then
                local content = entry.text or entry.value
                vim.fn.setreg("+", content)
                print("Скопировано: " .. content)
              end
            end,
          },
        },
      },
    })
  end,
}