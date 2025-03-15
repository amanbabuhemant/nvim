set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.local/share/nvim/site/pack/vundle/start/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" this plugin provides better codefolding
Plugin 'tmhedberg/SimpylFold'

" auto indentetion plugin fo Python
Plugin 'vim-scripts/indentpython.vim'

" auto complete Plugin 
" Plugin 'Valloric/YouCompleteMe'

" python auto complete Plugin
" Plugin 'davidhalter/jedi-vim'

" syntex highlighting
Plugin 'vim-syntastic/syntastic'

" PEP 8 syntex highlighting
Plugin 'nvie/vim-flake8'

" coler schemmee plugins
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" file tree plugin
Plugin 'scrooloose/nerdtree'

" ctrlP plugin for searching through VIM
Plugin 'kien/ctrlp.vim'

" git itigration plugin
Plugin 'tpope/vim-fugitive'

" git powerline plugin
Plugin 'Lokaltog/powerline'
", {'rtp': 'powerline/bindings/vim/'}

" colorschemes
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'tribela/vim-transparent'
" Plugin 'vim/colorschemes'

" HTML aemmiting
Plugin 'mattn/emmet-vim'

" CSS Color Preview
Plugin 'ap/vim-css-color'

" Indent line hint
Plugin 'Yggdroot/indentLine'

" coc.nvim for autocompletion and IntelliSense
" Plugin 'neoclide/coc.nvim'

" Code Minimap
Plugin 'wfxr/minimap.vim'

" fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Class ountline viewer
Plugin 'preservim/tagbar'

" Vim Airline
Plugin 'vim-airline/vim-airline'

" Commenting shortcut
Plugin 'tpope/vim-commentary'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99


" Enable folding with the spacebar
nnoremap <space> za

" Run python with shortcut
nnoremap <F5> :! python % <enter>

" Run JavaScript with shortcut
nnoremap <F6> :! node % <enter>

" CTRL + S for save
nnoremap <C-S> :w <enter>

" NEARDTree toggle 
map <F2> :NERDTreeToggle<CR>

" For proper PEP 8 Standerd
"'au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix

" tab setings for html, css, js files
"au BufNewFile,BufRead *.html, *.css, *js
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4

" highligh unneccery whitespaces
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/ 
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match  /\s\+$/ 

" enabling highliting (code looks good)
"let python_highlight_all=1
syntax on

" this enables swithing between light and dark thehe (with <F5>))
"call togglebg#map("<F5>")

" enable line numbering
set nu

" enable relative line numbering
set rnu

" enable system keyboard
set clipboard=unnamed

" Enable packloadall for pack plugins.
packloadall

" Wakatime tracking plugin
Plugin 'wakatime/vim-wakatime'

" Long copy pastes
set viminfo='128,<1024

" set HTML indentention
au FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" download jslint for js syntex cheking:
" git clone https://github.com/hallettj/jslint.vim.git ~/.vim/pack/vim-jslint/start/jslint
let g:jslint_command = '!~/.vim/pack/vim-jslint/start/jslint'

" disable wrap 
set nowrap

" use 4 spacec insted if tab charecter
set tabstop =4
set shiftwidth=4
set expandtab

" auto indenting
set autoindent
set smartindent

" setting termanl color manully
let s:t_Co = 256
"color zaibatsu
"color evening
color desert


" enbling emmiting vim
let g:user_emmet_mode = 'a'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall


" cutmizing Indent Line
let g:indentLine_char = "│"
"let g:indentLine_char_list = ['⸽', '💈', '┃', '4']
"let g:indentLine_char_list = ['𝍩', '𝍪', '𝍫', '𝍬', '𝍭']

" Dvorak to QWERTY
"set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?


" Set the default command for fzf
let g:fzf_command_prefix = 'Fzf'

" Key mappings for fzf
nnoremap <silent> <Leader>p :FzfFiles<CR>
" not setup yet (3)
nnoremap <silent> <Leader>f :FzfRg<CR>
nnoremap <silent> <Leader>b :FzfBuffers<CR>
nnoremap <silent> <Leader>h :FzfHistory<CR>


" Enable emmet for specific filetypes
let g:user_emmet_settings = {
\ 'htmldjango' : {
\   'extends' : 'html'
\ }
\}



" YouCompleteMe Configration
" let g:ycm_global_ycm_extra_conf = '.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" " Delay before swoing error while typing
" let g:ycm_error_highlight_delay = 5000
" " Autoclose preview window for some LSPs
" let g:ycm_autoclose_preview_window_after_completion = 1 
" " YouCompleteMe LSP Configration
" let g:ycm_language_server = 
"     \ [ 
"     \   {
"     \     'name': 'fortran',
"     \     'cmdline': [ '/drive2/.spe/bin/fortls' ],
"     \     'filetypes': [ 'f90', 'fortran' ]
"     \   },
"     \   {
"     \     'name': 'go',
"     \     'cmdline': [ 'gopls' ],
"     \     'filetypes': [ 'go' ],
"     \     'project_root_files': [ 'go' ]
"     \   },
"     \   {
"     \     'name': 'python',
"     \     'cmdline': [ 'pylsp' ],
"     \     'filetypes': [ 'python' ],
"     \   }
"     \ ]
    " \   {
    " \     'name': 'python',
    " \     'cmdline': [ 'pylsp' ],
    " \     'filetypes': [ 'python' ],
    " \   },

" for strict typing
"    \     'extra_settings': {
"    \       'pylsp': {
"    \         'plugins': {
"    \           'mypy': {
"    \             'enabled': v:true,
"    \             'live_mode': v:true,
"    \             'strict': v:true
"    \           }
"    \         }
"    \       }
"    \     }
"    \   },
  " \   {
  " \     'name': 'csharp',
  " \     'cmdline': [ 'OmniSharp', '-lsp' ],
  " \     'filetypes': [ 'csharp' ],
  " \     'project_root_files': [ '*.csproj', '*.sln' ]
  " \   },
"   \   {
"   \     'name': 'godot',
"   \     'filetypes': [ 'gdscript' ],
"   \     'port': 6008,
"   \     'project_root_files': [ 'project.godot' ]
"   \    }
"   \ ]
