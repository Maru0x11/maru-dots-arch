-- so other plugins can see it 
vim.g.mapleader = " "

require('config.options') 
require('config.keybinds') 

-- plugin manager 
require("config.lazy")

-- oil file browser's setup 
-- header or whatever it's called in neovim is at lua/plugins/oil.lua
require("oil").setup({
    default_file_explorer = true,
    keymaps = {
	["g?"] = { "actions.show_help", mode = "n" },
	["<CR>"] = "actions.select",
	["<C-s>"] = { "actions.select", opts = { vertical = true } },
	["<C-h>"] = { "actions.select", opts = { horizontal = true } },
	["<C-t>"] = { "actions.select", opts = { tab = true } },
	["<C-p>"] = "actions.preview",
	["<C-c>"] = { "actions.close", mode = "n" },
	["<C-l>"] = "actions.refresh",
	["-"] = { "actions.parent", mode = "n" },
	["_"] = { "actions.open_cwd", mode = "n" },
	["`"] = { "actions.cd", mode = "n" },
	["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
	["gs"] = { "actions.change_sort", mode = "n" },
	["gx"] = "actions.open_external",
	["g."] = { "actions.toggle_hidden", mode = "n" },
	["g\\"] = { "actions.toggle_trash", mode = "n" },
    },	
    -- integrate image functionality in oil
    image = function()
	local oil = require("oil")
	local filename = oil.get_cursor_entry().name
	local dir = oil.get_current_dir()
	oil.close()
	local img_clip = require("img-clip")
	img_clip.paste_image({}, dir .. filename)
    end
})

