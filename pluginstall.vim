" --------------------------------------------------- Load Plugins -----------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'norcalli/nvim-colorizer.lua' " real-time colorizer
Plug 'tpope/vim-surround' " easily put quotes and other things around stuff
Plug 'junegunn/rainbow_parentheses.vim' " easily spot missing }
Plug 'lambdalisue/suda.vim' " runs `sudo` when needed.. no need to sudo vim blah
" Plug 'vim-pandoc/vim-rmarkdown' "rmakrdown support for vim
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki' , { 'branch': 'dev' } " a wiki for managing knowledge 
Plug 'chmp/mdnav'
Plug 'tpope/vim-commentary' " easy commenting of code
Plug 'ryanoasis/vim-devicons'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'chrisbra/csv.vim'
Plug 'JuliaEditorSupport/julia-vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'sheerun/vim-polyglot' " currently seeing slowdowns with markdown stuff
" when this is installed
Plug 'mbbill/undotree' " don't use it as much as I should but its neat
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'suy/vim-context-commentstring' " figures out what comment string to use
Plug 'godlygeek/tabular' " makes markdown tables
Plug '907th/vim-auto-save' " does what it says
Plug 'junegunn/vim-easy-align' 
Plug 'camspiers/animate.vim' " moves panes in a pretty way
Plug 'camspiers/lens.vim' " auto-magically resizes vim panes for you
Plug 'lervag/vimtex' " for writing latex
" Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'matthew-brett/vim-rst-sections'
Plug 'pechorin/any-jump.vim' " pops up a window of all the times code is referenced
Plug 'eugen0329/vim-esearch'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'} " ranger in vima
Plug 'neoclide/coc.nvim', {'branch': 'release'} " intelisense auto-complete
Plug 'AndrewRadev/tagalong.vim' " auto-magically change html tags
Plug 'unblevable/quick-scope' " easier horizontal jumping
Plug 'justinmk/vim-sneak' " better vertical jumping
Plug 'liuchengxu/vim-which-key' " useful tool to help remember what got mapped where.. also kind of an alternative way to map keys
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " super useful search files
Plug 'airblade/vim-rooter' " puts you in the root of the project
Plug 'mhinz/vim-startify' " a start page for vim when no file is opened
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " really good Go lang support for vim
" Plug 'sedm0784/vim-you-autocorrect' " autocorrect for vim
Plug 'voldikss/vim-floaterm' " lets you make anything a floating window in vim
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim' " part of git config
Plug 'tpope/vim-fugitive' " part of git config
Plug 'jpalardy/vim-slime' " allow vim to send julia / python commands to the repl
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'julia', 'markdown.pandoc']} " note: I modified this and am waiting on a MR.. so don't update
Plug 'mroavi/vim-julia-cell', { 'for': ['julia']}
Plug 'ChristianChiarulli/codi.vim'
Plug 'Konfekt/FastFold'
Plug 'dhruvasagar/vim-table-mode'
" Themes
" Plug 'joshdick/onedark.vim' " new favorite theme
" Plug 'laggardkernel/vim-one'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'jacoborus/tender.vim'
" Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Plug 'mrossinek/deuterium' "Jupyter inteface too much of a wip
" Plug 'dbridges/vim-markdown-runner' " puts code output into markdown
Plug 'kshenoy/vim-signature' " show marks in gutter
call plug#end()
