# This is my Neovim config

Credits to [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) for the starting point of my config

![image](https://github.com/user-attachments/assets/4a61fbb3-3f54-4205-afb2-cd6bf6e9b236)

## Features

- Uses github copliot for amazing AI integration
- LSP and autocomplete
- Git integration with gitsigns, and lazygit
- Mini.statusline for status bar
- Wakatime to track coding time
- Slightly customized tokyonight for the perfect coding theme
- [snacks.nvim](https://github.com/folke/snacks.nvim) for tons of quality of life improvements
- mini.files for file explorer
- [debugmaster](https://github.com/MironPascalCaseFan/debugmaster.nvim) for debugging support
- [competitest](https://github.com/xeluxee/competitest.nvim) to make competitive programming easier
- [code_runner.nvim](https://github.com/CRAG666/code_runner.nvim) for running code in neovim set up for Python, C++, C, and Windows batch files
- [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua) to highlight colors in neovim
- Many more! Check `lua/custom/plugins/*.lua` to see all the plugins (there are like 40+ plugins)
- Supports Linux and Windows
- Neovim on Windows can be a lot slower than on Linux, so I have optimized this to startup in ~500ms even on Windows! (as long as you don't immediately open a file)

## How to use as your config

### Windows

Run the following commands in powershell:

```powershell
cd $env:LOCALAPPDATA
git clone https://github.com/agokule/nvim-config.git nvim
```

### Unix

Run these commands in your terminal:
```bash
cd ~/.config
git clone https://github.com/agokule/nvim-config.git nvim
```

### Other notes

> This serves as a personal config, so I won't be trying to adapt it to work on
> other people's computers. If you want to have this exact config, it is your
> responsibility to make it work on your machine, not mine. Secondly, I won't
> update this README very often. As such, it is subject to becom out of date
> sometimes.

- You will need to install neovim (obviously)
- You need to install python (if you don't have it already)
- In python you need to install OpenCV and Pillow
- You need codeium and github copliot (unless you don't want AI)

After that, you can launch neovim with `nvim` and lazy will start installing the plugins.

## Basic customization

If you want to disable ai plugins, head to line 11 in init.lua (looks like this: `vim.g.enable_ai = true`) and change true to false.
See `./lua/local-settings.lua` for more options

## What are these random files for?

- `.nvim.lua` - makes it so that when I'm editing my config, it doesn't automatically chdir into different folders
- `ginit.vim` - loaded by neovim-qt and neovide
- `more_configs.vim` - Old configs which I used back when I used vim, I have been to lazy to make it lua and it serves as the config to load when using neovim embedded/emulated in a different IDE/editor
- `superheroyrr.mp4` and `superheroyrr.py` - The python will load the video and show the red/black animation on my dashboard

