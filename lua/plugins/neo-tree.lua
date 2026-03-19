return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  config = function()
    require("neo-tree").setup({
      filesystem = {
        commands = {
          open_project_in_new_tab = function(state)
           local node = state.tree:get_node()
			local path = (node.type == "directory") and node.path or vim.fn.fnamemodify(node.path, ":h")
			local project_name = vim.fn.fnamemodify(path, ":t")

			vim.cmd("tabnew")
			vim.cmd("tcd " .. vim.fn.fnameescape(path))
			-- Просто ставим переменную, таблайн сам её отрисует
			vim.api.nvim_tabpage_set_var(0, "custom_name", project_name)
			vim.cmd("Neotree show")
          end,
        },
      },
      window = {
        mappings = {
          ["T"] = "open_project_in_new_tab",
        },
      },
    })
  end,
}