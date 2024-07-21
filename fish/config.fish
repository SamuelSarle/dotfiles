. ~/.config/fish/aliases.fish

set -Ux HOME     /home/s/
set -gx MANPAGER less
set -gx EDITOR   nvim

# set -e fish_user_paths
set -U fish_user_paths ~/bin ~/.local/bin ~/go/bin ~/.cargo/bin ~/.pub-cache/bin /opt/homebrew/bin /opt/homebrew/opt/curl/bin

set -gx LC_ALL "en_US.UTF-8"

set -U fish_greeting ""

#direnv hook fish | source

set -Ux  FZF_DEFAULT_OPTS '--height=70% --min-height=20 --reverse --cycle'
fzf_configure_bindings --git_log=\e\ch

function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
  if set --query TMUX
    fzf-tmux $argv
  else
    command fzf $argv
  end
end
