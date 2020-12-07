#common
alias l    'ls -Fgh'
alias la   'ls -AFgh'
alias p    'pwd'
alias p3   'ping -c 3 1.1.1.1'
alias htop 'htop -t'

#common movements
alias ..  'cd ..'
alias ... 'cd ../..'

#edit dotfiles
alias ea 'vim ~/repos/dotfiles/fish/aliases.fish'
alias ef 'vim ~/repos/dotfiles/fish/config.fish'
alias eg 'vim ~/.gitconfig'
alias et 'vim ~/repos/dotfiles/.tmux.conf'
alias ev 'vim ~/repos/dotfiles/nvim/init.vim'

#editor
alias e  'vim'
alias de 'doas vim'

#youtube
alias yt  'youtube-dl -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yt2 'youtube-dl -f 22 -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yta 'yt -x -f bestaudio/best'

#confirm overwriting unless -f is specified, more verbose
alias cp 'cp -iv'
alias mv 'mv -iv'
alias rm 'rm -v'

alias t  'tmux'
alias ta 'tmux attach -t'
alias tn 'tmux new-session -s'

#power management
abbr reboot   'doas reboot'
abbr poweroff 'doas halt -p'

#python
abbr  py   'python3 -q'
abbr  ppi  'python3 -m pip install --user'
alias senv 'source bin/activate.fish'

#docker-compose
abbr dcb   'docker-compose build'
abbr dcbnc 'docker-compose build --no-cache'
abbr dcdn  'docker-compose down'
abbr dcl   'docker-compose logs'
abbr dclf  'docker-compose logs -f'
abbr dco   'docker-compose'
abbr dcps  'docker-compose ps'
abbr dcre  'docker-compose restart'
abbr dcrm  'docker-compose rm'
abbr dcst  'docker-compose stop'
abbr dcupd 'docker-compose up -d'
abbr dcup  'docker-compose up'

#git commands
abbr g     'git'
abbr ga    'git add'
abbr g.    'git add .'
abbr gaa   'git add --all'
abbr gb    'git branch'
abbr gbl   'git blame'
abbr gc    'git commit -v -m'
abbr gco   'git checkout'
abbr gcm   'git checkout master'
abbr gcd   'git checkout develop'
abbr gcp   'git cherry-pick'
abbr gd    'git diff'
abbr gcl   'git clone --recursive'
abbr gf    'git fetch'
abbr gfo   'git fetch origin'
abbr gfa   'git fetch --all --prune'
abbr gls   'git ls-tree -r --name-only HEAD'
abbr gl    'git log --oneline --decorate --color --graph'
abbr glg   'git log --stat --max-count=10'
abbr glog  'git log'
abbr gm    'git merge'
abbr gp    'git push'
abbr ggp   'git push origin HEAD'
abbr gpl   'git pull'
abbr ggl   'git pull origin HEAD'
abbr ggpur 'git pull --rebase origin HEAD'
abbr glum  'git pull upstream master'
abbr grmv  'git remote rename'
abbr grrm  'git remote remove'
abbr grset 'git remote set-url'
abbr grup  'git remote update'
abbr grv   'git remote -v'
abbr grh   'git reset HEAD'
abbr grhh  'git reset HEAD --hard'
abbr gs    'git status'
abbr gst   'git stash'

function kp --description "Kill processes"
	set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $1}')
	set -l __kp__kc $argv[1]

	if test "x$__kp__pid" != "x"
		if test "x$argv[1]" != "x"
			echo $__kp__pid | xargs kill $argv[1]
		else
			echo $__kp__pid | xargs kill -9
		end
		kp
	end
end

function fssh -d "Fuzzy-find ssh host via rg and ssh into it"
	rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end

function qr --description "QR encode a string"
	printf "$argv" | curl -F-=\<- qrenco.de
end

function weather --description "Get weather information for city."
	if test (count $argv) -eq 1
		curl "wttr.in/$argv[1]?2qFTn&lang=uk"
	else
		curl 'wttr.in/?2qFTn&lang=uk'
	end
end

#abbreviations spelling errors
abbr hotp 'htop'
