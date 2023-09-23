"""						VIMRC SETTING(Personal)
""" https://yifengyou.github.io/learn-vim/docs/vimrc%E9%85%8D%E7%BD%AE.html
""" https://blog.51cto.com/zpf666/2335640
    set nocompatible  				   " no vi required
    set sw=4	   					"space 4
    set ts=4						"tab 4
    set softtabstop=4
	set smarttab
	set history=1000
 	set showmatch 						"{}[]"
    filetype on   						 " required
    filetype plugin indent on		 	" load filetype plugins/indent settings
	set autoread
	set autoindent
	set mouse=a 
    set selection=exclusive
    set selectmode=mouse,key
	set foldenable
	set clipboard+=unnamed 						" share clipboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"						COLOR && APPEARANCE
   "set guifont=dejaVu\ Sans\ MONO\ 10
	syntax on	"	required 
	set cursorline
    set ruler
	set number	"show line number
	set relativenumber	"important
	set ignorecase " ignore A a searching
	set hlsearch	"show highlight-search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"							VUNDLE
"\ Setting up Vundle - the vim plugin bundler
"\ Vundle is short for Vim bundle and is a Vim plugin manager.
"\ Vundle allows you to...

"\ keep track of and configure your plugins right in the .vimrc
"\ install configured plugins (a.k.a. scripts/bundle)
"\ update configured plugins
"\ search by name all available Vim scripts
"\ clean unused plugins up
"\ run the above actions in a single keypress with interactive mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"\ Vundle automatically...
"\ manages the runtime path of your installed scripts
"\ regenerates help tags after installing and updating
"\ Vundle is undergoing an interface change, please stay up to date to get latest changes.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle can get a name of a plugin as it appears in the vim plugin directory, a github :user/:repo style string, and even a full git url.
"Plugin 'Syntastic' "uber awesome syntax and errors highlighter
"Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
"Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal
"
" Vundle also updates your vim plugins with a simple command :
":VundleUpdate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle is awesome, it saves a lot of the manual work needed in pathogen.
"However, there’s always the fuss of getting it installed on a fresh machine. Adding these lines to your .vimrc, fixes that :
"						VIMRC SETTING (GENERAL)
"	https://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
	let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme) 
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set nocompatible	"required
	filetype on			"required	
	syntax on			"required
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'	"required
"...Add your plugins here... "
    Plugin 'scrooloose/nerdtree'
	nnoremap <leader>n :NERDTreeFocus<CR>
	nnoremap <C-n> :NERDTree<CR>
	nnoremap <C-t> :NERDTreeToggle<CR>
	nnoremap <C-f> :NERDTreeFind<CR>
    Plugin 'ayu-theme/ayu-vim'
"	https://github.com/ayu-theme/ayu-vim#indent-line
	set termguicolors
	" light, mirage, dark"
	let ayucolor="mirage"
    Plugin 'mattn/emmet-vim'
    Plugin 'Syntastic'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_enable_signs=1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 1

    Plugin 'bling/vim-airline'
    Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
    Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
"...All your other bundles..."
    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif

    call vundle#end()
    "must be last
	colorscheme ayu
" Setting up Vundle - the vim plugin bundler end
""
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
autocmd BufNewFile *.py,*.sh,*.c :call SetTitle() 
func SetTitle()
	if expand ("%:e") == 'sh'
		call setline(1, "#!/bin/bash")
		call setline(2, "#Author:17moonup")
		call setline(3, "#Blog: suyiie.cloud")
		call setline(4, "#Time: ".strftime("%F %T"))
		call setline(5, "#Name: ".expand("%"))
		call setline(6, "#Version:V1.0")
		call setline(7, "#Description: This is a production script ")
	endif
endfunc
