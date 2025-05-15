. ~/.config/fish/aliases.fish

set -Ux HOME     /Users/samuelsarle/
set -gx MANPAGER less
set -gx EDITOR   nvim

# set -e fish_user_paths
set -U fish_user_paths ~/bin ~/.local/bin ~/go/bin ~/.cargo/bin /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/ruby/bin /opt/homebrew/opt/curl/bin /opt/homebrew/lib/ruby/gems/3.4.0/bin

set -gx LC_ALL "en_US.UTF-8"

set -U fish_greeting ""

set -gx HOMEBREW_UPGRADE_GREEDY       "true"
set -gx HOMEBREW_NO_INSECURE_REDIRECT "1"
set -gx HOMEBREW_CASK_OPTS            "--require-sha"
set -gx HOMEBREW_NO_AUTO_UPDATE       "1"

if status is-interactive
	mise activate fish | source
	# direnv hook fish | source
	atuin init fish --disable-up-arrow | source
	#carapace _carapace | source
	zoxide init fish --cmd cd | source
	starship init fish | source
	COMPLETE=fish jj | source
	# fnm env --use-on-cd --shell fish | source
end

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

set fish_cursor_insert block blink
