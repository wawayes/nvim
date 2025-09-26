-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable any format-on-save for specific filetypes
-- This prevents Conform/LSP or other formatters from running on save
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_format_ts_js", { clear = true }),
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.b.autoformat = false
  end,
  desc = "Disable format-on-save for ts/tsx/js/jsx",
})
