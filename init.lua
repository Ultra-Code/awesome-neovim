--Enable the new |lua-loader| that byte-compiles and caches lua files.
vim.loader.enable()

-- setup editor options -> syntax -> autocmds -> mappings

-- bootstrap lazy.nvim
require("config.lazy")
