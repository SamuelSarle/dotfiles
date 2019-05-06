#common
alias   l        'ls -lFh'

alias   neofetch 'neofetch --gtk3 off --ascii_distro openbsd_small --disable cpu gpu memory --color_blocks off'

#common movements
alias   ..      'cd ..'
alias   ...     'cd ../..'

#taskwarrior
alias   t       'task'
alias   ta      'task add'
alias   tm      'task modify'
alias   te      'task edit'
alias   td      'task done'
alias   trm     'task delete'
alias   tl      'task ls due.before:now+30d'
alias   tlo     'task ls due:'
alias   tla     'task ls'
alias   ti      'task info'

function tlp --description "Print tasks associated with a project"
	if test (count $argv) -eq 1
		task ls pro:$argv[1]
	else
		echo "Need one argument to use"
	end
end

#edit dotfiles
alias   ea      'vim ~/dotfiles/fish/aliases.fish'
alias   ef      'vim ~/dotfiles/fish/config.fish'
alias   eg      'vim ~/.gitconfig'
alias   et      'vim ~/dotfiles/.tmux.conf'
alias   ev      'vim ~/dotfiles/init.vim'
alias   ee      'vim ~/dotfiles/vis/visrc.lua'

#editor
alias   e       'vim'
alias   de      'doas vim'

#tmux
alias   tma     'tmux attach -t'
alias   tms     'tmux new-session -s'
alias   tml     'tmux ls'
alias   tkss    'tmux kill-session -t'
alias   tksv    'tmux kill-server'

#youtube
alias   mpva    'mpv --no-video'
alias   yt      'youtube-dl -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias   yta     'yt -x -f bestaudio/best'

#confirm the operations unless -f is specified
alias   rm      'rm -i'
alias   cp      'cp -i'
alias   mv      'mv -i'

#power management
abbr    reboot   'doas reboot'
abbr    halt     'doas halt -p'

#python
abbr    py       'python3 -q'
abbr    ppi      'pip install --user'
alias   senv     'source bin/activate.fish'

#git commands
abbr    g        'git'
abbr    ga       'git add'
abbr    g.       'git add .'
abbr    gaa      'git add --all'
abbr    gb       'git branch'
abbr    gbl      'git blame'
abbr    gc       'git commit -v -m'
abbr    gco      'git checkout'
abbr    gcm      'git checkout master'
abbr    gcd      'git checkout develop'
abbr    gcp      'git cherry-pick'
abbr    gd       'git diff'
abbr    gcl      'git clone --recursive'
abbr    gf       'git fetch'
abbr    gfo      'git fetch origin'
abbr    gfa      'git fetch --all --prune'
abbr    gls      'git ls-tree -r --name-only HEAD'
abbr    gl       'git log --oneline --decorate --color --graph'
abbr    glg      'git log --stat --max-count=10'
abbr    glog     'git log'
abbr    gm       'git merge'
abbr    gp       'git push'
abbr    ggp      'git push origin HEAD'
abbr    gpl      'git pull'
abbr    ggl      'git pull origin HEAD'
abbr    ggpur    'git pull --rebase origin HEAD'
abbr    glum     'git pull upstream master'
abbr    grmv     'git remote rename'
abbr    grrm     'git remote remove'
abbr    grset    'git remote set-url'
abbr    grup     'git remote update'
abbr    grv      'git remote -v'
abbr    grb      'git rebase'
abbr    grbm     'git rebase master'
abbr    grbd     'git rebase develop'
abbr    grh      'git reset HEAD'
abbr    grhh     'git reset HEAD --hard'
abbr    gs       'git status'
abbr    gst      'git stash'

function gls
	git ls-tree -r --name-only HEAD
end

function fe
	gls | fzf | xargs -r -I % $EDITOR %
end

function rmf --description "Fuzzy find the file to delete"
	find . -type f | fzf | xargs -r -I % rm -i %
end

function wiki --description "Fuzzy find a wiki to edit"
	find ~/wiki/ -type f | fzf | xargs -r -I % $EDITOR %
end

function wikin --description "Create a new wiki if it doesn't exist already"
	if test (count $argv) -gt 0
		if test -e ~/wiki/$argv.md
			echo "That page already exists: $argv"
		else
			touch ~/wiki/$argv.md; and eval $EDITOR ~/wiki/$argv.md
		end
	else
		echo "Need an argument to create a wiki page"
	end
end

function wikirm --description "Fuzzy find for a wiki to remove"
	find ~/wiki/ -type f | fzf | xargs -r -I % rm %

	# Alternatively iterate over a list of wikis to delete
	# if test (count $argv) -gt 0
		# for page in $argv
			# if test -e ~/wiki/$page.md
				# rm -f ~/wiki/$page.md
			# else
				# echo "That page doesn't exist: $page"
			# end
		# end
	# else
		# echo "Need argument(s) to remove wiki page(s)"
	# end
end
function wikimv --description "Rename a wiki"
	if test (count $argv) -eq 2
		if test -e ~/wiki/$argv[1].md
			if test -e ~/wiki/$argv[2].md
				echo "Collision, new name already exists: $argv[2]"
			else
				mv ~/wiki/$argv[1].md ~/wiki/$argv[2].md
			end
		else
			echo "File to be renamed doesn't exist: $argv[1]"
		end
	else
		echo "Incorrect amount of arguments, need two"
	end
end

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

function fp --description "Search your path"
	set -l loc (echo $PATH | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:path]'")

	if test (count $loc) = 1
		set -l cmd (rg --files -L $loc | rev | cut -d'/' -f1 | rev | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:exe] => $loc'")
		if test (count $cmd) = 1
			echo $cmd
		else
			fp
		end
	end
end

function fssh -d "Fuzzy-find ssh host via rg and ssh into it"
	rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end

function fs -d "Switch tmux session"
	tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

#abbreviations for some common spelling errors
abbr    hotp     'htop'
