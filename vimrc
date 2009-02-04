" Based on many different vimrc files including the one from Bram@vim.org as
" well as
" 
"   http://dotfiles.org/~dakrone/.vimrc
"   http://blog.infinitered.com/entries/show/9
"
" Uses many plugins including
"
"   FuzzyFinder_Textmate - http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
"   FuzzyFinder - http://www.vim.org/scripts/script.php?script_id=1984
"   taglist.vim - http://www.vim.org/scripts/script.php?script_id=273
"   Buffer Explorer - http://www.vim.org/scripts/script.php?script_id=42 
"   NERD Tree - http://www.vim.org/scripts/script.php?script_id=1658
"   rails.vim - http://www.vim.org/scripts/script.php?script_id=1567
"   vim-ruby - http://vim-ruby.rubyforge.org/
"     rubycomplete - http://www.vim.org/scripts/script.php?script_id=1662
"   SuperTab - http://www.vim.org/scripts/script.php?script_id=1643
"   Git Branch Info - http://www.vim.org/scripts/script.php?script_id=2258
"   or
"   http://lumberjaph.net/blog/index.php/2008/06/26/git-branch-everywhere/
"   Gist.vim - http://www.vim.org/scripts/script.php?script_id=2423
"
" Also see
"   gitdiff - http://www.vim.org/scripts/script.php?script_id=1846
"     or http://tekrat.com/2008/02/21/vim-diff/
"   http://whynotwiki.com/Editing_Ruby_code_in_vim
"   http://www.cuberick.com/2008/10/ruby-autocomplete-in-vim.html
"   http://make-believe.org/in-words/post/vim-is-forever
"   vcscommand.vim
"   Python menus and syntax
"     http://www.vim.org/scripts/script.php?script_id=30
"     http://www.vim.org/scripts/script.php?script_id=790
"   
"   Folding
"     http://eigenclass.org/hiki/Usable+Ruby+folding+for+Vim
"
" TIPS:
"   "*p to paste from system copy buffer
"   use ^P/^N in insert mode to complete words
"   ^] to jump to tags
"   ^W s,^W v - split windows
"   gt/gT switching between tabs (or use mappings below)
"   f<letter> / t<letter> - jump to next letter or before letter
"   gv - highlight last visual
"   gg=G - Indent the whole file


" first the disabled features due to security concerns
set modelines=0               " no modelines [http://www.guninski.com/vim1.html]
let g:secure_modelines_verbose=0 " securemodelines vimscript
let g:secure_modelines_modelines = 15 " 15 available modelines

set nocompatible
syntax on
set history=200		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set nu " line numbers
set backspace=indent,eol,start
set noerrorbells
set visualbell t_vb=          " Disable ALL bells

" convert tabs to spaces. indent level is 2
" filetype plugin indent on
set ts=2
set sw=2
set et

set showfulltag               " show full completion tags
"set wildignore+=*.o,*~,.lo    " ignore object files
"set wildmode=longest:full
"set wildmenu                  " menu has tab completion
"set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion

"set ttyfast

set dictionary=/usr/share/dict/words

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=~/.vim/backup
endif

"if $TERM =~ '^xterm'
"        set t_Co=256 
"elseif $TERM =~ '^xterm-color'
"        set t_Co=256 
"endif
 
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

"if !has("gui_running")
"     colorscheme default
if has("gui_running")
  set cursorline
  set background=dark 
  " ir_black looks great in macvim.  very close to textmate ir_black
  " if has("mac") could be used
  colorscheme ir_black 
  "set noantialias
  set guioptions-=T        " no toolbar
  "colorscheme macvim      " macvim == win
  map <MouseMiddle> <esc>"*p " paste with middle button
  set nu " it always looks fine in macvim
  set lines=40
  set columns=140
  "set gfn=Monaco:h9
else
  colorscheme desert256
end

" If I forgot to sudo vim a file, do that with :w!!
cmap w!! %!sudo tee > /dev/null %

noremap <D-r> :!ruby %<CR>
map <leader>r :!ruby %<CR>

"Buffer next,previous (ctrl-{n,p})
noremap  :bn<CR>
noremap  :bp<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

let maplocalleader = ","

" Make ',e' (in normal mode) give a prompt for opening files
" " in the same dir as the current buffer's file.
if has("unix")
  map <LocalLeader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
  map <LocalLeader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

" ---------------------------------------------------------------------------
" tabs
" (LocalLeader is ",")
map <LocalLeader>tc :tabnew<cr>    " create a new tab       
map <LocalLeader>tC :tabnew %<cr>    " create a new tab       
"map <LocalLeader>td :tabclose<cr>    " close a tab
map <LocalLeader>tq :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location

" fuzzy finder textmate
if has("ruby")
  map <leader>t :FuzzyFinderTextMate<CR>

  " Autocomplete
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  "improve autocomplete menu color
  highlight Pmenu ctermbg=238 gui=bold
else
  map <leader>t :FuzzyFinderFile<CR>
end

" BufExplorer
map <LocalLeader>bb :BufExplorer<CR>
 
" ---------------------------------------------------------------------------
"  configuration for fuzzyfinder
" find in buffer is ,fb
nmap <LocalLeader>fb :FuzzyFinderBuffer<CR>
" find in file is ,ff
nmap <LocalLeader>ff :FuzzyFinderFile<CR>
" find in tag is ,ft
nmap <LocalLeader>ft :FuzzyFinderTag<CR>

" ---------------------------------------------------------------------------
" Settings for gist.vim
if has("mac")
  let g:gist_clip_command = 'pbcopy'
end
let g:gist_detect_filetype = 1

" ---------------------------------------------------------------------------
" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1

if version >= 700

let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1

" ,tt will toggle taglist on and off
nmap <LocalLeader>tt :Tlist<cr>
" ,nn will toggle NERDTree on and off
nmap <LocalLeader>nn :NERDTreeToggle<cr>
map <leader>n :NERDTreeToggle<cr>

end

compiler ruby
"compiler python

set laststatus=2

if has('statusline')
        " Status line detail: (from Rafael Garcia-Suarez)
        " %f		file path
        " %y		file type between braces (if defined)
        " %([%R%M]%)	read-only, modified and modifiable flags between braces
        " %{'!'[&ff=='default_file_format']}
        "			shows a '!' if the file format is not the platform
        "			default
        " %{'$'[!&list]}	shows a '*' if in list mode
        " %{'~'[&pm=='']}	shows a '~' if in patchmode
        " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
        "			only for debug : display the current syntax item name
        " %=		right-align following items
        " #%n		buffer number
        " %l/%L,%c%V	line number, total number of lines, and column number
        "function! SetStatusLineStyle()
        "        if &stl == '' || &stl =~ 'synID'
        "                let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}" .
        "                                        \"%{'~'[&pm=='']}"                     .
        "                                        \"%=#%n %l/%L,%c%V "                   .
        "                                        \"git:%{call GitBranch()}"
        "        else
        "                let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}" .
        "                                        \" (%{synIDattr(synID(line('.'),col('.'),0),'name')})" .
        "                                        \"%=#%n %l/%L,%c%V "
        "        endif
        "endfunc
        "call SetStatusLineStyle()

        if has("ruby")
          let g:git_branch_status_head_current=1
          let g:git_branch_status_ignore_remotes=1
          let g:git_branch_status_text=""
        
          function! SetStatusLineStyle()
                  let &stl="%f %y "                       .
                          \"%([%R%M]%)"                   .
                          \"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
                          \"%{'$'[!&list]}"               .
                          \"%{'~'[&pm=='']}"              .
                          \"%="                           .
                          \"#%n %l/%L,%c%V "              .
                          \"git:%{GitBranchInfoString()}"
  "      \"%#StatusLineNC#%{GitBranchInfoString()}%* " .
          endfunc
        else
          function! SetStatusLineStyle()
                  let &stl="%f %y "                       .
                          \"%([%R%M]%)"                   .
                          \"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
                          \"%{'$'[!&list]}"               .
                          \"%{'~'[&pm=='']}"              .
                          \"%="                           .
                          \"#%n %l/%L,%c%V "
          endfunc
        end
        call SetStatusLineStyle()

        if has('title')
                set titlestring=%t%(\ [%R%M]%)
        endif

        "highlight StatusLine    ctermfg=White ctermbg=DarkBlue cterm=bold
        "highlight StatusLineNC  ctermfg=White ctermbg=DarkBlue cterm=NONE
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")


" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp
"

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Don't write backup file for some files
au BufWrite /private/tmp/crontab.* set nowritebackup
au BufWrite /private/tmp/crontab.* set nobackup
au BufWrite /tmp/crontab.* set nowritebackup
au BufWrite /tmp/crontab.* set nobackup

au BufWrite /Users/taylor/sw/etc/pass set nowritebackup
au BufWrite /Users/taylor/sw/etc/pass set nobackup
au BufWrite /Users/taylor/sw/etc/pass set noswapfile

au BufWrite pass set nowritebackup
au BufWrite pass set nobackup
au BufWrite pass set noswapfile

au BufWrite ~/work/catalis/*pass* set nowritebackup
au BufWrite ~/work/catalis/*pass* set nobackup
au BufWrite ~/work/catalis/*pass* set noswapfile

" set up syntax highlighting for my e-mail
au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,/tmp/mutt* :set ft=mail 