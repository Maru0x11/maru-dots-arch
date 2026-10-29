local tmux_char = {
  function()
    -- check if current pane is zoomed
    local result = io.popen("tmux list-panes -F '#F' | grep Z")

    if result ~= nil and result:read("*a") ~= "" then
      result:close()
      return "tmux-zoomed" --current pane is zoomed
    else
      return "tmux" -- not zoomed
    end
  end,
  padding = { left = 1, right = 1 }, -- We don't need space before this
  cond = function()
    return os.getenv("TMUX") ~= nil
  end,
  on_click = function()
    os.execute("tmux resize-pane -Z")
  end,
}

return {
    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
	    sections = {
		lualine_z = {
		    tmux_char,
		},
	    }
	}
    }

}
