# Awesome Neovim Configuration

This is to make setting up of neovim >= 0.7 a breeze.
### NOTE : for vim >= 8 checkout [vim branch](https://github.com/Ultra-Code/awesome-neovim/tree/vim)

## Awesome NeoVim with C++

Supports the following
- zig, c , c++ compilers
- linters and static analysis through null-ls
- formatters using neovim builtin lsp
- lsp server with nvim-lspconfig lsp client
- Any build system
- Treesitter syntax highlighting
- autocompletion,documentation and all other features supported by any lsp
  server you configure

![Awesome-NeoVim with C++](https://github.com/Ultra-Code/awesome-neovim/blob/master/assets/AwesomeNeovimWithC%2B%2B.png)

>__NOTE__ the languages supported out of the box are
> zig , c++ , c , lua , js , ts , html5+ , css3+ , vue , markdown , json , glsl , nix
>__But__ support for other languages can easily be add by using it required
[lsp server configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
and installing the server and other accompaning tools for development like linters , static analysers, formatter

## Requirement

Unlike the [vim branch]() with neovim >= 0.6 most plugings written in lua and don't depend on python or node
But if you decide to use a plugin that rely's on any of these you would have to install them but I recommend
you find their lua equivalent. Chances are that it will be faster (due to luajit) and more well
intergrated with neovim >= 0.6

__Neovim__
Neovim does come out of the box with luajit and treesitter support

## Repo structure
```text
    📂 ~/.config/nvim
    ├── 📂 lua
    │  └── 📂 lazy
    │  │   ├──  glow.lua
    │  │   ├──  init.lua
    │  │   ├──  symbols.lua
    │  │   ├──  telescope.lua
    │  │   └──  trouble.lua
    │  └── 📂 mapping
    │  │   ├──  highlighting.lua
    │  │   ├──  init.lua
    │  │   ├──  lspconfig.lua
    │  │   ├──  spellcheck.lua
    │  │   ├──  tab_buffer.lua
    │  │   ├──  terminal.lua
    │  │   └──  tree.lua
    │  └── 📂 plugrc
    │  │   └── 📂 lspconfig
    │  │   ├──  autopairs.lua
    │  │   ├──  compe.lua
    │  │   ├──  gitsigns.lua
    │  │   ├──  init.lua
    │  │   ├──  neorg.lua
    │  │   ├──  tree.lua
    │  │   └──  whichkey.lua
    │  ├──   editor.lua
    │  ├──   plugins.lua
    │  ├──   terminal.lua
    │  └── 📂 ui.lua
    │  │   ├──  init.lua
    │  │   ├──  bufferline.lua
    │  │   ├──  lualine.lua
    │  │   └──  treesitter.lua
    │  └──   utils.lua
    ├──  README.md
    ├──  LICENSE
    └──  init.lua
```

`lua/lazy` directory contains file for lazy loading of plugins

`lua/mapping` directory contains all key mappings

`lua/plugrc` directory contains configuration for plugins

`lua/editor` file contains neovim editor configuration.

`lua/plugins` file contains the list of all plugins

`lua/terminal` file contains configuration for neovim builtin terminal

`lua/ui` file contains tabline , statusline and treesitter configuration

`lua/utils` file contains some resuable functions

To use this awesome configuration clone this repo into `$XDG_CONFIG_HOME/nvim` or `$HOME/.config/nvim`

## Installation of Paq

__Paq is a Neovim package manager written in Lua.__ as quoted by their site [Paq](https://github.com/savq/paq-nvim)

#### Unix

```zsh
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
```

##### Windows (PowerShell)

```powershell
git clone https://github.com/savq/paq-nvim.git "$env:LOCALAPPDATA\nvim-data\site\pack\paqs\start\paq-nvim"
```

#### _NOTE_

_There is automatic Paq installation for all neovim.
You can automate the process by putting the following commands in your neovim lua configuration
file as suggested [here][auto]. and open nvim and watch some beautiful magic happen.
___This is a one time activity so after Paq has been istalled you can
remove these commands from your config.___ ._

__Thanks to @savq/paq-nvim and all colaborators.__

[auto]: https://github.com/savq/paq-nvim#bootstrapping

### Install Plugins Using Paq

move to `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim/` and open the plugins.lua file
and run this commands

```zsh
:luafile %    # To cause lua to update cache of the file

:PaqInstall   #Install all packages listed in your configuration

:PaqUpdate    #Update all packages already on your system

:PaqClean     #Comment or remove the plugin you want to remove from plugins.lua
              #then :luafile % and run PaqClean to remove that commented/removed plugin

:PaqSync      #Execute the three operations listed above
```

For modern c/c++ developemt

```zsh
Debian Linux - sudo aptitude install clang clang-tidy clang-format clangd cppcheck
Arch Linux   - sudo pacman -S clang lldb cppcheck
#Note: When using another build system like build2 you will need to dry run
#your build system and pipe the output to compiledb to generate compile_commands.json
# eg. $ b -vn clean update |& compiledb
#For cmake generate a compile_commands.json file using cmake with 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
#in your project directory
```

for help using the various plugins and extensions

```zsh
:help local-addtions
```

to view the help pages and instruction manual on the various extensions

>>Big ShoutOuts to the Creators of Neovim.
>Another to all the creators of the various neovim extensions.
>And Last but not the least __God Bless The Vim && Neovim Community for this
>hyperextensible and hackable text editor__
