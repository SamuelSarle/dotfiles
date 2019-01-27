alias .. 'cd ..'
alias ea 'nvim ~/dotfiles/fish/aliases.fish'
alias ef 'nvim ~/dotfiles/fish/config.fish'
alias eg 'nvim ~/.gitconfig'
alias et 'nvim ~/dotfiles/.tmux.conf'

alias ta 'tmux attach -t'
alias ts 'tmux new-session -s'
alias tl 'tmux ls'
alias tkss 'tmux kill-session -t'
alias tksv 'tmux kill-server'

alias g 'git'
alias ga 'git add'
alias gaa 'git add --all'
alias gb 'git branch'
alias gc 'git commit -v'
alias gcmsg 'git commit -m'
alias gcl 'git clone --recursive'
alias gco 'git checkout'
alias gcm 'git checkout master'
alias gcd 'git checkout develop'
alias gd 'git diff'
alias gf 'git fetch'
alias gfa 'git fetch --all --prune'
alias gfo 'git fetch origin'
alias ggl 'git pull origin (current_branch)'
alias ggpur 'git pull --rebase origin (current_branch)'
alias glum 'git pull upstream master'
alias ggp 'git push origin (current_branch)'
alias gl 'git pull'
alias glog 'git log --oneline --decorate --color --graph'
alias glg 'git log --stat --max-count=10'
alias gm 'git merge'
alias gp 'git push'
alias grb 'git rebase'
alias grbm 'git rebase master'
alias grbd 'git rebase develop'
alias grh 'git reset HEAD'
alias grhh 'git reset head --HARD'
alias gr 'git remote'
alias grmv 'git remote rename'
alias grrm 'git remote remove'
alias grset 'git remote set-url'
alias grup 'git remote update'
alias grv 'git remote -v'
alias gs 'git status'



alias l 'ls -lGF'

alias v nvim
alias dv 'doas nvim'

alias x 'tmux new-session -d -s x 'startx' >/dev/null'

function f
    git ls-tree -r --name-only HEAD
end

function vf
    f | fzf | xargs -o vim
end
