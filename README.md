# Awesome Neovim Configuration

This is to make setting up of vim 8 && neovim 0.4 and above easy and a breeze.
Moving on I will use vim and neovim interchangably because they are very similar
under the hood.

## Awesome NeoVim with C++

Supports the following

- clang , gcc compilers
- clang-tidy linter
- clang-format formater
- clangd lsp server with coc.nvim lsp client
- cppcheck and clang-check static anlysis
- All build systems build2 , cmake , meason ++
- autocompletion,documentation and all other features supported by clangd and
    coc.nvim
![Awesome-NeoVim with C++](https://github.com/Ultra-Code/awesome-neovim/blob/master/assets/AwesomeNeovimForC%2B%2B.png)

## Awesome Neovim for Ts with Vue

Supports the following and more ....

- Node v12+
- eslint linter
- pretteir formatter
- Tsserver with coc.nvim
- autocompletion,documentation and all other features supported by tsserver and
    coc.nvim

![Awesome NeoVim with Ts and Vue](https://github.com/Ultra-Code/nvim/blob/master/assets/AwesomeAndConfigurableNeoVim.png)

>__NOTE__ the languages supported out of the box are
>c++,c,cmake,python3,js,html5+,css3+,ts,vue,haskell,markdown,json
>__But__ support for other languages can easily be add by using it required
[lsp's](https://github.com/neoclide/coc.nvim/wiki/Language-servers)
>and [coc-extentions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

## Requirement

Installation of plugins in neovim or vim requires `python 3` support
.You can check if your neovim has python support by running
`:echo has("python3")`

__Neovim__
Neovim does not come out of the box with python 3 support

>Additional Setup is required for python 3

First install [pynvim](https://github.com/neovim/pynvim)

```bash
python3 -m pip install pynvim
```

And add the following configuration in your `$XDG_CONFIG_HOME/nvim/editor.vim` or
`$HOME/.config/nvim/editor.vim`

```bash
let g:python3_host_prog=/path/to/python3/executable/on/your/system
```

__Vim Plug is A minimalist Vim plugin manager__ as quoted by their site
[Vim-Plug](https://github.com/junegunn/vim-plug)

### Installation of Vim-Plug

#### _NOTE_

_Now the is automatic Vim-Plug installation for all neovim and vim users
You can automate the process by putting the following commands in your Vim configuration
file as suggested [here][auto]. and open nvim and watch some beautiful magic happen.
___This is a one time activity so after vim-plug has been istalled you can
remove these commands from your config.
The $MYVIMRC is an environment variable that should point to your init.vim file
for neovim users and .vimrc file for vim users___ ._

__Note for neovim users__
_On linux the path for the plugin is `$XDG_DATA_HOME/nvim/site/autoload/plug.vim`
if the evironment variable `$XDG_DATA_HOME` is defined __else__ use the default
`'~/.local/share/nvim/site/autoload/plug.vim` for this to work_

__Thanks to @junegunn/vim-plug and all colaborators.__

[auto]: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

### Neovim

#### Unix

```zsh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

##### Windows (PowerShell)

```powershell
md ~\AppData\Local\nvim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)
```

### Vim

#### Unix

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

##### Windows (PowerShell)

```powershell
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)
```

### Install Plugins Using Vim-Plug

move to `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim/` and open the plugins.vim file
and run this commands

```bash
:source %     # To cause init.vim to update itself

:PlugInstall  #To install plugins

:PlugUpdate   #To update plugins

:PlugUpgrade  #To upgrade to the latest version of Vim-Plug

:PlugClean    # Comment the plugin you want to remove with '"' then :source %
              # and run PlugClean to remove that commented plugin
```

For modern c/c++ developemt

```bash
sudo aptitude install gcc ccls cppcheck
#Note: When using another build system like build2 you will need to dry run
#your build system and pipe the output to compiledb to generate compile_commands.json
# eg. $ b -vn clean update |& compiledb
sudo aptitude install clangd clang-format clang-tidy clang # don't forget to
#generate a compile_commands.json file using cmake with 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
#in your project directory OR
```

And Assumming you plan to get involved in web developemt then you should
insllall the following plugins

```bash
:CocInstall coc-vetur coc-highlight
:CocInstall coc-json coc-tsserver coc-html coc-css coc-markdownlint
```

there are a lot of other extentions you can install for the coc.nvim language
server client [Coc.nvim](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

`Note to change the plugins that are automatically installed by coc.nvim edit
the plugrc.d/coc.vim's global_extension variable with your desired plugins`

```vim
let g:coc_global_extensions=[]
```

for python

```bash
:CocInstall coc-python
pip3 install flake8 yapf # For linting and formatting
```

for help using the various plugins and extensions

```bash
:help local-addtions
```

to view the help pages and instruction manual on the various extensions

In addtion to these plugins ,some plugins like Vista have external dependencies
which have to be installed in other to use them.

```bash
sudo aptitude install universal-ctags # enable vista to generate source code tags
```

>>Big ShoutOuts to the Creators of Vim && Neovim.
>Another to all the creators of the various vim and neovim extensions.
>And Last but not the least __God Bless The Vim && Neovim Community for this
>hyperextensible and hackable text editor__
