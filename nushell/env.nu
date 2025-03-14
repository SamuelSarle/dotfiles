# Nushell Environment Config File
#
# version = "0.100.0"

#def create_left_prompt [] {
#    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
#        null => $env.PWD
#        '' => '~'
#        $relative_pwd => ([~ $relative_pwd] | path join)
#    }
#
#    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
#    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
#    let path_segment = $"($path_color)($dir)(ansi reset)"
#
#    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
#}
#
#def create_right_prompt [] {
#    # create a right prompt in magenta with green separators and am/pm underlined
#    let time_segment = ([
#        (ansi reset)
#        (ansi magenta)
#        (date now | format date '%x %X') # try to respect user's locale
#    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
#        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")
#
#    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
#        (ansi rb)
#        ($env.LAST_EXIT_CODE)
#    ] | str join)
#    } else { "" }
#
#    ([$last_exit_code, (char space), $time_segment] | str join)
#}

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
