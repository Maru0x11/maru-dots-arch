
local function enable_transparency()
    vim.api.nvim_set_hl(0,"Normal", {bg = "none"})
end

return {
    {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
	    vim.cmd [[ colorscheme tokyonight ]]
	    enable_transparency()
	end
    },
    -- add status line
    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {}
    }
}

