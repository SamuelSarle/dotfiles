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

function nvim --wraps nvim
	set -lx ANTHROPIC_API_KEY (cat ~/.config/anthropic/.api_key)
	command nvim $argv
end

if status --is-interactive
	#direnv hook fish | source
	atuin init fish | source
	#carapace _carapace | source
	zoxide init fish | source
	starship init fish | source
end
