-- ============================================================================ --
-- ===                               PLUGINS                                === --
-- ============================================================================ --
--PLUG INS FOR NEOVIM
--Specify a directory for plugins
---For Neovim: ~/.local/share/nvim/plugged
--To make config resuable system wide use absolute path instead eg.
--/home/$USER/.local/share/nvim/plugged
---Avoid using standard Vim directory names like 'plugin'

require 'paq-nvim' {

{'savq/paq-nvim'};
-- === Editor Plugins === --
--A commenter for different Language
{'b3nj5m1n/kommentary'};

-- === Themes and Colour Scheme ===
{'navarasu/onedark.nvim'};

-- === Git Plugin ===

--A vim plugin which shows git diff in the gutter (sign column).
{'lewis6991/gitsigns.nvim'};

-- === Status Line ===

--Status bar plugin
-- A blazing fast and easy to configure neovim statusline
{'hoob3rt/lualine.nvim'};
-- Tabline
-- A snazzy buffer line (with minimal tab integration) for Neovim
{'akinsho/nvim-bufferline.lua'};

-- === Source Code Formater ===

--A neoformat plugin for code formating
{'sbdchd/neoformat',opt=true};

-- === Fuzzy Finder ===
-- a highly extendable fuzzy finder over lists
-- for Find, Filter, Preview, Pick
{'nvim-lua/popup.nvim'};
{'nvim-lua/plenary.nvim'};
{'nvim-telescope/telescope.nvim'};

-- === Syntax Plugins ===
--Nvim Treesitter configurations and abstraction layer
{'nvim-treesitter/nvim-treesitter', run=':TSUpdate'};

--Pandoc Markdown Syntax Highlighting--
{'vim-pandoc/vim-pandoc-syntax',opt=true};

-- === Preview Plugin ===
--A markdown previewer prebuild binary
{'npxbr/glow.nvim',run = ":GlowInstall",opt=true};


--Vim Wiki
{'vimwiki/vimwiki',opt=true};

-- === Language Specific Plugins ===


-- == LSP Client ===

--Coc is an intellisense engine for Vim/Neovim
--Use release branch (Recommend)
{'neoclide/coc.nvim', branch='release',opt=true};
--
{'neovim/nvim-lspconfig'};
--A light-weight lsp plugin
{'glepnir/lspsaga.nvim'};
--Show function signature when you type
{'ray-x/lsp_signature.nvim'};
-- A pretty diagnostics, references, telescope
-- results, quickfix and location
-- list to help you solve all the trouble your code is causing
{'folke/trouble.nvim'};

--displays a popup with possible key bindings
--of the command you started typing
{"folke/which-key.nvim"};

-- == Auto Completions Engine ==
{'hrsh7th/nvim-compe'};

-- Auto pairs
{'windwp/nvim-autopairs'};

-- === Code Snippets Plugins ===
{"hrsh7th/vim-vsnip"};

--Snippets collection for a set of different
--programming languages for faster development.
{"rafamadriz/friendly-snippets"};

-- === Syntax Highlighting Engine ===
--Asynchronous linting and make framework
{'neomake/neomake'};

-- === Tag Bar Plugin ===

--View and search LSP symbols, tags in Vim/NeoVim.--
{'liuchengxu/vista.vim',opt=true};

-- === UI === --
-- A Neovim File explorer
{'kyazdani42/nvim-tree.lua'};

-- == Icons == --

-- Glyphs and Icons for neovim
--Plug 'ryanoasis/vim-devicons'
{'kyazdani42/nvim-web-devicons'};

-- Initialize plugin system
}
