return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "lua", "vim", "vimdoc", "query",
      "go", "gomod", "gosum", "gowork",
      "zig",
    }

    require("nvim-treesitter").install(parsers)

    -- Start highlighting (and treesitter indent) for any filetype with a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
