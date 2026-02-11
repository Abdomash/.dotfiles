-- [[ Basic Editor Settings ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.lsp_defaults = false
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.termbidi = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.confirm = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

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

-- [[ Plugin Manager Setup ]]
local uv = vim.uv or vim.loop
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require 'keymaps'
require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
