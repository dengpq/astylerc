"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   This file is create and maintained by Deng Pengqiu
"   email: d34501@yeah.net
"   version: 4.0  2012-05-16, 15:00
"   Our goal is configure your vim editor as an IDE!! Beyond the MS Visual
"   Studio!
" sections:
"     -> General Settings
"     -> GUI Settings
"     -> Edit Enviroment Settings
"     -> File Encoding Settings
"     -> Key Mapping Settings
"     -> Define and Set Vim Functions
"     -> Vim plugins Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings {
set nocompatible      "Do not compatible with vi!This setting must be first line
let mapleader=";"     "define a map leader, you can set your favorite
let g:mapleader=";"   "define global map leader, you set your favorite
set history=500
set helplang=cn       "set help language as Chinese, Important!
"}
" GUI settings {
set nu            "display the line number
set mouse=a       "set I can use mouse
"set guifont
"set guifont=Dejavu\ Sans\ Mono\ 19
set guifont=Bitstream\ Vera\ Sans\ Mono\ 20
set textwidth=120
set columns=120
"}
"+----------------------------------------------------------------------------+
"| text in the vim window                                                     |
"|~                                                                           |
"|~                                                                           |
"|-- VISUAL --                             2f                160,19        17%|
"+----------------------------------------------------------------------------+
" 'showmode'                             'showcmd'             'ruler'
"+----------------------------------------------------------------------------+
set ruler         "display the row and column number
set showmode      "show the mode of vim in current time
set showcmd       "show the command of your input in command line
set laststatus=2  "set always show statusline, default value is 1
set cmdheight=2   "the commmand height set 2
set cursorline cursorcolumn    "hightlight current line and column
"set for syntax
syntax enable   "open syntax highlight
syntax on       "allow your use specific colorscheme to modify the default one
"Then setting the colorscheme
" progressively check higher values... falls out on first true
"the default VIMRUNTIME is /usr/share/vim/vim73, but in colors path, there is no molokai
"colorscheme, so you should install molokai into $VIMRUNTIMR/colors
colorscheme molokai
let g:molokai_original=1
set background=dark
"
if has("gui_running") "Don't display the scroll bar, menubar and toolbar
    set t_Co=256
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m  "hidden menubar
    set guioptions-=T  "hidden toolbar
    set guioptions-=b
    set showtabline=0  "hidden tabline
endif

if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif
"
"Then setting for maximize gvim window when open gvim
if has("win32")
    au GUIEnter * simalt ~x
else
    au GUIEnter * call MaximizeWindow()
endif

"define function MaximizeWindow()
func! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunc
"after define this function, do not forget add this function in .bashrc and alias gvim
"alias gvim='gvim -c "call MaximizeWindow()"'
"
if version >= 700
	hi CursorLine cterm=bold
endif
"Edit Enviroment Settings {
"set new-omning-complete...
filetype on                "set detect the file type automatic
filetype plugin on         "load the plugin depend on the file type
filetype indent on         "indent type depend on the file type
filetype plugin indent on
"
set wildmenu      "set smart complete the vim command
"Set for tab...
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab     "set use space to modify the tab
"Set for indent...
set backspace=2   "set I can use backspace key
set autoindent
set smartindent
set cindent
set cindent shiftwidth=4  "auto indent 4 spaces
"for C/C++ file, I set the last scripts
autocmd FileType c,cpp set shiftwidth=4 | set expandtab
"
" Now set the search conditions....
set incsearch    "search result real-time
set hlsearch     "hightlight search result
set ignorecase   "set ignore the case
set showmatch    "show match of () [] {}, but I want match '' <> and '""'
" Set for no backup file
set autoread        "set auto read file when it was changed from outside
set writebackup     "set no backup file
set nobackup        "set no backup file
set noswapfile      "set no backup file
set autochdir       "set the file directory is current directory
" Set code folding.....
"Vim supplied the 6 following fold types:
"    (1) manual, fold code by manual
"    (2) indent, more indent to express more advanced fold
"    (3) expr, use expression to define fold
"    (4) syntax, use syntax highlight to define fold
"    (5) diff, fold the unchanged codes
"    (6) marker, fold the marks in file
"You can type :h usr_28.txt,  :h fold.txt for help!"
set nowrap       "set do not break the line automatic 
set foldmethod=syntax   "fold the codes depend on syntax
set foldlevel=100       "set do not fold the codes
"za   On/Off current fold
"zM   Close all folds
"zR   Open all folds
"I had close the files. When I use vim to edit the files again, always jump
"the last cursor location
au BufReadPost * 
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif
" If a line of text is more than 80 columns, notice it use the underline
au BufRead,BufNewFile *.s,*.asm,*.h,*.hpp,*.c,*.cpp,*.cxx,*.cc,*.java,*.cs,*.pl,*.py,*.sh,*.tex,*.v,*.txt,*.log 2match Underlined /.\%82v/
"
" Set for encoding, fileencoding, fileencodings
set encoding=utf-8
set fenc=utf-8
set fencs=utf-8,gbk,cp936,latin-1
"
"then set for file formats
set fileformat=unix            "set file format is unix
set fileformats=unix,dos,mac   "default file types
" => Key Mapping Settings......
" navigate using h/j/k/l, disable using Up, Down, Left and Right
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
"Important! define Ctrl+h/j/k/l to move cursor
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
"define Ctrl+s to save the current file
"Save the file at normal mode
nmap <C-s>  :w<CR>
"Save the file at insert mode
imap <C-s>  <ESC>:w<CR>a
"I must define clear last highlight search results
nmap <silent><leader>nh :nohlsearch<CR>
"define Ctrl+c to COPY the select texts to system copyboard at visual mode
vnoremap <C-c> "+y
"define Ctrl+x to CUT the select texts at visual mode
vnoremap <C-x> x
"define Ctrl+p to PASTE the select contents to system copyboard at normal mode
nmap <C-v> "+p
imap <C-v> "+p
"define Ctrl+z to undo last change at visula mode
nmap <C-z> <ESC>u
imap <C-z> <ESC>ua
"define Ctrl+A to select all texts in the file
nnoremap  <C-a>  <ESC>ggVG
"fast edit .gvimrc at normal mode
nmap<silent> <leader>ee  :e ~/.vimrc<CR>
"fast reloading the .gvimrc file at normal mode
nmap<silent> <leader>ss  :source ~/.vimrc<CR>
"define use ;q to force quit all windows
nmap <leader>q  :wqa!<CR>
"set use ;gs to traverse the split windows, record: goto next splite
" goto the next split window
noremap <leader>gs <C-w><C-w>
"}
" => Vim Functions Settings {
"automatic complete () {} [] '' '""' when you input ( { [ ' " in insert mode
:inoremap (  ()<ESC>i
:inoremap )  <C-r>=ClosePair(')')<CR>
:inoremap {  {}<ESC>i
:inoremap }  <C-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <C-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
func! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc
" Compile And Run the programming files
" Compile the single source file
func! CompileCode()
    exec "w"
    if &filetype == "c"
        exec "!gcc -g -pipeline -O2 -Wall -W -c %<.c -o %<"
    elseif &filetype == "cpp"
        exec "!g++ -g -pipeline -O2 -Wall -W -c %<.cpp -o %<"
    elseif &filetype == "java"
        exec "!javac %<.java"
    elseif &filetype == "perl"
        exec "!perl %<.pl"
    elseif &filetype == "python"
        exec "!python %<.py"
    elseif &filetype == "ruby"
        exec "!ruby %<.rb"
    endif
endfunc
" Run the elf file
func! RunCode()
    exec "w"
    if &filetype == "c" || &filetype == "cpp"
        exec "! ./%<"
    elseif &filetype == "java"
        exec "!java %<"
    elseif &filetype == "perl"
        exec "!perl %<.pl"
    elseif &filetype == "python"
        exec "!python %<.py"
    elseif &filetype == "ruby"
        exec "!ruby %<.py"
    endif
endfunc
" Press F9 to Save And Compile the source files.
nmap <F9> :call CompileCode()<CR>
imap <F9> :call CompileCode()<CR>
" Press F10 to Save And Run
nmap <F10> :call RunCode()<CR>
imap <F10> :call RunCode()<CR>
"return for operating system
function! MySys()
    if has("win32") || has("win64")
        return "windows"
    elseif has("unix")
        return "unix"
    elseif has("mac")
        return "mac"
endfunc
"}
" => Setting Vim Plugins {
" For plugins management
"    (0) pathogen
" For file explor:
"    (1) TagList: Source code browser(support for C/C++,Java,Perl,Python,tcl,sql,php,etc) 
"    (2) WinManager: A windows IDE style IDE for Vim
"    (3) NERDTree: A tree explorer plugin for navigating the filesystem.
" For multi-file edit:
"    (4) MiniBufExpl: Elegant buffer exploer, takes very little screen space
" For search:
"    (5) Grep.vim: Grep search tools integration with Vim.
" For file edit:
"    (6) ShowMarks: Visually show the location of marks.
"    () Syntastic: Check syntax errors when saving a file.
"    quickfix(a built-in plugin in Vim, so it needn't install): 
"    new-omni-complete(a built-in plugin in Vim, so it needn't install): a
"    () clangComplete: C/C++ omni-completion with ctags database
"    () neocomplcache:
"    () neocomplcache-clang:
"    () A.vim: Alternate files quickly(.c --> .h etc)
"    () matchit: entend % matching for HTML, LaTeX, and many other languages.
" For status line:
"     vim-Powerline
" For debug:
"    () Clewn or vim-gdb, to debug the files in vim window
" For version control:
"    () fugitvim
" For programming language syntax:
"    () python3.0.vim: Enhanced version of the Python syntax highlighting script.
"       python_fn.vim: A set of menus/shortcuts to work with Python files
"    () Cpp.vim: Extends C++ syntax highlighting to STL classes and function names.
" For help:
"    man.vim (a build-in plugin in Vim, so it needn't install)
" For ASCII drawing:
"    () DrawIt.vim, ASCII drawing plugin: lines,ellipses,arrows,fills and more!
" For LATEX files edit:
"    () LaTeX Suite:
" All plugins can download from http://www.vim.org or github
"=======================================================================================
" => Quickfix setting, Quickfix is a build-in plugin in Vim, so it needn't install it.
"    I will use F1 ~ F7 key to map the quickfix window
"    You can type :help quickfix :h :make :h 'makeprg' :h 'switchbuf'
"    :h location-list  :h grep  :h :vimgrep  :h :grep  :h starstar-wildcard
"=======================================================================================
":cope[n] [height] open the quickfix window that list the error information (:h copen)
":ccl[ose], close the quickfix window (:h cclose)
":cp[revious], jump to previous error location (:h :cp)
":cn[ext], jump to next result (:h :cn)
":cc, list detailed error info in quickfix window (:h :cc)
":cw[indow] [height], If there are error info in current time, then open quickfix window (:h :cw)
":col[der], jump to an older error list.BTW, quickfix can record 10 error info (:h :col)
":cnew[er], jump to an newer error list (:h :cnew) 
nnoremap <leader>co  :copen<CR>
nnoremap <leader>cw  :cw<CR>
nnoremap <leader>cn  :cn<CR>
nnoremap <leader>cp  :cp<CR>
"If there are Makefile in current path, use ;m to save all files, then call Make to
"compile project. If there were errors, :cw to open quickfix window to list error info.
nnoremap <leader>m :wa<CR>:make<CR>:cw<CR><CR>
"
" => Set Ctags location {
" You can type the following commands for help.
" :h 'tags'
" :h :tag
" :h :tags
" :h CTRL-]
" :h CTRL-T
" :h vimgrep
" :h cw
" :h pattern
set tags=./tags,../tags,../../tags,../../../tags,../inc/tags,../include/tags,../src/tags
"}
" => Set Cscope {
" usage: cscope -Rbq *
" You can type :h cscope :h cword :h cfile for help.
:set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-/>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"}
" => (0) then set for pathogen in autoload {
" If I use pathogen to manage all plugins in .vim, it only need 3 directoried:
" autoload, bundle and doc. Pathogen.vim will install in autoload, and all other
" plugins will install in bundle directory.
execute pathogen#infect()
" }
" => (1) for TagList plugin settings {
" Taglist is a very useful and helpful source code brower. It was the most
" download plugin in www.vim.org. It supports C/C++,Java,Perl,Python,PHP,tcl,
" SQL,etc. I recommand all of us install this plugin.
" You can type :h taglist or :h helptags for help. 
"TagListTagName - Used For Tag Name
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
"TagListTagScope - Use For Tag Scope
highlight MyTagListTagScope gui=NONE guifg=Blue
"TagListTitle - Use For Tag Titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
"TagListComment - Use For Comments
highlight MyTagListComment guifg=DarkGreen
"TagListFileName - Use For File Name
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue
if MySys() == "windows"
    let Tlist_Ctags_Cmd='D:\ctags.exe'
elseif MySys() == "unix"
    let Tlist_Ctags_Cmd='/usr/bin/ctags' "set the path of Exuberant Ctags utility
endif
let Tlist_Show_Menu=1       "display the menu of Taglist
let Tlist_Show_One_File=1   "only list taglist of current file
let Tlist_WinWidth=25       "let taglist width 25, default value is 30
let Tlist_Inc_Winwidth=0    "the width of TagList not influnce gvim
"let Tlist_Close_On_Select=1 "close taglist window when a file or tag was selected
let Tlist_Exit_OnlyWindow=1 "When Taglist is the last window, close gvim
let Tlist_Auto_Highlight_Tag=1 "Auto highlight the selected tag
let Tlist_Compact_Format=1  "remove extra info and blank lines from the taglist window
let Tlist_Enable_Fold_Column=0  "Don't show the fold indicator column in taglist windown
let Tlist_GainFocus_On_ToggleOpen=1 "when taglist window opened, let cursor jump into taglist window
"define use ;tl to list the current file's taglist, shorthand: t(ag)l(ist)
nnoremap <Leader>tl :TlistToggle<CR>
"}
" => (2) Set WinManager Plugin {
" WinManager is a plugin which implements a classical windows type IDE in Vim-6.0 or higher.
" The WinManager that I had installed is not the original one, but a bug fix version. It can
" be download at http://www.vim.org/scripts/script.php?script_id=1440.
" This plugin was compressed in VimBall format. So you may need to the lastest version of Vimball
" first. Then download winmanager.vmb.bz2 plugin. After uncompressing to winmanager.vmb, then use
" Vim to open it terminal. Type vim(or gvim) winmanager.vmb. Then type the following command in
" your vim to install it:
" :so %
" You can type :h winmanager for help
"I must relevant Taglist plugin, or else I can't see Taglist window below
"WinManager window
let g:winManagerWidth=30  "the default width is 25
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <C-w><C-b> :BottomExplorerWindow<CR>
"define ;wm to open/close WinManager window, shorthand: w(in)m(anager)
nmap <C-w><C-f> :FirstExplorerWindow<CR>
nnoremap <Leader>wm :WMToggle<CR>
"}
" => (3) Set NERDTree plugin list all files in tree view {
" NERDTree is a tree explorer plugin for navigating the filesystem. It had a lot of commands,
" but current time, I didn't use it.
" You can type :h NERD_tree for help.
" The NERD_Tree.zip file had the following files, you could copy it into ~/.vim.
"use NERDTree to list the project file, set shortcut: N(erd)T(ree)
noremap <Leader>nt :NERDTreeToggle<CR>
"set the width of NERDTree window
let NERDTreeWinSize=25
"set the location of NERDTree Window
let NERDTreeWinPos="right"
"when the vim had only NERDTree window, exit vim or gvim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"}
" => (4) MiniBufExpl plugin settings {
" Minibufexpl is elegant buffer explorer for Vim. You can quickly switch buffers by double-click
" the appropriate tab.
" Install - you should cp the minibufexpl.vim to ~/.vim/plugin and restart Vim
" You can use the following shortcut when you switch the buffers:
" <TAB>             traverse buffers forward
" <ShIFT-TAB>       traverse buffers backward
" <ENTER>           open the buffer which the cursor at
"   d               delete the buffer which the cursor at
" <CTRL-TAB>        traverse the buffers forward and only open the current buffer window
" <CTRL-SHIFT-TAB>  traverse the buffers backward and only open the current buffer window
"==============================================================================================
let g:miniBufExplTabWrap=1            "make the tabs title show complete (no broken on two lines)
let g:miniBufExplMapWindowNavVim=1    "set use CTRL+h,j,k,l to travers buffers
let g:miniBufExplMapWindowNavArrows=1 "set use arrow keys to travers buffers
let g:miniBufExplMapCTabSwitchBufs=1  "set use CTRL+TAB and CTRL+SHIFT+TAB to traverse buffers
let g:miniBufExplModSelTarget=1       "If you use other explorers like TagList, you can set it 1
let g:miniBufExplUseSingleClick=1     "If you would like to use single click rather double click to choose the buffers, set 1
"for buffers that have NOT CHANGED and are NOT VISIBLE
highlight MBENormal guibg=LightGray guifg=DarkGray
"for buffers that have CHANGED and are NOT VISIBLE
highlight MBEChanged guibg=Red guifg=DarkRed
"for buffers that have NOT CHANGED and VISIBLE
highlight MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=DarkGreen
"for buffers that have CHANGED and VISIBLE
highlight MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black
"}
" => (5) Set Grep.vim plugin, find in projects
" Install - You should cp grep.vim to ~/.vim/plugin and restart the Vim
" You can type the following commands for help:
" :h add-plugin
" :h add-global-plugin
" :h runtimepath
" :h quickfix
" :h :grep
" :h :lgrep or :lgr
" :h :vimgrep
" :h :lvimgrep or :lv
" :h cmdline-editing
"The Grep.vim plugin introduce the following Vim commands:
":Grep     - Search for specified pattern in the specified files
":GrepAdd  - Same as :Grep but add the results to the current results
":Rgrep    - Run recursive grep
" the above command can be invoked like followings
"Grep <grep_options> <search_patterns> <search_files>
"the available grep_options was -i(ignorecase) and -w(search words)
:let Grep_Path='/usr/bin/grep'
:let Egrep_Path='/usr/bin/egrep'
:let Fgrep_Path='/usr/bin/fgrep'
":let Agrep_Path='usr/bin/agrep'
:let Grep_Find_Path='/usr/bin/find'
:let Grep_Xargs_Path='/usr/xargs'
:let Grep_Default_Options='-i'
:let Grep_Skip_Files='*.bak, *~, *.o'
"set shortcut for Grep command, shortcut: g(rep)
nnoremap <Leader>g  :Grep<CR>
"set shortcut for RGrep command, shorcut: rg(rep)
nnoremap <Leader>rg :RGrep<CR>
"set shortcut for EGrep command, shortcut: eg(rep)
nnoremap <Leader>eg :EGrap<CR>
" => (6) Set for ShowMarks plugin {
" Marks are usful for jumping back and forth between interesting points in buffer, but can be hard to
" keep track of without any way to see where you have placed them. ShowMarks hopefully makes life easier
" by placing a sign in the leftmost column of the buffer. The sign indicates the label of the mark and
" its locations.
" You can input the following commands for help......
" :h usr_03.txt
" :h usr_29.txt important!
" :h motion.txt
" :h scroll.txt
" :h marks      important
" :h mark-motions
" :h :jumps
" :h '
" Install - You just copy showmarks.vim to ~/.vim/plugin and restart
"======================================================================================================
let g:showmarks_enable=1  "enable ShowMarks
"All marks in Vim had name, which was a single character. [a-z] or [A-Z] can be used for mark name.
"Attention, the lower-alpha was confined for buffer. But upper-alpha was global, it was available in all
"files in current project.
"If you input ma to define mark a in normal mode, and you can input 'a to jump to mark a in normal mode.
let showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"Ignore help, quickfix, preview windows and non-modified buffers
let showmarks_ignore_type="hqpm"
"For marks a-z, the lower case marks were availabel in buffer. So I could define mark a in buffer 1, and I
"also defined mark a in buffer 2, etc.
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=DarkBlue
"For marks A-Z, upper case marks were available in current project.
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
"For other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
"For multiple marks on the same line
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
"highlight lower and upper marks
let showmarks_hlline_lower=1   "default is 0
let showmarks_hlline_upper=1   "default is 0
"By default, the following keymapping are defined, you can use them.
"<Leader>mt    Toggles showMarks plugin on and off
"<Leader>mh    Clears a mark
"<Leader>ma    Hiddens all marks in current buffer
"<Leader>mm    Set the next available mark in current line
"<Leader>mo    Turns ShowMarks on and display marks.
"}
" => (7) Set for c-support plugin.......
" C/C++ IDE -- write and run programs, Insert statements,idioms,comments etc.
" Use c.vim or c-support.vim plugin, you can:
"     adding file header
"     add comment
"     insert some codes segments
"     check the write
"     read the function documents
"     comment some codes
" Attention!! There is no need set c-support.vim plugin in vimrc file. You should set the template in
" ~/.vim/c-support/templates.
" You can type the following commands for help:
" :h csupport.txt
" :h templatesupport.txt
"
" Set for new-omni-complete plugin........
"You can type the following commands for help
"  :h compl-generic
"  :h 'complete'
"  :h ins-completion
"  :h new-omni-completion
"  :h compl-omni
"  :h i_CTRL-P
"  :h i_CTRL-N
"  :h i_CTRL-R
"You can use the following combinate key to complete the codes
"<C-x><C-o>  omni complete
"<C-n><C-p>  complete 
"<C-x><C-l>  complete hole line
"<C-x><C-n>  complete 
"<C-x><C-k>  complete a key which from a dictionary file
"<C-x><C-t>  complete 
"<C-x><C-i>  complete 
"<C-x><C-j>  complete the tags
"<C-x><C-f>  complete the filename
"<C-x><C-d>  complete the macro #define (include the macros which defines at header files)
"<C-x><C-v>
"<C-x><C-u> 
"<C-x><C-s>
"You can use ;<TAB> to simplify the omni complete in insert mode
inoremap <leader><TAB> <C-x><C-o>
"==============================================================================================
" => (8) Set checksyntax, which is plugin for checking syntex errors when saving a file(C,C++,
" java,python,perl,ruby,php,tex,html,xml and so on)
" Install - This plugin is a checksyntaxl.vba, so it need you install VimBall first. Then use
" vim to open checksyntax.vba and type :so % in command mode to install it."
" You can type :h checksyntax.txt for help!
"By default, 
"==============================================================================================
" => () Set clangComplete plugin, for complete C/C++/Objective-C file functions.
"     You can type the following commands for help:
"     :h omnicppcomplete
"     :h omnifun?
"     :h 'complete'
"     :h 'completefunc'
"     :h complete-functions
"     :h compl-dictionary
"     :h 'dictionary'
"     :h compl-omni
"===========================================================================================
" When you open a cpp file, please input command :set omnifunc? to see what completion
" function is currently used. If the result is omnifunc =ccomplete#Complete, it means
" you are using C complettion provided with Vim(not C++). If your :set omnifunc? is not
" set as your desired or maybe empty, this is a good workaround for C++ files to get help informations
au BufNewFile,BufRead,BufEnter *.hpp,*.cpp,*.cxx,*.cc set omnifunc=omni#cpp#complete#Main
"----------------------------------------------------------------------------------------
set tags+=~/.vim/tags/cpp
set tags+=./tags
"Build tags of your own project with Ctrl+F12
"nnoremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" set for popup menu...... {
highlight Pmenu ctermbg=13 guibg=LightGray guifg=DarkGreen
highlight PmenuSel term=bold cterm=bold gui=bold ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar term=bold cterm=bold gui=bold ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuThumb guibg=Black
"}
"Auto close popup menu and preview window when curosr move and insert leave
"the pumvisible() function return non-zero when popup menu is visible, otherwise is 0
au CursorMovedI,InsertLeave * if pumvisible()==0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
"set keymapping for completion
inoremap <expr> <CR> pumvisible()?"\<C-y>":"\<C-g>u\<CR>"
inoremap <expr> <C-j> pumvisible()?"\<PageDown><C-n>\<C-p>":"\<C-x><C-o>"
inoremap <expr> <C-u> pumvisible()?"\<C-e>":"\<C-u>"
"<TAB> : completin
inoremap <expr> <TAB> pumvisible()?"\<C-n>":"<TAB>"
"Set you can use Up/Down, PgUp/pgDn to scroll the popup menu
inoremap <expr> <Down> pumvisible()?"\<C-n>":"\<Down>"
inoremap <expr> <Up>   pumvisible()?"\<C-p>":"\<Up>"
inoremap <expr> <PageDown> pumvisible()?"\<PageDown>\<C-p>\<C-n>":"\<PageDown>" 
inoremap <expr> <pageUp>   pumvisible()?"\<PageUp>\<C-p>\<C-n>":"\<PageUp>"
"Ctrl+n
inoremap <expr> <C-n> pumvisible()?'<C-n>':'<C-n><C-r>=pumvisible()?"\<lt>Down>":""<CR>'
"Ctrl+p
inoremap <expr> <C-p> pumvisible()?'<C-p>':'<C-p><C-r>=pumvisible()?"\<lt>Up>":""<CR>'
"Ctrl+,
inoremap <expr> <C-,> pumvisible()?'<C-n>':'<C-x><C-o><C-n><C-p><C-r>=pumvisible()?"\<lt>Down>":""<CR>'
"open omni complete menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible()?(col('.')>1?'<ESC>i<Right>':'<ESC>i'):'') . '<C-x><C-o><C-r>=pumvisible()?"\<lt>C-n>\<lt>C-p>\<lt>Down>":""<CR>'
"open user complete menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible()?(col('.')>1?'<ESC>i<Right>':'<ESC>i'):'') . '<C-x><C-u><C-r>=pumvisible()?"\<lt>C-n>\<lt>C-p>\<lt>Down>":""<CR>'
" }
" => () Set A.vim plugin, switch C/C++ source or header file {
" switch c/h or cpp/h file in new buffer
nnoremap <leader><F1> :A<CR>
"horizontal split the window and open c/h or cpp/h file
nnoremap <leader><F2> :AS<CR>
"vertical split the window and open c/h or cpp/h file
nnoremap <leader><F3> :AV<CR>
"switch c/h or cpp/h file in a new tab page
nnoremap <leader><F4> :AT<CR>
"}
" set clangComplete { use Ctrl+x, Ctrl+u to complete
let g:clang_complete_auto=0
let g:clang_auto_select=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete" "or ultisnips
let g:clang_conceal_snippets=1
let g:clang_close_preview=1
let g:clang_trailing_placeholder=1
let g:clang_use_libray=1
let g:clang_library_path = "/usr/lib64/llvm" "when I new added libclang.so in /usr/lib, added this sentence
"let g:clang_auto_user_options="-I/usr/include/c++/4.6, ~/.clang_complete" "in Ubuntu-12.04-LTS-x86_64
let g:clang_auto_user_options="-I/usr/include/c++/4.7.2,~/.clang_complete"  "in Fedora17-x86_64
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
" }
" set neoComplCache {
"use neocomplcache
let g:neocomplcache_enable_at_startup=1
"use smart case
let g:neocomplcache_enable_smart_case=1
"set minimal syntax keyword length
let g:neocomplcache_min_syntax_length=3
let g:neocomplcache_lock_buffer_name_pattern='\*ku\*'
"define keyword
if !exists("g:neocomplcache_keyword_patterns")
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default']='\h\w*'
"define key mapping
inoremap <expr><C-g>  neocomplcache#undo_completion()
inoremap <expr><C-l>  neocomplcache#complete_common_string()
"Recommand keymapping
inoremap <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
"<C-h> <BS> to close popup menu and backward char
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
"enable omnicompletion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"set heavy omni complete
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"set for compatible with clang_complete
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc=1
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" }
" => Set MatchIt Plugin, extend % matching for Ada,ASP with VBS,Shell,JSP,LaTeX {
" html, XML, vim and so on.
" If you have problems about install this plugin, please type :h matchit-install
" If you don't want load this plugin, please add the sentence in your .vimrc file
" You can type :h matchit for help
:let loaded_matchit=1
:source ~/.vim/bundle/matchit/plugin/matchit.vim
let b:match_ignorecase=1
"}
" => vim-Powerline setting {
set t_Co=256
let g:Powerline_symbols='fancy'
"set fillchars+=stl:\ ,stlnc:\
let Powerline_symbols='compatible'
let g:Powerline_mode_V="V.LINE"
let g:Powerline_mode_cv="V.BLOCK"
let g:Powerline_mode_S="S.LINE"
let g:Powerline_mode_cs="S.BLOCK"
"set statusline=
"set statusline+=%7*\[%n]   "buffernr
"set statusline+=%1*\ %<%F\ "File+Path
"set statusline+=%2*\ %y\   "File Type
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''} "File Encoding
"set statusline+=%4*\ %{&ff}\  "File Encoding2
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\ "Spelllang or Highlight on?
"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\ "Row number
"set statusline+=%9*\ col:%03c\                "column number
"set statusline+=%0*\ \ %m%r%w\ %p\ \          "modified, readonly, top/bottom?

"func! HighlightSearch()
"    if &hls
"        return 'H'
"    else
"        return ''
"    endif
"endfunc
" }
" => () python3.0.vim
"       python_fn.vim
" There is no need to configure the python3.0.vim and python_fn.vim.
"
" => () cpp.vim : Extends C++ syntax hightlighting to STL classes and method names
" There is no need to configure the cpp.vim. cp -v cpp.vim ~/.vim/syntax
"
" => man.vim {
:source $VIMRUNTIME/ftplugin/man.vim
"}
" DrawIt.vim {
"}
" => () LaTeX Suite {
"}
