
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",  -- или "BufReadPre", если хочешь раньше
  config = function()
    require("project_nvim").setup {
      detection_methods = { "pattern" },
      patterns = { ".nvim.lua", ".git", "Makefile", "package.json" },
    }
    require("telescope").load_extension("projects")
  end,
  dependencies = { "nvim-telescope/telescope.nvim" },
}
