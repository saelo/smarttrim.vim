" Determine whether the current file has trailing whitespace
function! s:OpenHook()
  let b:remove_trailing_whitespace = !search('\s\+$', 'cwn')

  " Highlight trailing whitespace if we won't remove it
  if !b:remove_trailing_whitespace
    setlocal list
  endif
endfunction

" Trim trailing whitespace if remove_trailing_whitespace is set
function! s:SaveHook()
  if exists("b:remove_trailing_whitespace") && b:remove_trailing_whitespace
    call RemoveTrailingWhitespace()
  endif
endfunction

" Remove trailing whitespaces. Globally accessible
function! RemoveTrailingWhitespace()
  %s/\s\+$//e
  nohlsearch
endfunction

" Install hooks
autocmd BufCreate,BufNewFile,BufReadPost,BufWritePost * call s:OpenHook()
autocmd BufWritePre * call s:SaveHook()
