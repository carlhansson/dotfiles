vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,

  -- Only filetypes listed in formatters_by_ft are formatted on save
  format_on_save = { timeout_ms = 500, lsp_format = 'never' },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters = {
    shfmt = { append_args = { '-i', '2', '-ci' } },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    yaml = { 'yamlfmt' },
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    terraform = { 'tofu_fmt' },
    ['terraform-vars'] = { 'tofu_fmt' },
    opentofu = { 'tofu_fmt' },
    ['opentofu-vars'] = { 'tofu_fmt' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
