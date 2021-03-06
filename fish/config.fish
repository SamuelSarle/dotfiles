. ~/.config/fish/aliases.fish

set -Ux MANPAGER less
set -Ux HOME     /home/s/

set -gx LC_ALL "en_US.UTF-8"

set -Ux  FZF_TMUX               0
set -Ux  FZF_LEGACY_KEYBINDINGS 1
set -gx  FZF_DEFAULT_OPTS       '--height=20% --min-height=15 --reverse'
set -gx  FZF_DEFAULT_COMMAND    'rg --files --no-ignore-vcs --hidden'
set -gx  FZF_CTRL_T_COMMAND     $FZF_DEFAULT_COMMAND

set -U fish_greeting ""
