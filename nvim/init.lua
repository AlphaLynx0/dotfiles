-- Syntax highlighting
vim.cmd('syntax enable')

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Use system clipboard for all operations
vim.opt.clipboard:append('unnamedplus')

-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable auto-indenting
vim.opt.smartindent = true

-- Highlight the current line
vim.opt.cursorline = true

-- Show matching brackets
vim.opt.showmatch = true

-- Enable incremental search
vim.opt.incsearch = true

-- Ignore case in search patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable line wrapping
vim.opt.wrap = true

-- Set the command height
vim.opt.cmdheight = 1

-- Enable persistent undo
vim.opt.undofile = true

-- Set the update time (for things like git gutter)
vim.opt.updatetime = 300

-- Always show the sign column
vim.opt.signcolumn = 'yes'
