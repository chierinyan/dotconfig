nnoremap ,p a<++><Esc>
inoremap ,p <++>
nnoremap ,n /<++><Return>c4l
inoremap ,n <Esc>/<++><Return>c4l
nnoremap ,r /<++><Return>v3lr R
inoremap ,r <Esc>/<++><Return>v3lr R

autocmd Filetype markdown,tex set textwidth=96
autocmd Filetype markdown,tex inoremap <buffer> ,m $$<Return>$$<Return><++><Esc>kO
autocmd Filetype markdown inoremap <buffer> ,b ****<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,d ~~~~<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,h ====<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,c ```<Return>```<Return><++><Esc>2kA

autocmd Filetype markdown nnoremap <buffer> <Leader>0 :s/#\+ \?//e<Return>$
autocmd Filetype markdown inoremap <buffer> <Leader>0 <Esc>:s/#\+ \?//e<Return>A
autocmd Filetype markdown nnoremap <buffer> <Leader>1 :s/#\+ \?//e<Return>I#<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>1 <Esc>:s/#\+ \?//e<Return>I#<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>2 :s/#\+ \?//e<Return>I##<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>2 <Esc>:s/#\+ \?//e<Return>I##<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>3 :s/#\+ \?//e<Return>I###<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>3 <Esc>:s/#\+ \?//e<Return>I###<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>4 :s/#\+ \?//e<Return>I####<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>4 <Esc>:s/#\+ \?//e<Return>I####<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>5 :s/#\+ \?//e<Return>I#####<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>5 <Esc>:s/#\+ \?//e<Return>I#####<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>6 :s/#\+ \?//e<Return>I######<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>6 <Esc>:s/#\+ \?//e<Return>I######<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader><Return> o<div style="page-break-after: always; break-after: page;"></div><Return><Esc>

autocmd Filetype yaml set colorcolumn=
autocmd Filetype yaml highlight SpecChars ctermbg=220
autocmd Filetype yaml match SpecChars /[_〇+,、／？！｜：＂＇＊＜＞＾～＆（）]\|アンソロジー\|よろず\|コミック\|comic\| \[.*日\]\c/
