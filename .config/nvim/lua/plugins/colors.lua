return {
    
    { "catppuccin/nvim", 
	name = "catppuccin", 
	priority = 1000,
	config = function ()
	    require("catppuccin").setup({
		flavour = "frappe",
		transparent_background = true, -- disables setting the background color.
		float = {
		    transparent = treu, -- enable transparent floating windows
		    solid = false, -- use solid styling for floating windows, see |winborder|
		},
		term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		    comments = { "italic" }, -- Change the style of comments
		    conditionals = { "italic" },
		    loops = {},
		    functions = {},
		    keywords = {},
		    strings = {},
		    variables = {},
		    numbers = {},
		    booleans = {},
		    properties = {},
		    types = {},
		    operators = {},
		},
		lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
		    virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
			ok = { "italic" },
		    },
		    underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
			ok = { "underline" },
		    },
		    inlay_hints = {
			background = true,
		    },
		},
		color_overrides = {},
		custom_highlights = {},
		auto_integrations = true,
		integrations = {
		    cmp = true,
		    gitsigns = true,
		    nvimtree = true,
		    notify = false,
		    mini = {
			enabled = true,
			indentscope_color = "",
		    },
		    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	    })

	    -- setup must be called before loading
	    vim.cmd.colorscheme "catppuccin-nvim"
	end
    },

    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {},
	config = function(_, opts)
	    require('lualine').setup{
		options = {
		    theme = 'catppuccin-nvim',
		},
	    }
	end,
    }
}

