alias .. 'cd ..'
alias ea 'nvim ~/dotfiles/fish/aliases.fish'
alias ef 'nvim ~/dotfiles/fish/config.fish'
alias eg 'nvim ~/.gitconfig'
alias et 'nvim ~/dotfiles/.tmux.conf'

alias l 'ls -lGF'

function v
        nvim $argv
end

function dv
        doas nvim $argv
end

function x
        tmux new-session -d -s x 'startx' >/dev/null
end

function f
    git ls-tree -r --name-only HEAD
end

function vf
    f | fzf | xargs -o vim
end
