local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- go install mvdan.cc/gofumpt@latest
-- go install -v github.com/incu6us/goimports-reviser/v3@latest
-- go install github.com/segmentio/golines@latest
-- How to run manually autoformatting? Using -> :lua vim.lsp.buf.format()
local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.clang_format, -- ~/.local/share/nvim/mason/bin/clang-format --style=Google --dump-config > .clang-format
    null_ls.builtins.formatting.sql_formatter,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return opts
