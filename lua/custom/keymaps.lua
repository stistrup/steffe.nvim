local M = {}

function M.setup()
  -- Escape modes with kj
  vim.keymap.set('i', 'kj', '<Esc>', { noremap = true, silent = true, desc = 'Escape Insert' })
  vim.keymap.set('t', 'kj', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Escape Terminal' })

  -- Scroll up/down and center the cursor
  vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
  vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

  -- Swap $ and ¤ for easier end-of-line navigation
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '$', '¤', {})
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '¤', '$', { desc = 'Go to end of line' })
  vim.keymap.set({ 'n', 'v', 'i', 'o' }, '€', '$', { desc = 'Go to end of line' })
  
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>q', ':cclose<CR>', { desc = 'Close quickfix window' })

  vim.keymap.set({ 'n' }, '<leader>o', 'o<Esc>', { desc = 'Create new line (below)' })
  vim.keymap.set({ 'n' }, '<leader>O', 'O<Esc>', { desc = 'Create new line (above)' })
end

return M
