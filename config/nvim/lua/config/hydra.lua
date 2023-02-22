local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local hints = require('config.hints')
vim.g.mapleader = " "

Hydra({
  name = 'Telescope',
  hint = hints.TelescopeHint,
  config = {
    color = 'teal',
    invoke_on_body = true,
    hint = {
      position = 'middle',
      border = 'rounded',
    },
  },
  mode = 'n',
  body = '<Leader>/',
  heads = {
    { 'f', cmd 'Telescope find_files' },
    { 'g', cmd 'Telescope live_grep' },
    { 'm', cmd 'Telescope help_tags', { desc = 'vim help' } },
    { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
    { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
    { 'h', cmd 'Telescope heading', { desc = 'headings' } },
    { 'k', cmd 'Telescope keymaps' },
    { 'O', cmd 'Telescope vim_options' },
    { 'b', cmd 'Telescope buffers' },
    { 'p', cmd 'Telescope projects', { desc = 'projects' } },
    { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
    { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
    { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
    { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
    { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
    { '<Esc>', nil, { exit = true, nowait = true } },
  }
})
Hydra({
  name = 'Options',
  mode = 'n',
  body = '<Leader>O',
  hint = hints.OptionsHint,
  config = {
    color = 'teal',
    invoke_on_body = true,
    hint = {
      position = 'middle',
      border = 'rounded',
      type = "window",
    },
    funcs = {
      {
        wrap = function()
          vim.cmd("set wrap?")
        end
      },
      {
        linebreak = function()
          vim.cmd("set linebreak?")
        end
      }
    }
  },
  heads = {
    { "w", cmd "set wrap!" },
    { "b", cmd "set linebreak!" },
    { '<Esc>', nil, { exit = true, nowait = true } },
  }
})
-- vim:sw=2:ts=2
