let mapleader =" "
let maplocalleader =" "

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'goerz/jupytext.vim'
Plug 'bfredl/nvim-ipy'
Plug 'ivanov/vim-ipython'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
"Plug 'valloric/youcompleteme'
Plug 'TidalPaladin/vim-snippets'
Plug 'unblevable/quick-scope'
Plug 'Chiel92/vim-autoformat'
call plug#end()

set bg=light
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set so=20
set t_Co=256

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set shiftwidth=2
	set tabstop=2

" Macro efficiency - skip term redraw during macros
	set lazyredraw

" Case insensitive for lowercase searches, case sensitive otherwise
	set smartcase
	set ignorecase

" Persistent undo file
	set undofile

" Enable autocompletion:
	set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
	"nm <leader>d :call ToggleDeadKeys()<CR>
	"imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	"nm <leader>i :call ToggleIPA()<CR>
	"imap <leader>i <esc>:call ToggleIPA()<CR>a
	"nm <leader>q :call ToggleProse()<CR>

	nnoremap Q @@

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	"map <leader>s :!clear && shellcheck %<CR>
" Shortcut for save file
	map <leader>s :w<CR>

" Shortcut for exit
	map <leader>q :q<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" vim-fugitive git mappings
	map <leader>gs :Gstatus<CR>
	map <leader>gc :Gcommit -v<CR>
	map <leader>gd :Gdiff<CR>
	map <leader>gw :Gwrite<CR>
	map <leader>gr :Gread<CR>
	map <leader>ge :Gedit<CR>
	map <leader>gl :Glog<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.ipynb set filetype=python

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bmdirs,~/.bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Navigating with guides
	"inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	"vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	"map <leader><leader> <Esc>/<++><Enter>"_c4l

"""LATEX
	" Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Code snippets
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

	""" My mods
	autocmd FileType tex inoremap ,ali \begin{align}<Enter>\end{align}<Esc>O
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><Enter>\end{DELRN}<Enter><Enter><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,bma \begin{bmatrix}<Enter>\end{bmatrix}<Esc>O
	autocmd FileType tex inoremap ,bs \boldsymbol{}<Esc>i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,can \cand{}<Tab><Esc>T{i
	autocmd FileType tex inoremap ,cas \begin{cases}<Enter>\end{cases}<Esc>O
	autocmd FileType tex inoremap ,con \const{}<Tab><Esc>T{i
	autocmd FileType tex inoremap ,em \emph{}<Esc>T{i
	autocmd FileType tex inoremap ,enu \begin{enumerate}[(a)]<Enter>\end{enumerate}<Esc>O\item<Space>
	autocmd FileType tex inoremap ,eq \begin{equation}<Enter>\end{equation}<Esc>O
	autocmd FileType tex inoremap ,for \foreach \l [count=\i] in {}<Esc>i
	autocmd FileType tex inoremap ,fra \frac{}{}<Esc>F{F{a
	autocmd FileType tex inoremap ,itm <Enter>\item<Space>
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,ph \phantom{}<Esc>i
	autocmd FileType tex inoremap ,pma \begin{pmatrix}<Enter>\end{pmatrix}<Esc>O
	autocmd FileType tex inoremap ,ref \ref{}<Space><Esc>T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><Esc>T{i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,tdn \draw[] () -- <Enter><Tab>\node[midway] {}<Enter>();<Esc>2kf{a
	autocmd FileType tex inoremap ,tdr \draw[] ();<Esc>0f[a
	autocmd FileType tex inoremap ,te \text{}<Space><Esc>T{i
	autocmd FileType tex inoremap ,tno \node[] () {};<Esc>0f[a
	autocmd FileType tex inoremap ,tpi \begin{tikzpicture}[scale=1.0, thick]<Enter>\end{tikzpicture}<Esc>O
	autocmd FileType tex inoremap ,tsc \textsc{}<Space><Esc>T{i
	autocmd FileType tex inoremap ,tse \tikzset{%<Enter>./.style={}<Enter>}<Esc><<kI
	autocmd FileType tex inoremap ,tt \texttt{}<Space><Esc>T{i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i

	autocmd FileType tex inoremap ,pro %==================<Esc>yypO
			\\HomeworkHeader{}{}<Enter>
			\Problem text<Enter>
			\\begin{solution}<Enter>\end{solution}<Enter>
			\\begin{proof}<Enter>\end{proof}

"""HTML
	autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html inoremap ,it <em></em><Space><++><Esc>FeT>i
	autocmd FileType html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
	autocmd FileType html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,li <Esc>o<li></li><Esc>F>a
	autocmd FileType html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
	autocmd FileType html inoremap ,td <td></td><++><Esc>Fdcit
	autocmd FileType html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType html inoremap ,th <th></th><++><Esc>Fhcit
	autocmd FileType html inoremap ,tab <table><Enter></table><Esc>O
	autocmd FileType html inoremap ,gr <font color="green"></font><Esc>F>a
	autocmd FileType html inoremap ,rd <font color="red"></font><Esc>F>a
	autocmd FileType html inoremap ,yl <font color="yellow"></font><Esc>F>a
	autocmd FileType html inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
	autocmd FileType html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
	autocmd FileType html inoremap &<space> &amp;<space>
	autocmd FileType html inoremap á &aacute;
	autocmd FileType html inoremap é &eacute;
	autocmd FileType html inoremap í &iacute;
	autocmd FileType html inoremap ó &oacute;
	autocmd FileType html inoremap ú &uacute;
	autocmd FileType html inoremap ä &auml;
	autocmd FileType html inoremap ë &euml;
	autocmd FileType html inoremap ï &iuml;
	autocmd FileType html inoremap ö &ouml;
	autocmd FileType html inoremap ü &uuml;
	autocmd FileType html inoremap ã &atilde;
	autocmd FileType html inoremap ẽ &etilde;
	autocmd FileType html inoremap ĩ &itilde;
	autocmd FileType html inoremap õ &otilde;
	autocmd FileType html inoremap ũ &utilde;
	autocmd FileType html inoremap ñ &ntilde;
	autocmd FileType html inoremap à &agrave;
	autocmd FileType html inoremap è &egrave;
	autocmd FileType html inoremap ì &igrave;
	autocmd FileType html inoremap ò &ograve;
	autocmd FileType html inoremap ù &ugrave;


""".bib
	autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

""".xml
	autocmd FileType xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd FileType xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"


"""Python
	autocmd FileType python inoremap <F5> <Esc>:!pytest3<space><c-r>%<Enter>
	autocmd FileType python nnoremap <F5> :!pytest3<space><c-r>%<Enter>
	"""Compile in debug mode with Shift-F5
	autocmd FileType python inoremap <F15> <Esc>:!pytest3<space><c-r>% --pdb<Enter>
	autocmd FileType python nnoremap <F15> :!pytest3<space><c-r>% --pdb<Enter>

	autocmd FileType python inoremap ,cls class ():<Esc>F(i
	autocmd FileType python inoremap ,def def ():<Esc>F(i
	autocmd FileType python inoremap ,init __init__():<Esc>F(a
	autocmd FileType python inoremap ,inp <Esc>ggOimport numpy as np<Esc>``
	autocmd FileType python inoremap ,ipd <Esc>ggOimport pandas as pd<Esc>``
	autocmd FileType python inoremap ,ipl <Esc>ggOfrom matplotlib import pyplot as plt<Esc>``
	autocmd FileType python inoremap ,main if __name__ == '__main__':<Enter>
	autocmd FileType python inoremap ,re return

	au FileType python let b:ipy_celldef = ['^```python$', '^```$']
	autocmd FileType python map <silent> <leader>c <Plug>(IPy-RunCell)
	autocmd FileType python map <leader>? <Plug>(IPy-WordObjInfo)
	autocmd FileType python map <leader>k <Plug>(IPy-Interrupt)
	autocmd FileType python map <leader>t <Plug>(IPy-Terminate)

source ~/.config/nvim/autoload/theme.vim
let g:loaded_python_provider = 1
let g:ipy_set_ft = 1

" Readmes autowrap text:
autocmd BufRead,BufNewFile *.md,*.tex,*.txt,*.ipynb set tw=70
set wrap
set linebreak
set nolist  " list disables linebreak
"set textwidth=0
"set wrapmargin=0

" Jupytext
	let g:jupytext_enable = 1
	let g:jupytext_command = 'jupytext'
	let g:jupytext_fmt = 'md'
	let g:jupytext_to_ipynb_opts = '--to=ipynb --update'
	let g:jupytext_filetype_map = {'md': 'python'}
	let g:nvim_ipy_perform_mappings = 0

" Vimtex
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	set conceallevel=2
	let g:tex_conceal='abdmg'

" UltiSnips
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
