return {
  'agokule/check-deps.nvim',
  opts = {
    list = {
      {
        name = "rg",
        cmd = "rg",
        install = {
          linux = { "sudo apt install ripgrep", "sudo pacman -S ripgrep" },
          darwin = { "brew install ripgrep" },
          windows = { "winget install BurntSushi.ripgrep.GNU", "winget install BurntSushi.ripgrep.MSVC"  },
        },
      },
      {
        name = 'Python',
        cmd = 'python',
        install = {
          windows = { 'winget install Python.Python.3.13' }
        }
      },
      {
        name = 'MinGW',
        cmd = 'gcc',
        install = {
          windows = { 'winget install BrechtSanders.WinLibs.POSIX.UCRT' }
        }
      },
      {
        name = 'Clangd',
        cmd = 'clangd',
        install = {
          windows = { 'winget install LLVM.LLVM' }
        }
      },
    },
    auto_check = true
  }
}
