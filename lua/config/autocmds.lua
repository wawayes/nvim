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

-- Keep the terminal's transparency (e.g. kitty) by clearing background colors after colorscheme loads
local function set_transparent()
  local clear = { bg = "NONE" }
  vim.api.nvim_set_hl(0, "Normal", clear)
  vim.api.nvim_set_hl(0, "NormalNC", clear)
  vim.api.nvim_set_hl(0, "NormalFloat", clear)
  vim.api.nvim_set_hl(0, "SignColumn", clear)
  vim.api.nvim_set_hl(0, "LineNr", clear)
  vim.api.nvim_set_hl(0, "CursorLineNr", clear)
  vim.api.nvim_set_hl(0, "EndOfBuffer", clear)
  vim.api.nvim_set_hl(0, "FloatBorder", clear)
  vim.api.nvim_set_hl(0, "TelescopeNormal", clear)
  vim.api.nvim_set_hl(0, "TelescopeBorder", clear)
end

set_transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("transparent_bg", { clear = true }),
  pattern = "*",
  callback = set_transparent,
  desc = "Make Neovim background transparent",
})
