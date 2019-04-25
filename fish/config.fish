. ~/.config/fish/aliases.fish

set -gx  PATH $PATH ~/bin ~/go/bin ~/.local/bin
set -gx  GOPATH ~/go
set -gx  EDITOR '/usr/local/bin/vise'
set -gx  MANPAGER less
set -gx  HOME   '/home/samuel'

function fish_prompt
	echo '; '
end

set -U   FZF_TMUX               0
set -U   FZF_LEGACY_KEYBINDINGS 1
set -gx  FZF_DEFAULT_OPTS       '--height=20% --min-height=15 --reverse'
set -gx  FZF_DEFAULT_COMMAND    'rg --files --no-ignore-vcs --hidden'
set -gx  FZF_CTRL_T_COMMAND     $FZF_DEFAULT_COMMAND
