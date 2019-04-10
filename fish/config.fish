. ~/.config/fish/aliases.fish

set -x   PATH   ~/.local/bin  $PATH
set -gx  EDITOR '/usr/local/bin/nvim'
set -gx  HOME   '/usr/home/samuel'

set -gx  fish_greeting  ''

set -U   FZF_TMUX             0
set -gx  FZF_DEFAULT_OPTS     '--height=20% --min-height=15 --reverse'
set -gx  FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
set -gx  FZF_CTRL_T_COMMAND    $FZF_DEFAULT_COMMAND
