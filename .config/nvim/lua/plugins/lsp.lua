return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },

        config = function()
            require("mason").setup()

	    -- Lua
	    vim.lsp.config("lua_ls", {
		settings = {
		    Lua = {
			diagnostics = {
			    globals = { "vim" },
			},
		    },
		},
	    })

	    -- Install and automatically enable servers
	    require("mason-lspconfig").setup({
		ensure_installed = {
		    "lua_ls",
		    "gopls",
		    "zls",
		    "rust_analyzer",
		    "clangd",
		    "basedpyright",
		},
	    })
	end,
    },
    {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
	    "nvim-treesitter/nvim-treesitter",
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    lightbulb = {
		enable = false,
	    },
	},
    },
}
