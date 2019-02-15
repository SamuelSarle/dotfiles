alias   ..      'cd ..'
alias   ...     'cd ../..'
alias   ....    'cd ../../..'
alias   1       'cd -'
alias   2       'cd -2'
alias   3       'cd -3'
alias   ea      '$EDITOR ~/dotfiles/fish/aliases.fish'
alias   ef      '$EDITOR ~/dotfiles/fish/config.fish'
alias   eg      '$EDITOR ~/.gitconfig'
alias   et      '$EDITOR ~/dotfiles/.tmux.conf'
alias   ev      '$EDITOR ~/dotfiles/init.vim'
alias   ee      '$EDITOR ~/dotfiles/vis/visrc.lua'
alias   l       'ls -lGF'

alias   e       '$EDITOR'
alias   de      'doas $EDITOR'

alias   vis     '/usr/local/bin/vis'

alias   senv    'source bin/activate.fish'

alias   x       'tmux new-session -d -s x "startx" >/dev/null'

alias   ta      'tmux attach -t'
alias   ts      'tmux new-session -s'
alias   tl      'tmux ls'
alias   tkss    'tmux kill-session -t'
alias   tksv    'tmux kill-server'

alias   mpva    'mpv --no-video'
alias   yt      'youtube-dl -i -o "%(upload_date)s-%(title)s.%(ext)s"'
alias   yta     'yt -x -f bestaudio/best'

alias   rm      'rm -i'
alias   cp      'cp -i'
alias   mv      'mv -i'

abbr    reboot   'doas reboot'
abbr    poweroff 'doas poweroff'

abbr    py       'python3'
abbr    ppi      'pip install --user'

abbr    io       'doas iocage'
abbr    iol      'iocage list'
abbr    ioc      'doas iocage console'
abbr    ios      'doas iocage start'
abbr    ior      'doas iocage restart'
abbr    iora     'doas iocage restart ALL'
abbr    ioss     'doas iocage stop'
abbr    iosa     'doas iocage stop ALL'

abbr    vm       'doas vm'
abbr    vml      'doas vm list'
abbr    vmc      'doas vm console'
abbr    vms      'doas vm start'
abbr    vmss     'doas vm stop'
abbr    vmsa     'doas vm stopall'

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
abbr    gl       'git log'
abbr    glg      'git log --stat --max-count=10'
abbr    glog     'git log --oneline --decorate --color --graph'
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
abbr    grhh     'git reset head --HARD'
abbr    gs       'git status'
abbr    gst      'git stash'

function gls
        git ls-tree -r --name-only HEAD
end

function vf
        gls | fzf | xargs -r -I % $EDITOR %
end

function wiki
    find ~/wiki/ -type f | fzf | xargs -r -I % $EDITOR %
end

function wikin
    if test (count $argv) -gt 0
        if test -e ~/wiki/$argv.md
            echo "That page already exists: $argv"
        else
            touch ~/wiki/$argv.md; and $EDITOR ~/wiki/$argv.md
        end
    else
        echo "Need an argument to create a wiki page"
    end
end

function wikirm
    if test (count $argv) -gt 0
        for page in $argv
            if test -e ~/wiki/$page.md
                rm -f ~/wiki/$page.md
            else
                echo "That page doesn't exist: $page"
            end
        end
    else
        echo "Need argument(s) to remove wiki page(s)"
    end
end

function wikire
    if test (count $argv) -eq 2
        if test -e ~/wiki/$argv[1].md
            mv ~/wiki/$argv[1].md ~/wiki/$argv[2].md
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

