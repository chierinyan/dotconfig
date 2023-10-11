syntax on

set hidden
set updatetime=100

set number
set relativenumber
set signcolumn=number

set autoindent smartindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set nowrap
set scrolloff=8
set sidescrolloff=0
set colorcolumn=96

set notermguicolors
set incsearch nohlsearch ignorecase smartcase

set splitbelow splitright

set mouse=
set guicursor=
set clipboard+=unnamedplus

set shellcmdflag=-ic

cnoreabbrev W  w
cnoreabbrev Q  q
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev QA qa
cnoreabbrev Qa qa

vnoremap J j
noremap K k

noremap E g_l
noremap B ^
nnoremap U <C-r>
noremap <Space> %

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-b> <Home>
inoremap <C-e> <End>
inoremap <C-o> <C-o>o

noremap <C-c>      <Esc>
noremap <C-b>      <C-w>
noremap <C-b><C-b> <C-w>s:e .<Return>

nnoremap <C-l> 8zl
nnoremap <BS>  8zh

nnoremap <C-R> R
nnoremap R     :call Run()<Return>

function ReplaceName()
    %s/<filename>/\=expand('%:t:r')
endfunction
autocmd BufNewFile Makefile 0r ~/.config/nvim/skel/Makefile
autocmd BufNewFile *.tex    0r ~/.config/nvim/skel/latex.tex
autocmd BufNewFile *.html   0r ~/.config/nvim/skel/html.html
autocmd BufNewFile *.vhd    0r ~/.config/nvim/skel/vhd.vhd | call ReplaceName() | 1

source ~/.config/nvim/vim-plug/plug.vim
for s:vimscript in split(globpath('~/.config/nvim/rc.d/', '*.vim'), '\n')
    exe 'source' s:vimscript
endfor

" terminal
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert

function Split() abort
    :split
    :wincmd j
    :set nonu
    :resize +8
endfunction

nnoremap <C-t> :call Split()<Return>:term

function Run() abort
    :w
    if &filetype == 'c'
        exec '!gcc % -o %<'
        :call Split()
        :term ./%<
    elseif &filetype == 'cpp'
        exec '!g++ -std=c++11 % -Wall -o %<'
        :call Split()
        :term ./%<
    elseif &filetype == 'python'
        :call Split()
        :term python3 %
    elseif &filetype == 'java'
        exec '!javac %'
        :call Split()
        :term java %
    elseif &filetype == 'javascript'
        :call Split()
        :term node %
    elseif &filetype == 'go'
        :call Split()
        :term go run %
    elseif &filetype == 'sh'
        :call Split()
        :term bash %
    elseif &filetype == 'zsh'
        :call Split()
        :term zsh %
    elseif &filetype == 'markdown'
        :MarkdownPreview
        " exec '!pandoc -o %<.pdf %'
        " exec '!open %<.pdf'
    elseif &filetype == 'tex'
        :silent! VimtexCompileSS
    elseif &filetype == 'arduino'
        :ArduinoUpload
    endif
endfunction
