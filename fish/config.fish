. ~/.config/fish/aliases.fish

set -x   PATH   ~/.local/bin  ~/bin $PATH
set -x   GOPATH ~/go
set -gx  EDITOR '/usr/local/bin/vise'
set -gx  HOME   '/home/samuel'

set -U   FZF_TMUX             0
set -gx  FZF_DEFAULT_OPTS     '--height=20% --min-height=15 --reverse'
set -gx  FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
set -gx  FZF_CTRL_T_COMMAND    $FZF_DEFAULT_COMMAND
