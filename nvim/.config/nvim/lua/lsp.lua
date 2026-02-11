local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local use_text_mode = true
local function toggle_diagnostic_display()
  if use_text_mode then
    use_text_mode = false
    vim.diagnostic.config {
      virtual_text = false,
      virtual_lines = { current_line = true },
    }
  else
    use_text_mode = true
    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false,
    }
  end
end

vim.keymap.set('n', '<leader>td', toggle_diagnostic_display, {
  desc = 'Toggle diagnostic virtual text/lines',
})

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  underline = true,
  update_in_insert = false,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup 'kickstart-lsp-attach',
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
    map('gt', require('telescope.builtin').lsp_type_definitions, '[g]oto [t]ype definition')
    map('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
        group = augroup 'kickstart-lsp-detach',
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  lua_ls = {
    settings = {
      lua = {
        completion = {
          callsnippet = 'replace',
        },
      },
    },
  },
  vtsls = {},
  tailwindcss = {},
  unocss = {},
  eslint = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'prettier',
  'prettierd',
  'eslint_d',
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
