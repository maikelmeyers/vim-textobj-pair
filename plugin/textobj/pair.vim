" textobj-pair: a text object for blocks between matchit pairs
" Author: maikelmeyers
" Version: 0.1.0

if exists('g:loaded_textobj-pair')
    finish
endif


call textobj#user#plugin('pair', {
    \ '-': {
    \     'sfile': expand('<sfile>:p'),
    \     'select-a': 'am',
    \     'select-a-function': 's:select_a',
    \     'select-i': 'im',
    \     'select-i-function': 's:select_i',
    \ }})


function! s:select(object_type)
    let skip = 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|comment"'
    call searchpair(b:match_pairs_open,'',b:match_pairs_close,'bW',skip)
    let start_position = getpos('.')
    call searchpair(b:match_pairs_open,'',b:match_pairs_close,'W',skip)
    let end_position = getpos('.')
    echo end_position

    if a:object_type ==? 'i'
        let start_position[1] += 1
        let end_position[1] -= 1
    endif

    return ['V', start_position, end_position]
endfunction


function! s:select_a()
    return s:select('a')
endfunction


function! s:select_i()
    return s:select('i')
endfunction


let g:loaded_textobj_pair = 1
