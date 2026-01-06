# Nushell Config File
#
# version = "0.103.0"

use std "path add"
path add ($env.HOME | path join "go" "bin")
path add ($env.HOME | path join ".cargo" "bin")
path add ($env.HOME | path join ".local" "bin")
path add "/nix/var/nix/profiles/default/bin"
path add "/usr/local/bin"
path add "/opt/homebrew/sbin"
path add "/opt/homebrew/bin"
$env.PATH = ($env.PATH | uniq)

$env.config.show_banner = false

alias l = ls -l
alias la = ls -la

$env.HOMEBREW_UPGRADE_GREEDY = "true"
$env.HOMEBREW_NO_INSECURE_REDIRECT = "1"
$env.HOMEBREW_CASK_OPTS = "--require-sha"
$env.HOMEBREW_NO_AUTO_UPDATE = "1"

$env.EDITOR = "/opt/homebrew/bin/nvim"

source ~/.cache/nushell/zoxide.nu
source ~/.cache/nushell/atuin.nu
source ~/.cache/nushell/starship.nu

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
