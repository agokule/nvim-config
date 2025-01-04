let s:fontsize = 11
if exists("g:neovide")
  set guifont=CaskaydiaMono\ Nerd\ Font:h11
else
  set guifont=CaskaydiaMono\ NF\ Semibold:h11
endif
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  if exists("g:neovide")
    :execute "set guifont=CaskaydiaMono\\ Nerd\\ Font:h" . s:fontsize
  else
    :execute "GuiFont! Cascadia\\ Mono:h" . s:fontsize
  endif
endfunction

fu! AdjustOpacity(amount)
  if exists("g:neovide")
    :execute "lua vim.g.neovide_transparency = 0." . a:amount
  else
    :execute "GuiWindowOpacity 0." . a:amount
  end
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
