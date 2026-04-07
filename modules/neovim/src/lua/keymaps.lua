return {
	setup = function()
		vim.keymap.set(
		  "n",
		  "<Esc>",
		  "<cmd>nohlsearch<CR>",
		  { desc = "Clear highlight", }
		)
		vim.keymap.set(
		  "n",
		  "gD",
		  vim.lsp.buf.declaration,
		  { desc = "Go to declaration", }
		)
		vim.keymap.set(
		  "n",
		  "<Leader>ca",
		  vim.lsp.buf.code_action,
		  { desc = "See available code actions", }
		)
		vim.keymap.set(
		  "n",
		  "<Leader>rn",
		  vim.lsp.buf.rename,
		  { desc = "Smart rename", }
		)
		vim.keymap.set(
		  "n",
		  "<Leader>d",
		  vim.diagnostic.open_float,
		  { desc = "Show line diagnostics", }
		)
		vim.keymap.set(
		  "t",
		  "<Esc><Esc>",
		  "<C-\\><C-n>",
		  { desc = "Leave terminal mode", }
		)
		vim.keymap.set(
		  "n",
		  "<C-h>",
		  "<C-w>h",
		  { desc = "Go to left window" }
		)
		vim.keymap.set(
		  "n",
		  "<C-j>",
		  "<C-w>j",
		  { desc = "Go to lower window" }
		)
		vim.keymap.set(
		  "n",
		  "<C-k>",
		  "<C-w>k",
		  { desc = "Go to upper window" }
		)
		vim.keymap.set(
		  "n",
		  "<C-l>",
		  "<C-w>l",
		  { desc = "Go to right window" }
		)
    vim.api.nvim_create_autocmd(
      "ModeChanged",
      {
        pattern = "*:[V\x16]*",
        callback = function()
          vim.wo.relativenumber = vim.wo.number
        end,
      }
    )
    vim.api.nvim_create_autocmd(
      "ModeChanged",
      {
        pattern = "[V\x16]*:*",
        callback = function()
          vim.wo.relativenumber = false
        end,
      }
    )
    vim.keymap.set(
      "n",
      "go",
      "o<Esc>k",
      { desc = "Add empty line below" }
    )
    vim.keymap.set(
      "n",
      "gO",
      "O<Esc>j",
      { desc = "Add empty line above" }
    )
    vim.keymap.set(
      "n",
      "gV",
      '"`[" .. getregtype()[0] .. "`]"',
      { expr = true, desc = "Select last pasted text" }
    )
    vim.keymap.set(
      { 'n', 'x' },
      'gy',
      '"+y',
      { desc = 'Copy to system clipboard' }
    )
    vim.keymap.set(
      'n',
      'gp',
      '"+p',
      { desc = 'Paste from system clipboard' }
    )
    vim.keymap.set(
      'x',
      'gp',
      '"+P',
      { desc = 'Paste from system clipboard' }
    )
    vim.keymap.set(
      'n',
      '<Tab>',
      'van',
      { remap = true, desc = 'Init treesitter selection' }
    )
    vim.keymap.set(
      'x',
      '<Tab>',
      'an',
      { remap = true, desc = 'Expand node' }
    )
    vim.keymap.set(
      'x',
      '<S-Tab>',
      'in',
      { remap = true, desc = 'Shrink node' }
    )
	end,
}
