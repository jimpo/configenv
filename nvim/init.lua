-- Recommended by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Key Mappings
vim.g.mapleader = ","

-- Plugins
vim.pack.add({
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvim-lua/plenary.nvim',
  	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
    	'https://github.com/nvim-tree/nvim-web-devicons',
    	'https://github.com/sindrets/diffview.nvim',
    	'https://github.com/nvim-tree/nvim-tree.lua',
	-- statusline
    	'https://github.com/nvim-lualine/lualine.nvim',
	-- color theme
	'https://github.com/rebelot/kanagawa.nvim',
	-- version control integration
	'https://github.com/NicolasGB/jj.nvim',
})

-- Hook to build telescope-fzf-native after install/update
-- Must be declared BEFORE vim.pack.add()
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim' and
       (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.system(
        { 'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release',
          '&&', 'cmake', '--build', 'build', '--config', 'Release', '--target', 'install' },
        { cwd = ev.data.path }
      )
    end
  end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = 'Telescope LSP document symbols' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope LSP dynamic workspace symbols' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Telescope LSP references' })

require('diffview').setup {}

require('nvim-tree').setup {}

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- Statusline
require('lualine').setup {
  options = {
    icons_enabled = true,
  },
}

vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

-- Syntax highlighting
local treesitter = require('nvim-treesitter')
treesitter.install { 'rust', 'typescript', 'cpp', 'cuda', 'dockerfile', 'markdown' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'markdown' },
  callback = function() vim.treesitter.start() end,
})

-- LSP configs
vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ts_ls')

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'cuda' },
})
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set(
        'n', '<leader>f', 
        function() vim.lsp.buf.format({ async = false }) end,
        opts
    )
  end,
})

-- Color scheme
vim.cmd("colorscheme kanagawa-dragon")

-- Version control integration
require('jj').setup {
  diff = {
    backend = "diffview",
  },
}

