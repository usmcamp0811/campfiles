" --------------------------------------------------- Load Plugins -----------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'norcalli/nvim-colorizer.lua' " real-time colorizer
Plug 'junegunn/rainbow_parentheses.vim' " easily spot missing }
Plug 'lambdalisue/suda.vim' " runs `sudo` when needed.. no need to sudo vim blah
Plug 'vim-pandoc/vim-rmarkdown' "rmakrdown support for vim
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki' " a wiki for managing knowledge
Plug 'tpope/vim-commentary' " easy commenting of code
Plug 'vim-airline/vim-airline-themes' 
Plug 'vim-airline/vim-airline'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'mbbill/undotree' " don't use it as much as I should but its neat
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'suy/vim-context-commentstring' " figures out what comment string to use
Plug 'godlygeek/tabular' " makes markdown tables
Plug '907th/vim-auto-save' " does what it says
Plug 'baruchel/vim-notebook' " Jupyter Notebook inside Vim.. a little hacky and hard to get working
Plug 'jupyter-vim/jupyter-vim' " Another Jupyter notebook like thing for Vim.. also hacky
Plug 'junegunn/vim-easy-align' 
Plug 'camspiers/animate.vim' " moves panes in a pretty way
Plug 'camspiers/lens.vim' " auto-magically resizes vim panes for you
Plug 'lervag/vimtex' " for writing latex
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'pechorin/any-jump.vim' " pops up a window of all the times code is referenced
Plug 'eugen0329/vim-esearch'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'} " ranger in vima
Plug 'joshdick/onedark.vim' " new favorite theme
Plug 'sheerun/vim-polyglot' " multiple programing language support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " intelisense auto-complete
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'AndrewRadev/tagalong.vim' " auto-magically change html tags
Plug 'tpope/vim-surround' " easily put quotes and other things around stuff
Plug 'unblevable/quick-scope' " easier horizontal jumping
Plug 'justinmk/vim-sneak' " better vertical jumping
Plug 'liuchengxu/vim-which-key' " useful tool to help remember what got mapped where.. also kind of an alternative way to map keys
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " super useful search files
Plug 'airblade/vim-rooter' " puts you in the root of the project
Plug 'szymonmaszke/vimpyter'
Plug 'mhinz/vim-startify' " a start page for vim when no file is opened
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " really good Go lang support for vim
Plug 'JuliaEditorSupport/julia-vim' " Julia support for vim
Plug 'sedm0784/vim-you-autocorrect' " autocorrect for vim
Plug 'voldikss/vim-floaterm' " lets you make anything a floating window in vim
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim' " part of git config
Plug 'tpope/vim-fugitive' " part of git config
call plug#end()
