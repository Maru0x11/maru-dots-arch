return{

    {
	'romgrk/barbar.nvim',
	dependencies = {
	    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
	    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	},

	init = function() vim.g.barbar_auto_setup = false end,

	opts = {
	    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
	    animation = true,
	    -- insert_at_start = true,
	    -- …etc.
	},

	config = function(_,opts)
	    require('barbar').setup(opts)
	    
	    local map = vim.keymap.set
	    local o = { noremap = true, silent = true }

	    -- Move to previous/next
	    map('n', '<leader>b[', '<Cmd>BufferPrevious<CR>', o)
	    map('n', '<leader>b]', '<Cmd>BufferNext<CR>', o)

	    -- Re-order to previous/next
	    map('n', '<A -<>', '<Cmd>BufferMovePrevious<CR>', o)
	    map('n', '<A-->', '<Cmd>BufferMoveNext<CR>', o)

	    -- Goto buffer in position...
	    for i = 1, 9 do
		map('n', '<C-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', o)
	    end
	    map('n', '<A-0>', '<Cmd>BufferLast<CR>', o)

	    -- Pin/unpin, close
	    map('n', '<A-p>', '<Cmd>BufferPin<CR>', o)
	    map('n', '<A-c>', '<Cmd>BufferClose<CR>', o)

	    -- Buffer-picking mode
	    map('n', '<C-p>', '<Cmd>BufferPick<CR>', o)
	    map('n', '<C-S-p>', '<Cmd>BufferPickDelete<CR>', o)

	    -- Sort by...
	    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', o)
	    map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', o)
	    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', o)
	    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', o)
	    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', o)
	end,
    }
}
