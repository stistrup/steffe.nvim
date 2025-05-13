local M = {}

function M.setup()
  -- Scroll up/down and center the cursor
  vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
  vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

  -- Swap $ and ¤ for easier end-of-line navigation
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '$', '¤', {})
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '¤', '$', { desc = 'Go to end of line' })
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '€', '$', { desc = 'Go to end of line' })
end

return M
