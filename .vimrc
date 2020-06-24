set number relativenumber
set nu rnu
set smartindent
set smartcase
set tabstop=4 softtabstop=4
set shiftwidth=4

call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'anyakichi/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

call plug#end()
syntax on
colorscheme onedark

let mapleader = " "

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(100, 'ShowDocIfNoDiagnostic')
endfunction
nnoremap <silent> K :call CocAction('doHover')<CR>
autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))

	"fun! GoYCM()
		"nnoremap <buffer> <silent> <leader> gd : YcmCompleter GoTo<CR>
		"nnoremap <buffer> <silent> <leader> gr : YcmCompleter GoToReferences <CR>
		"nnoremap <buffer> <silent> <leader> rr : YcmCompleter RefactorRename<CR>
	"endfunction


	"function! s:check_back_space() abort
		"let col = col('.')-1
		"return !col || getline('.')[col-1] =~# '\s'
	"endfunction

	"fun! GoCoc ()
	"inoremap <silent><expr> <TAB>
		"		\ pumvisible() ? "\<C-n>" :
			"	\ coc#refresh()
				"\ <SID>check_back_space() ? "\<TAB>" :

	"inoremap <buffer><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	"inoremap <buffer><silent><expr><C-space> coc#refresh()
	"nmap <silent> gd <Plug>(coc-definition)
	"nmap <silent> gy <Plug>(coc-type-definition)
	"nmap <silent> gr <Plug>(coc-references)
	"nmap <silent> gi <Plug>(coc-implementation)
	"nnoremap <buffer> <leader> cr :CocRestart
	"endfunction

	"autocmd FileType cpp,cxx,h,hpp,c :call GoCoc()
	"autocmd FileType typescript :call GoYCM()


nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <silent> ? :call CocAction('doHover')<CR>
nnoremap <Leader>f :All<CR>
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ coc#refresh()
			\ <SID>check_back_space() ? "\<TAB>" :

inoremap <buffer><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer><silent><expr><C-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <buffer> <leader> cr :CocRestart
