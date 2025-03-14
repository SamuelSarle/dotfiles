#common
alias l    'ls -Fgh'
alias la   'ls -AFgh'
alias p    'pwd'
alias p3   'ping -c 3 1.1.1.1'
alias htop 'htop -t'

#common movements
alias ..  'cd ..'
alias ... 'cd ../..'

#youtube
alias yt  'yt-dlp -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yt2 'yt-dlp -f 22 -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias yta 'yt -x -f bestaudio/best'

alias mpva 'mpv --no-video'

alias cp 'cp -v'
alias mv 'mv -v'
alias rm 'rm -v'

abbr v 'nvim'

#python
abbr  py   'python3 -q'
abbr  ppi  'python3 -m pip install --user'
alias senv 'source bin/activate.fish'

#docker-compose
abbr dco   'docker compose'
abbr dcb   'docker compose build'
abbr dcbnc 'docker compose build --no-cache'
abbr dcdn  'docker compose down'
abbr dcl   'docker compose logs'
abbr dclf  'docker compose logs -f'
abbr dcps  'docker compose ps'
abbr dcre  'docker compose restart'
abbr dcrm  'docker compose rm'
abbr dcst  'docker compose stop'
abbr dcupd 'docker compose up -d'
abbr dcup  'docker compose up'

# Git
abbr g "git"

# Kubernetes
abbr k 'kubectl'
abbr kctx 'kubectx'
abbr kctxr 'kubectx -u'
abbr kns 'kubens'

#abbreviations for spelling errors
abbr hotp 'htop'
