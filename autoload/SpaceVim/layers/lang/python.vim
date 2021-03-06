""
" @section lang#python, layer-lang-python
" @parentsection layers
" To make this layer work well, you should install jedi.
" @subsection mappings
" >
"   mode            key             function
" <

function! SpaceVim#layers#lang#python#plugins() abort
  let plugins = []
  " python
  if has('nvim')
    call add(plugins, ['zchee/deoplete-jedi', { 'on_ft' : 'python'}])
  else
    call add(plugins, ['davidhalter/jedi-vim', { 'on_ft' : 'python',
          \ 'if' : has('python') || has('python3')}])
  endif
  call add(plugins, ['Vimjas/vim-python-pep8-indent', 
        \ { 'on_ft' : 'python'}])
  call add(plugins, ['tell-k/vim-autoflake', {'merged' : 0}])
  return plugins
endfunction

function! SpaceVim#layers#lang#python#config() abort
  call SpaceVim#plugins#runner#reg_runner('python', 'python %s')
  call SpaceVim#mapping#space#regesit_lang_mappings('python', funcref('s:language_specified_mappings'))
  call SpaceVim#layers#edit#add_ft_head_tamplate('python',
        \ ['#!/usr/bin/env python',
        \ '# -*- coding: utf-8 -*-',
        \ '']
        \ )
  let g:no_autoflake_maps = 1
  if executable('ipython')
    call SpaceVim#plugins#repl#reg('python', 'ipython')
  elseif executable('python')
    call SpaceVim#plugins#repl#reg('python', 'python')
  endif
endfunction

function! s:language_specified_mappings() abort
  call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
        \ 'call SpaceVim#plugins#runner#open()',
        \ 'execute current file', 1)
  let g:_spacevim_mappings_space.l.i = {'name' : '+Imports'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','i', 's'],
        \ 'Neoformat isort',
        \ 'sort imports', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','i', 'r'],
        \ 'Autoflake',
        \ 'remove unused imports', 1)
  let g:_spacevim_mappings_space.l.s = {'name' : '+Send'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'i'],
        \ 'call SpaceVim#plugins#repl#start("python")',
        \ 'start REPL process', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'l'],
        \ 'call SpaceVim#plugins#repl#send("line")',
        \ 'send line and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'b'],
        \ 'call SpaceVim#plugins#repl#send("buffer")',
        \ 'send buffer and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 's'],
        \ 'call SpaceVim#plugins#repl#send("selection")',
        \ 'send selection and keep code buffer focused', 1)
endfunction
