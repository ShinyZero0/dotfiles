source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/autorun.vim
lua require("Init")
source $HOME/.config/nvim/init-alt.vim
source $HOME/.config/nvim/keys.vim
call SourceIfExists("$HOME/.config/nvim/keys-alt.vim")
colorscheme challenger_deep
