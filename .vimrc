set nocompatible
set noshowmode
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'othree/html5.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'slim-template/vim-slim'
Plugin 'elixir-editors/vim-elixir'
"Plugin 'slashmili/alchemist.vim'
Plugin 'tommcdo/vim-lion'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'wellle/targets.vim'
Plugin 'fatih/vim-go'
Plugin 'neoclide/vim-jsx-improve'
" Plugin 'prettier/vim-prettier'
" Plugin 'dense-analysis/ale'
" Plugin 'ervandew/supertab'
Plugin 'leafgarland/typescript-vim'
Plugin 'joker1007/vim-ruby-heredoc-syntax'

Plugin 'peitalin/vim-jsx-typescript'

Plugin 'styled-components/vim-styled-components'

Plugin 'jparise/vim-graphql'

Plugin 'neoclide/coc.nvim', {'branch': 'release'}

Plugin 'rust-lang/rust.vim'

" syntax highlighting for sql within SQL`` template strings
Plugin 'statico/vim-javascript-sql'
Plugin 'vim-test/vim-test'

" Markdown/Mermaid
Plugin 'iamcco/markdown-preview.nvim' " :call mkdp#util#install()
" Syntax Highlighting
"Plugin 'mracos/mermaid.vim'
Plugin 'chazmcgarvey/vim-mermaid'

"Plugin 'flowtype/vim-flow'
"Plugin 'lambdatoast/elm.vim'
"Plugin 'mattn/emmet-vim'
"Plugin 'mustache/vim-mustache-handlebars'
"Plugin 'yaymukund/vim-rabl'
" replaced with deoplete
" included and altered by vim-jsx-improve
"Plugin 'pangloss/vim-javascript'
" deoplete
"Plugin 'roxma/vim-hug-neovim-rpc'
"Plugin 'roxma/nvim-yarp'
"Plugin 'Shougo/deoplete.nvim'
"Plugin 'wokalski/autocomplete-flow'
" You will also need the following for function argument completion:
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
" end deoplete

call vundle#end()
filetype plugin indent on

" source .vimrc automatically on save like magic
au BufWritePost .vimrc so $MYVIMRC

" open vimrc in split with leaderev
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Git grep for the word under the cursor
:nnoremap <leader>G :Ggrep <C-r><C-w><cr>
:nnoremap <leader>GB :GBrowse <cr>

" vim-rails mappings
:nnoremap <leader>EC :Econtroller <cr>
:nnoremap <leader>EV :Eview <cr>
:nnoremap <leader>EM :Emodel <cr>

" leader c/v copies/pastes from clipboard
:nnoremap <leader>v "*p
" also in insert mode
:inoremap <leader>v <Esc>"*pa
:nnoremap <leader>c "*yy
:vnoremap <leader>c "*y

" Ctrl P opens fzf for files checked into git
" (:Files opens all)
:nmap <silent> <C-p> :GFiles<CR>
:nmap <silent> <C-b> :Buffers<CR>

" vim-test
let test#strategy = "vimterminal"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" go run
:nnoremap <leader>gr :GoRun<cr>

if $ITERM_PROFILE == 'Light'
  set background=light
else
  set background=dark
endif

" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red

colorscheme solarized

autocmd ColorScheme * highlight clear SignColumn

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" sensible defaults not included in vim-sensible
set number
set hlsearch

" space for normal mode
nnoremap <space> :

" Ctrl-h for file browser
nnoremap <C-h> :25Vexplore!<CR>

" keep change history when changing buffers
set hidden

" quasimodo: off
set noeb vb t_vb=

" tab is two spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" disabled to see if it impacts performance
" whitespace bad
" highlight ExtraWhitespace ctermbg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" A wrapper function to restore the cursor position, window position,
" and last search after running a command.
function! Preserve(command)
  " Save the last search
  let last_search=@/
  " Save the current cursor position
  let save_cursor = getpos(".")
  " Save the window position
  normal H
  let save_window = getpos(".")
  call setpos('.', save_cursor)

  " Do the business:
  execute a:command

  " Restore the last_search
  let @/=last_search
  " Restore the window position
  call setpos('.', save_window)
  normal zt
  " Restore the cursor position
  call setpos('.', save_cursor)
endfunction

" remove whitespace at the end of lines automatically on save
autocmd BufWritePre *.rb,*.txt,*.js,*.flow,*.css,*.scss,*.hbs,*.html,*.coffee,*.haml,*.yml,*.ts,*.sql :call Preserve("%s/\\s\\+$//e")
nmap <silent> <Leader><Esc> :call Preserve("normal gg=G")<CR>

autocmd BufWritePre *.rs :RustFmt 

" brew install pgformatter. then gggqG to prettify entire .sql file
au FileType sql setl formatprg=/usr/local/bin/pg_format\ -

augroup ft_rb
  au!
  " fix the SLOOOW syntax highlighting
  au FileType ruby setlocal re=1 foldmethod=manual
augroup END

" set .mm files to cpp type
au BufNewFile,BufRead *.mm set filetype=cpp
au BufNewFile,BufRead Fastfile set filetype=ruby
au BufNewFile,BufRead *.tsx set filetype=typescriptreact

" for js/coffee/jade files, 4 spaces
autocmd Filetype cpp setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab

" Commenting blocks of code with double-tap f / uncomment with fh
"autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
"autocmd FileType sh,ruby,python   let b:comment_leader = '# '
"autocmd FileType vim              let b:comment_leader = '" '
"noremap <silent> ff :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> fh :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
"

" Markdown/Mermaid
" Set filetype to mermaid if file starts with ```mermaid
au BufRead * if getline(1) =~ '```mermaid' | setlocal ft=mermaid | endif
nmap <leader>md <Plug>MarkdownPreviewToggle

" Github
nmap <leader>gB :GBrowse
nmap <leader>gb :G blame


" coc.vim
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
let g:coc_node_path = '/opt/homebrew/bin/node'

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]


command! -nargs=0 Prettier :CocCommand prettier.formatFile

"if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
"endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

set nobackup
set nowritebackup

" Give more space for displaying messages.
" Oli: Suggested but I don't like it
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=number

"" Use Ctrl+j/k to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" end coc.vim

set tags^=.git/tags
