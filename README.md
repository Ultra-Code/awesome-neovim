# Awesome Neovim Configuration

This repo it to make setting up of [neovim][nvim] >= 0.9 a breeze.
The setup is powered and managed by [💤 lazy.nvim][lazy-nvim] plugin manager

>__NOTE__ For the previous config setup with paq.nvim checkout [paq-branch][paq-nvim-branch]


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


## 😍 Screenshots

###  C++
![c++ with code action](https://user-images.githubusercontent.com/22438427/232250467-a2b64fcd-fe02-4376-9ff3-a4062e6e53d3.png)
![c++ with errors](https://user-images.githubusercontent.com/22438427/232250501-06f54292-46ad-44e7-945b-6d0ddb655621.png)

### ⚡ Zig
![Zig with error](https://user-images.githubusercontent.com/22438427/232250532-21b2ba11-b432-4efd-929a-d252e9d4b992.png)
![Zig struct hovered](https://user-images.githubusercontent.com/22438427/232250572-aaca84c6-98de-4632-b863-357a7748dfcb.png)

### 󰢱 Lua
![Lua with with errors](https://user-images.githubusercontent.com/22438427/232250603-e33108ab-235b-42f6-b12a-478ac259d93e.png)
![Lua with preview definition](https://user-images.githubusercontent.com/22438427/232250636-0500c2c7-04db-4438-b9b9-5e04a2f2ac02.png)

<!-- ### 🚀 Startup Time -->


## ⚡️ Requirement
- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)
- git >= **2.40.0** (gitsigns ...)
- tree-sitter >= **0.20.8** (to enable automatically installing missing parsers when entering buffers)
- a [Nerd Font](https://www.nerdfonts.com/) **_(optional, for nvim-tree, lualine, bufferline)_**


>__NOTE__ the languages supported out of the box are
> zig, c++, c, lua, bash/zsh, glsl, json
> __But__ support for other languages like(js, ts, html5+, css3+, vue, markdown, nix) can easily be add by using
> its required [lsp server configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
and installing the server and other accompanying tools for development like linters, static analysers, formatter


## 📂 Directory structure
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

`ftplugin` directory contains files for setting `options` or `mappings` specific to filetypes

`lua/config` directory contains editor `autocmds`, `keymaps`, `options`, `defaults`, `syntax files`, `utils fn's` and
`lazy.nvim` configuration

`lua/plugins` directory contains all `plugins` configurations and their `mappings`

`.editorconfig` file for editor `formatting` options

`init` initializing/start point for nvim editor


---


## 🚀 Getting Started

You can find **awesome-neovim** [here][awesome-nvim]

<details><summary>Follow the steps below to use <b>awesome-neovim</b> </summary>

- fork this repo into your account

  GitHub [how to fork a repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)


- Make a backup of your current Neovim files at $XDG_CONFIG_HOME/nvim and $XDG_DATA_HOME/nvim:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone the repo into `$XDG_CONFIG_HOME/nvim` or `$HOME/.config/nvim`

  ```sh
  git clone https://github.com/${YOUR-USERNAME}/awesome-neovim $XDG_CONFIG_HOME/nvim

  ```

- Start Neovim!

  ```sh
  nvim
  ```
</details>


---


## ⚙️  For information on how to use [lazy.nvim][lazy-nvim]

You can thoroughly go through awesome-neovim configuration and if
more clarification is required read [lazy's][lazy-nvim] README

 **for help using the various plugins and extensions**

```zsh
:help local-addtions
```

To view the help pages and instruction manual on the various extensions


[awesome-nvim]: https://github.com/Ultra-Code/awesome-neovim
[lazy-nvim]: https://github.com/folke/lazy.nvim
[nvim]: https://github.com/neovim/neovim/
[paq-nvim-branch]: https://github.com/Ultra-Code/awesome-neovim/tree/paq

## 👏 Credit
- *Huge credit to* [_@folke_](https://github.com/folke), *I learnt a lot from his lazy config* [repo](https://github.com/LazyVim/LazyVim)
- *Big Shout Out to the creators of the various plugins which make nvim terrific*
- *Another to all the creators of the various neovim extensions.*

>And Last but not the least __God Bless The Vim && Neovim Community for this hyperextensible and hackable text editor__
