-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- quit current buffer (Snacks handles window + buffer cleanup)
map("n", "<leader>qw", function()
  Snacks.bufdelete()
end, { desc = "Quit Current Buffer" })

-- Smoothly close current buffer (keep window layout and avoid taking over by file tree)
local function is_normal_buf(buf)
  if buf == 0 then buf = vim.api.nvim_get_current_buf() end
  if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then return false end
  if vim.bo[buf].buftype ~= "" then return false end
  if vim.bo[buf].filetype == "neo-tree" then return false end
  return true
end

local function close_current_buffer(force)
  local cur = vim.api.nvim_get_current_buf()
  local curwin = vim.api.nvim_get_current_win()

  -- Pick a target buffer to show in this window after close
  local target = vim.fn.bufnr('#')
  if not is_normal_buf(target) or target == cur then
    target = nil
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
      if is_normal_buf(b) and b ~= cur then
        target = b
        break
      end
    end
  end

  if not target then
    -- No suitable buffer, create a new empty one so sidebars don't take over
    vim.cmd('enew')
    target = vim.api.nvim_get_current_buf()
  else
    -- Show target in current window before deleting
    vim.api.nvim_win_set_buf(curwin, target)
  end

  -- Now safely delete the original buffer
  local ok, bufremove = pcall(require, 'mini.bufremove')
  if ok then
    bufremove.delete(cur, force)
  else
    vim.cmd((force and 'bdelete! ' or 'bdelete ') .. cur)
  end
end

map('n', '<leader>q', function()
  close_current_buffer(false)
end, { desc = 'Close Buffer' })

map('n', '<leader>Q', function()
  close_current_buffer(true)
end, { desc = 'Close Buffer (force)' })
