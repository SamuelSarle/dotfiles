. ~/.config/fish/aliases.fish

set -Ux GOPATH   ~/go
set -Ux EDITOR   kak
set -Ux MANPAGER less
set -Ux BROWSER  firefox
set -Ux TERMINAL st
set -Ux HOME     /home/s/

set -gx PATH   /bin ~/go/bin ~/.local/bin ~/.local/bin/elixir-ls-bin ~/go/bin ~/.cargo/bin $PATH

set -gx LC_ALL "en_US.UTF-8"

set -gx MOZ_ENABLE_WAYLAND 1
set -gx XKB_DEFAULT_LAYOUT us
set -gx LESSHISTFILE       "-"

set -Ux  FZF_TMUX               0
set -Ux  FZF_LEGACY_KEYBINDINGS 1
set -gx  FZF_DEFAULT_OPTS       '--height=20% --min-height=15 --reverse'
set -gx  FZF_DEFAULT_COMMAND    'rg --files --no-ignore-vcs --hidden'
set -gx  FZF_CTRL_T_COMMAND     $FZF_DEFAULT_COMMAND

set -gx KAKOUNE_POSIX_SHELL /usr/local/bin/bash

set -U fish_greeting ""
