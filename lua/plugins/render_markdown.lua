return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
	  code = {
		-- Можно включить "подложку" для кода
		style = 'full', 
		highlight = 'DiffAdd', -- Используем стандартный цвет "добавления", он обычно зеленый/серый и заметный
	  },
	}
}