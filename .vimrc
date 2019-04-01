set nocompatible
set noshowmode
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'elixir-lang/vim-elixir'
Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
" Plugin 'kien/rainbow_parentheses.vim'
Plugin 'othree/html5.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tommcdo/vim-lion'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'wellle/targets.vim'
Plugin 'fatih/vim-go'
Plugin 'neoclide/vim-jsx-improve'
Plugin 'prettier/vim-prettier'
Plugin 'w0rp/ale'
Plugin 'ervandew/supertab'
Plugin 'leafgarland/typescript-vim'
" deoplete
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'Shougo/deoplete.nvim'
Plugin 'wokalski/autocomplete-flow'
" You will also need the following for function argument completion:
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
" end deoplete
Plugin 'joker1007/vim-ruby-heredoc-syntax'
" syntax highlighting for sql within SQL`` template strings

"Plugin 'flowtype/vim-flow'
"Plugin 'lambdatoast/elm.vim'
"Plugin 'mattn/emmet-vim'
"Plugin 'mustache/vim-mustache-handlebars'
"Plugin 'yaymukund/vim-rabl'
" replaced with deoplete
" included and altered by vim-jsx-improve
"Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on

" source .vimrc automatically on save like magic
au BufWritePost .vimrc so $MYVIMRC
" open vimrc in split with leaderev
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Git grep for the word under the cursor
:nnoremap <leader>G :Ggrep <C-r><C-w><cr>

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

" search dash for word under cursor
:nmap <silent> <leader>d <Plug>DashSearch
:nmap <silent> <leader>D <Plug>DashGlobalSearch

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
autocmd BufWritePre *.rb,*.txt,*.js,*.css,*.scss,*.hbs,*.html,*.coffee,*.haml,*.yml,*.ts,*.sql :call Preserve("%s/\\s\\+$//e")
nmap <silent> <Leader><Esc> :call Preserve("normal gg=G")<CR>

" CtrlP ignore matchers for autocomplete 
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git))|bower_components|tmp|node_modules|build|vendor$',
      \ }

" rainbow parentheses for solarized
let g:rbpt_colorpairs = [
      \ [ '13', '#6c71c4'],
      \ [ '5',  '#d33682'],
      \ [ '1',  '#dc322f'],
      \ [ '9',  '#cb4b16'],
      \ [ '3',  '#b58900'],
      \ [ '2',  '#859900'],
      \ [ '6',  '#2aa198'],
      \ [ '4',  '#268bd2'],
      \ ]

" Enable rainbow parentheses for all buffers
" augroup rainbow_parentheses
"   au!
"   au VimEnter * RainbowParenthesesActivate
"   au BufEnter * RainbowParenthesesLoadRound
"   au BufEnter * RainbowParenthesesLoadSquare
"   au BufEnter * RainbowParenthesesLoadBraces
" augroup END

augroup ft_rb
    au!
    " fix the SLOOOW syntax highlighting
    au FileType ruby setlocal re=1 foldmethod=manual
augroup END

" vim-prettier setup
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md Prettier

" max line length that prettier will wrap on
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" use tabs over spaces
let g:prettier#config#use_tabs = 'false'

" print semicolons
let g:prettier#config#semi = 'true'

" single quotes over double quotes
let g:prettier#config#single_quote = 'false'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'false'

" none|es5|all
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
let g:prettier#config#parser = 'babylon'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1

let g:ale_linters = { 
\'javascript': ['flow', 'eslint'],
\}
let g:ale_fixers = {
\'javascript': ['eslint'],
\}

" deoplete
" call deoplete#enable()
let g:python3_host_prog = '/usr/local/Cellar/python3/3.6.4/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1

" flow (vim-javascript)
"let g:javascript_plugin_flow = 1

" set .mm files to cpp type
au BufNewFile,BufRead *.mm set filetype=cpp

" for js/coffee/jade files, 4 spaces
autocmd Filetype cpp setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab

