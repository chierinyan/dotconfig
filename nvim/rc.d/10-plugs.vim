call plug#begin()
    Plug 'andymass/vim-matchup'
    Plug 'gcmt/wildfire.vim'
    " Plug 'github/copilot.vim'
    Plug 'godlygeek/tabular'
    Plug 'goerz/jupytext.vim'
    Plug 'honza/vim-snippets'
    Plug 'mg979/vim-visual-multi'
    Plug 'mhinz/vim-signify'
    Plug 'stevearc/vim-arduino'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/vis'
    Plug 'Winseven4lyf/vim-bbcode'
    Plug 'fidian/hexmode'
    Plug 'lervag/vimtex', { 'for': ['tex'] }
    Plug 'iamcco/markdown-preview.nvim', { 'for': ['markdown'] }
        "\ { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim'] }
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()


let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-clangd',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-sql',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-vimtex',
    \ 'coc-docker',
    \ 'coc-snippets'
\]


let g:VM_maps = {
    \ 'Undo': 'u',
    \ 'Redo': 'U',
    \ 'Select Cursor Down': '<C-j>',
    \ 'Select Cursor Up': '<C-k>'
\}

let g:vimtex_compiler_latexmk = {
    \ 'options': ['--shell-escape', '--auxdir=/tmp/tex'],
\}

let g:mkdp_page_title = '${name}'

imap <silent><script><expr> <C-f> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev = '<C-b>'
imap <C-n> <Plug>(coc-snippets-expand-jump)

inoremap <expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"

inoremap <expr> <S-Tab>
    \ coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

inoremap <expr> <CR> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


nnoremap ?? :SignifyHunkDiff<CR>
cnoreabbrev rev SignifyHunkUndo

vnoremap t :Tabularize /\zs<Left><Left><Left>

autocmd FileType c,cpp,arduino setlocal commentstring=//\ %s
