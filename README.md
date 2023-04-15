# Awesome Neovim Configuration

This repo it to make setting up of [neovim][nvim] >= 0.9 a breeze.
The setup is powered by [💤 lazy.nvim][lazy-nvim]

>For the previous config setup with paq.nvim checkout [paq-branch][https://github.com/Ultra-Code/awesome-neovim/tree/paq]


## ✨ Features Supported
- ⚡ zig, 󰙱 C ,  C++, 󰢱 lua and all other language compilers
- 📦 linters and static analysis through null-ls
- 🥂 lsp servers configured with nvim-lspconfig
- 🧹 autocompletion, formatters and all other features supported by neovim's builtin lsp
- 🦸 Any build system
- ✴️  Treesitter syntax highlighting
- 🔥 Transform your Neovim editor into a full-fledged IDE
- 💤 Easily customize and extend config
- 🚀 Blazingly fast using 💤 [lazy.nvim][lazy-nvim]  and the new lua-loader that byte-compiles and caches lua files

![Awesome-NeoVim with C++](https://github.com/Ultra-Code/awesome-neovim/blob/master/assets/AwesomeNeovimWithC%2B%2B.png)
![Awesome-NeoVim with Zig]()
![Awesome-NeoVim with Lua]()

## Requirement
- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)
- git >= **2.40.0** (gitsigns ...)
- tree-sitter >= **0.20.8** (to enable automatically installing missing parsers when entering buffers)
- a [Nerd Font](https://www.nerdfonts.com/) **_(optional for nvim-tree, lualine, bufferline)_**

>__NOTE__ the languages supported out of the box are
> zig, c++, c, lua, bash/zsh, glsl, json
> __But__ support for other languages like(js, ts, html5+, css3+, vue, markdown, nix) can easily be add by using
> its required [lsp server configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
and installing the server and other accompanying tools for development like linters, static analysers, formatter

## Repo structure
```text
    📂 ~/.config/nvim
    ├── 📂 ftplugin
    │  └── 📂 lua
    │  │   └──  trouble.lua
    │  ├──  gitcommit.lua
    │  ├──  help.lua
    │  └──  zsh.lua
    ├── 📂 lua
    │  └── 📂 config
    │  │   ├──  autocmds.lua
    │  │   ├──  defaults.lua
    │  │   ├──  init.lua
    │  │   ├──  keymaps.lua
    │  │   ├──  lazy.lua
    │  │   ├──  options.lua
    │  │   ├──  syntax.lua
    │  │   └──  utils.lua
    │  └── 📂 plugins
    │      ├──  cmp.lua
    │      ├──  colorscheme.lua
    │      ├──  editor.lua
    │      ├──  gitsigns.lua
    │      ├──  lsp.lua
    │      ├──  neorg.lua
    │      ├──  snip.lua
    │      ├──  telescope.lua
    │      ├──  tree.lua
    │      ├──  treesitter.lua
    │      └──  ui.lua
    ├──  init.lua
    ├──  lazy-lock.json
    ├──  LICENSE
    └──  README.md
```

`ftplugin` directory contains files for setting options or mappings specific to filetypes

`lua/config` directory contains editor autocmds, keymaps, options, defaults, syntax files, utils fn's and
lazy.nvim configuration

`lua/plugins` directory contains all plugins configurations and their mappings

`.editorconfig` file for editor formatting options

`init` file for initializing editor

---


## 🚀 Getting Started

You can find this config **awesome-neovim** [here][awesome-neovim]

<details><summary>Follow the steps below to use
[awesome nvim][awesome-neovim]</summary>

- fork this repo into your account

  github [how to fork a repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)


- Make a backup of your current Neovim files:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone this repo into `$XDG_CONFIG_HOME/nvim` or `$HOME/.config/nvim`

  ```sh
  git clone https://github.com/${YOUR-USERNAME}/awesome-neovim $XDG_CONFIG_HOME/nvim

  ```

- Start Neovim!

  ```sh
  nvim
  ```
</details>

---


### For information on how to use [lazy.nvim][lazy-nvim]

You can throughly go through configuration and if more clarification is required
read [lazy's][lazy-nvim] README

### for help using the various plugins and extensions

```zsh
:help local-addtions
```

to view the help pages and instruction manual on the various extensions

---

[awesome-nvim]: https://github.com/Ultra-Code/awesome-neovim
[lazy-nvim]: https://github.com/folke/lazy.nvim
[nvim]: https://github.com/neovim/neovim/

>>Big ShoutOuts to the Creators of Neovim.
>Another to all the creators of the various neovim extensions.
>And Last but not the least __God Bless The Vim && Neovim Community for this
>hyperextensible and hackable text editor__
