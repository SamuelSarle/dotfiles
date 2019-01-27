alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias 1 'cd -'
alias 2 'cd -2'
alias 3 'cd -3'
alias ea 'nvim ~/dotfiles/fish/aliases.fish'
alias ef 'nvim ~/dotfiles/fish/config.fish'
alias eg 'nvim ~/.gitconfig'
alias et 'nvim ~/dotfiles/.tmux.conf'

alias ta 'tmux attach -t'
alias ts 'tmux new-session -s'
alias tl 'tmux ls'
alias tkss 'tmux kill-session -t'
alias tksv 'tmux kill-server'

alias yt 'youtube-dl -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yta 'yt -x -f bestaudio/best'

if not set -q abbrs_initialized
        set -U abbrs_initialized

        abbr g 'git'
        abbr ga 'git add'
        abbr gaa 'git add --all'
        abbr gb 'git branch'
        abbr gbl 'git blame'
        abbr gc 'git commit -v -m'
        abbr gco 'git checkout'
        abbr gcm 'git checkout master'
        abbr gcd 'git checkout develop'
        abbr gcp 'git cherry-pick'
        abbr gd 'git diff'
        abbr gcl 'git clone --recursive'
        abbr gf 'git fetch'
        abbr gfo 'git fetch origin'
        abbr gfa 'git fetch --all --prune'
        abbr gls 'git ls-tree -r --name-only HEAD'
        abbr gl 'git log'
        abbr glg 'git log --stat --max-count=10'
        abbr glog 'git log --oneline --decorate --color --graph'
        abbr gm 'git merge'
        abbr gp 'git push'
        abbr ggp 'git push origin (current_branch)'
        abbr gpl 'git pull'
        abbr ggl 'git pull origin (current_branch)'
        abbr ggpur 'git pull --rebase origin (current_branch)'
        abbr glum 'git pull upstream master'
        abbr grmv 'git remote rename'
        abbr grrm 'git remote remove'
        abbr grset 'git remote set-url'
        abbr grup 'git remote update'
        abbr grv 'git remote -v'
        abbr grb 'git rebase'
        abbr grbm 'git rebase master'
        abbr grbd 'git rebase develop'
        abbr grh 'git reset HEAD'
        abbr grhh 'git reset head --HARD'
        abbr gs 'git status'
        abbr gst 'git stash'
end

alias l 'ls -lGF'

alias v nvim
alias dv 'doas nvim'

alias x 'tmux new-session -d -s x 'startx' >/dev/null'

function vf
        f | fzf | xargs -r -I % $EDITOR %
end
