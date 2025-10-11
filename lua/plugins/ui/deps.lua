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
          windows = { 'winget install Python.Python.3.13' },
          linux = { "sudo pacman -S python" },
        }
      },
      {
        name = 'MinGW',
        cmd = 'gcc',
        install = {
          windows = { 'winget install BrechtSanders.WinLibs.POSIX.UCRT' },
          linux = { 'sudo pacman -S gcc base-devel' },
        }
      },
      {
        name = 'Clangd',
        cmd = 'clangd',
        install = {
          windows = { 'winget install LLVM.LLVM' },
          linux = { 'sudo pacman -S clang' },
        }
      },
      {
        name = "Lazygit",
        cmd = 'lazygit',
        install = {
          windows = { 'winget install JesseDuffield.lazygit'},
          linux = { 'sudo pacman -S lazygit', 'sudo apt install lazygit' }
        }
      }
    },
    auto_check = true
  }
}
