" textobj-pair: a text object for blocks between matchit pairs
" Author: maikelmeyers
" Version: 0.1.0

if exists('g:loaded_textobj-pair')
    finish
endif


call textobj#user#plugin('pair', {
    \ '-': {
    \     '*sfile*': expand('<sfile>:p'),
    \     'select-a': 'am',  '*select-a-function*': 's:select_a',
    \     'select-i': 'im',  '*select-i-function*': 's:select_i',
    \ }})


function! s:select(object_type)
    normal! Ä
    let start_position = getpos('.')
    normal! %
    let end_position = getpos('.')

    if a:object_type ==? 'i'
        let start_position[2] += 1
        let end_position[2] -= 1
    endif

    return ['v', start_position, end_position]
endfunction


function! s:select_a()
    return s:select('a')
endfunction


function! s:select_i()
    return s:select('i')
endfunction


let g:loaded_textobj_pair = 1
