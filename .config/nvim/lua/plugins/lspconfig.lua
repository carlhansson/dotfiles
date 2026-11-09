-- Useful status updates for LSP.
vim.pack.add { gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

-- Sets the `yaml.ansible` filetype for playbooks/roles so ansiblels attaches.
vim.pack.add { gh 'mfussenegger/nvim-ansible' }

-- Configures lua_ls for editing your Neovim config and plugins
-- (replaces the old on_init workaround).
vim.pack.add { gh 'folke/lazydev.nvim' }
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Highlight references of the word under the cursor when it rests there,
    -- and clear them when the cursor moves.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          -- Only clear when the detaching client is the one doing the highlighting,
          -- so e.g. ruff detaching doesn't kill pyright's highlights.
          local detaching = vim.lsp.get_client_by_id(event2.data.client_id)
          if detaching and detaching:supports_method 'textDocument/documentHighlight' then
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end
        end,
      })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

---@type table<string, vim.lsp.Config>
local servers = {
  pyright = {
    settings = {
      -- Let ruff handle import sorting
      pyright = { disableOrganizeImports = true },
    },
  },

  -- Fast linting + code actions; pyright still handles types and hover
  ruff = {
    on_init = function(client) client.server_capabilities.hoverProvider = false end,
  },

  jdtls = {},
  ansiblels = {},

  -- lazydev handles library/workspace setup; formatting is done by stylua via conform
  lua_ls = {
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' }, -- a project's .luarc.json still takes priority
        format = { enable = false },
      },
    },
  },

  tofu_ls = {
    -- Neovim detects .tf as `terraform`; make sure tofu_ls attaches either way
    filetypes = { 'terraform', 'terraform-vars', 'opentofu', 'opentofu-vars' },
  },
  tflint = {},
}

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {}

-- Uses Mason package names, which can differ from the server names above
require('mason-tool-installer').setup {
  ensure_installed = {
    'ansible-language-server',
    'ansible-lint',
    'jdtls',
    'lua-language-server',
    'prettierd',
    'pyright',
    'ruff', -- LSP + ruff_fix / ruff_organize_imports / ruff_format in conform
    'shfmt',
    'stylua',
    'yamlfmt',
    'tflint',
    'tofu-ls',
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
end
vim.lsp.enable(vim.tbl_keys(servers))
