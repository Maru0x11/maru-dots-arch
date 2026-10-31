return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local jdtls = require("jdtls")
          local root = vim.fs.root(0, { "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
            or vim.fn.getcwd()
          jdtls.start_or_attach({
            cmd = { "jdtls", "-data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fs.basename(root) },
            root_dir = root,
          })
          local o = { buffer = true }
          vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, o)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o)
        end,
      })
    end,
  },
}
