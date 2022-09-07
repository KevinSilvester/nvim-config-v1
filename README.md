# My Neovim Configuration

> Based off [nvim-basic-ide template](https://github.com/LunarVim/nvim-basic-ide)

### Install Neovim 0.7

- **Build from source**
   ```sh
   git clone https://github.com/neovim/neovim.git
   cd neovim
   git checkout release-0.7
   make CMAKE_BUILD_TYPE=Release
   sudo make install
   ```

- **Install with package manager**
   > Install using a package manager of your choice.
   > If you're using a Ubuntu/Debian based disto, I would recommend installing with a package
   > manager such as `Homebrew` or `nix` instead of `apt` to get up to date versions of packages
   ```sh
   # MacOS/Linux
   brew install neovim

   # Windows
   scoop install neovim
   ```

### Install the config

Make sure to remove or move your current `nvim` directory

```sh
# MacOS/Linux
git clone https://github.com/KevinSilvester/nvim-config.git ~/.config/nvim

# Windows
git clone https://github.com/KevinSilvester/nvim-config.git $env:LOCALAPPDATA\nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

**NOTE** Checkout these files for some predefined keymaps:

- [base keymaps](https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/keymaps.lua)
- [whichkey keymaps](https://github.com/KevinSilvester/nvim-config/blob/master/lua/user/whichkey.lua#L83)
- [lsp keymaps](https://github.com/KevinSilvester/nvim-config/blob/master/lua/user/lsp/handlers.lua#L54)

### Config Dependencies

- **Install python and node support**

   ```sh
   # Neovim python support
   pip3 install pynvim

   # Neovim node support
   npm i --location=global neovim
   ```

- **Ripgrep**
   > For [**Telescope**](https://github.com/nvim-telescope/telescope.nvim) and [**nvim-spectre**](https://github.com/KevinSilvester/nvim-spectre)(interactive find and replace)

   ```sh
   # MacOS/Linux
   brew install ripgrep

   # Windows
   scoop install ripgrep 
   ```

**Copy/Paste**
- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```
- On wsl2 add the path to neovim bin folder to wsl distro path environment variable as win32yank is bundled with neovim for windows. (see [LunarVim Docs](https://www.lunarvim.org/01-installing.html#tips-for-wsl-2-users))
```sh
# if neovim for windows was installed using scoop

# fish shell
fish_add_path -g "/mnt/c/Users/USERNAME/scoop/apps/neovim/current/bin"

# zsh/bash
export PATH=/mnt/c/Users/USERNAME/scoop/apps/neovim/current/bin:$PATH

# nushell
let-env PATH = ($env.PATH | append '/mnt/c/Users/USERNAME/scoop/apps/neovim/current/bin')
```

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

## Configuration

### LSP

To add a new LSP first enter `:Mason`

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/KevinSilvester/nvim-config/blob/master/lua/user/lsp/mason.lua#L16)

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/KevinSilvester/nvim-config/blob/master/lua/user/lsp/null-ls.lua#L12)

