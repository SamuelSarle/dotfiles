#common
alias l 'ls -Fgh'
alias la 'ls -AFgh'
alias p pwd
alias p3 'ping -c 3 1.1.1.1'
alias htop 'htop -t'

#common movements
alias .. 'cd ..'
alias ... 'cd ../..'

#youtube
alias yt 'yt-dlp -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yt2 'yt-dlp -f 22 -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yta 'yt -x -f bestaudio/best'

alias mpva 'mpv --no-video'

alias cp 'cp -v'
alias mv 'mv -v'
alias rm 'rm -v'

alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"

abbr v nvim

#python
abbr py 'python3 -q'
abbr ppi 'python3 -m pip install --user'
abbr senv 'source bin/activate.fish'

#docker-compose
abbr dco 'docker compose'
abbr dcb 'docker compose build'
abbr dcbnc 'docker compose build --no-cache'
abbr dcdn 'docker compose down'
abbr dcl 'docker compose logs'
abbr dclf 'docker compose logs -f'
abbr dcps 'docker compose ps'
abbr dcre 'docker compose restart'
abbr dcrm 'docker compose rm'
abbr dcst 'docker compose stop'
abbr dcupd 'docker compose up -d'
abbr dcup 'docker compose up'

# Git
abbr g git

# JJ
abbr jba "jj bookmark advance"
abbr jbc "jj bookmark create -r"
abbr jbm "jj bookmark move -t"
abbr jbt "jj bookmark track --remote"
abbr jc "jj commit"
abbr jci "jj commit -i"
abbr jd "jj diff"
abbr je "jj edit"
abbr jgc "jj git clone"
abbr jgf "jj git fetch"
abbr jgi "jj git init"
abbr jgp "jj git push"
abbr jgpn "jj git push --allow-new"
abbr jl "jj log"
abbr jla "jj log -r 'all()'"
abbr jn "jj new"
abbr jnt "jj new 'trunk()'"
abbr jr "jj rebase"
abbr jrt "jj rebase -o 'trunk()'"
abbr js "jj status"
abbr jsh "jj show"
abbr jsp "jj split"
abbr jsq "jj squash"

# Kubernetes
abbr ku kubectl
abbr kuctx kubectx
abbr kuctxr 'kubectx -u'
abbr kuns kubens

abbr pd podman
abbr pdb 'podman build'
abbr pdc 'podman container'
abbr pdi 'podman image'
abbr pdr 'podman run'

#abbreviations for spelling errors
abbr hotp htop
