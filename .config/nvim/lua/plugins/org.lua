return {
    {
	'https://github.com/nvim-orgmode/orgmode',
	config = function()
	    local org = require('orgmode').setup({
		org_agenda_files = '~/orgfiles/**/*',
		org_default_notes_file = '~/Documents/vault/refile.org',
	    })
	    vim.lsp.enable('org')
	end
    }
}
