let mapleader = ","

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
" coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ ]

" =================================================================
" Coc
" =================================================================
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
  

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <space>ac  <Plug>(coc-codeaction) 
" Apply AutoFix to problem on the current line.
nmap <space>qf  <Plug>(coc-fix-current)
nnoremap <space>c :CocCommand<CR>
nnoremap <space>l :CocList<CR>
nnoremap <space>i :CocInfo<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Confirm completion
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GOTO definition
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>gd :call CocActionAsync('jumpDefinition', 'vsplit')<CR>


" Show documentation
nmap <silent> K :call <SID>show_documentation()<CR>

" Rename
nmap <leader>rn <Plug>(coc-rename)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"
"set statusline=""
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Floating window scrolling
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" =================================================================
" CoC END
" =================================================================
