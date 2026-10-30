vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
