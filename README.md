# Awesome Neovim Configuration

This is to make setting up of vim 8 && neovim 0.4 and above easy and a breeze.
Moving on I will use vim and neovim interchangably because they are very similar
under the hood.

## Requirement

Installation of plugins in neovim or vim requires python support
(python 2 or python 3).You can check if your neovim has python support by running
`:echo has("python3")` and `:echo has("python2")`.

__Neovim__
Neovim does not come with python support by default, and additional setup is required.

First install [pynvim](https://github.com/neovim/pynvim)

```bash
python3 -m pip install pynvim
```

And add the following configuration in your `.vimrc`

```bash
let g:python3_host_prog=/path/to/python/executable/
```

__Vim Plug is A minimalist Vim plugin manager__ as quoted by their site
[Vim-Plug](https://github.com/junegunn/vim-plug)

### Installation of Vim-Plug

[Download plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
and put it in the "autoload" directory.

### Vim

#### Unix

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

You can automate the process by putting the command in your Vim configuration
file as suggested [here][auto].

[auto]: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

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

### Neovim

#### Unix

```sh
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

### Install Plugins Using Vim-Plug

move to ~/.config/nvim/ and open the plugins.vim file
and run this commands

```bash
:source %     # To cause init.vim to update itself

:PlugInstall  #To install plugins

:PlugUpdate   #To update Vim-Plug

:PlugClean    # Comment the plugin you want to remove with '"' then :source %
              # and run PlugClean
```

And Assumming you plan to get involved in web developemt then you should
insllall the following plugins

```bash
:CocInstall coc-vetur coc-highlight
:CocInstall coc-json coc-tsserver coc-html coc-css coc-markdownlint
```

there are a lot of other extentions you can install for the coc.nvim language
server client [Coc.nvim](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

for python

```bash
:CocInstall coc-python
pip3 install flake8 yapf # For linting and formatting
```

for c/c++

```bash
sudo aptitude install clangd clang-format clang-tidy clang # don't forget to
#generate a compile_commands.json file using cmake with 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
#in your project directory
```

for help using the various plugins and extensions

```bash
:help local-addtions
```

to view the help pages and instruction manual on the various extensions

>>Big ShoutOuts to the Creators of Vim && Neovim.
>Another to all the creators of the various vim and neovim extensions.
>And Last but not the least __God Bless The Vim && Neovim Community for this
>hyperextensible and hackable text editor__
