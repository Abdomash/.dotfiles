local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', '<esc>', '<cmd>nohlsearch<cr>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })
map('n', '<c-h>', '<c-w><c-h>', { desc = 'Move focus to the left window' })
map('n', '<c-l>', '<c-w><c-l>', { desc = 'Move focus to the right window' })
map('n', '<c-j>', '<c-w><c-j>', { desc = 'Move focus to the lower window' })
map('n', '<c-k>', '<c-w><c-k>', { desc = 'Move focus to the upper window' })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('UiEnter', {
  callback = function()
    local uv = vim.uv or vim.loop
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local stats = uv.fs_stat(buffer_name)
    if stats and stats.type == 'directory' then
      vim.cmd('Neotree toggle position=current dir=' .. buffer_name)
    end
  end,
})
