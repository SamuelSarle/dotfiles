#!/usr/bin/env nu

# organize-repos.nu
# Organizes git repositories in the current directory into <org>/<repo> structure
# by reading the `origin` remote URL from jujutsu (jj).
#
# Usage:
#   nu organize-repos.nu                              # dry run (default, safe)
#   nu organize-repos.nu --allow-git-init             # init jj repos, but don't move anything
#   nu organize-repos.nu --allow-move                 # move repos (skips init if jj not present)
#   nu organize-repos.nu --allow-git-init --allow-move  # do everything

def main [--allow-git-init, --allow-move] {
    let mode_parts = (
        [
            (if $allow_git_init { "git-init enabled" } else { "git-init dry-run" }),
            (if $allow_move     { "move enabled"     } else { "move dry-run"     }),
        ]
        | str join ", "
    )
    print $"==> Mode: ($mode_parts)\n"

    # Step 1: find directories that are git repos (contain a .git entry) at max depth 2
    let git_dirs = (
        fd -t d -d 2 '.git$' -H
        | lines
        | str trim
        | where ($it | is-not-empty)
        # .git path -> parent directory (the actual repo root)
        | path dirname
        # keep only top-level repos (depth 1) — skip already-nested ones like org/repo
        | where ($it | path split | length) == 1
    )

    if ($git_dirs | is-empty) {
        print "No git repositories found at depth 1."
        return
    }

    print $"Found ($git_dirs | length) git repositor\(y/ies):\n"

    for dir in $git_dirs {
        print $"--- Processing: ($dir)"
        process-repo $dir $allow_git_init $allow_move
        print ""
    }
}

def process-repo [dir: string, allow_git_init: bool, allow_move: bool] {
    # Step 2: try listing remotes via jj
    let result = (do { jj git remote list --repository $dir } | complete)

    let remote_output = if $result.exit_code != 0 {
        # Step 3: error path — not a jj repo yet, try to colocate-init
        print $"  jj repo not found in '($dir)', initialising..."

        if not $allow_git_init {
            print $"  [DRY RUN] Would run: jj git init --colocate ($dir)"
            print $"  [DRY RUN] Skipping further processing \(pass --allow-git-init to enable)."
            return
        } else {
            let init_result = (do { jj git init --colocate $dir } | complete)
            if $init_result.exit_code != 0 {
                print $"  ERROR: jj git init --colocate ($dir) failed:\n  ($init_result.stderr)"
                return
            }
        }

        # Retry after init
        let retry = (do { jj git remote list --repository $dir } | complete)
        if $retry.exit_code != 0 {
            print $"  ERROR: Still cannot list remotes for '($dir)' after init. Skipping."
            return
        }
        $retry.stdout
    } else {
        $result.stdout
    }

    # Step 4 & 5: parse remotes, find `origin`
    let origin_line = (
        $remote_output
        | lines
        | str trim
        | where ($it | is-not-empty)
        | parse "{name} {url}"
        | where $it.name == "origin"
        | first
    )

    if ($origin_line | is-empty) {
        print $"  WARNING: No 'origin' remote found for '($dir)'. Skipping."
        return
    }

    let origin_url = $origin_line.url

    print $"  origin URL: ($origin_url)"

    # Extract org and repo from URL
    # Handles:
    #   https://host/org/repo.git
    #   https://host/org/repo
    #   ssh://host/org/repo
    #   git@host:org/repo.git
    #   git@host:org/repo
    let path_part = (
        $origin_url
        | str replace --regex '^git@[^:]+:' '/'     # git@host:org/repo -> /org/repo
        | str replace --regex '^https?://[^/]+' ''  # https://host/org/repo -> /org/repo
        | str replace --regex '^ssh?://[^/]+' ''    # ssh://git@host/org/repo -> /org/repo
        | str replace --regex '\.git$' ''           # strip trailing .git
        | str trim --char '/'
    )

    let segments = ($path_part | path split)
    if ($segments | length) < 2 {
        print $"  WARNING: Cannot parse org/repo from URL '($origin_url)'. Skipping."
        return
    }

    # Take last two segments as org/repo (handles deeper paths gracefully)
    let org  = ($segments | last 2 | first)
    let repo = ($segments | last)

    print $"  Parsed  → org=($org)  repo=($repo)"

    # Step 6: determine if move is needed

    # Already at desired location?
    if $dir == $"($org)/($repo)" {
        print $"  Already organised at ($org)/($repo). Nothing to do."
        return
    }

    # Already nested (depth > 1)? Skip to avoid double-nesting.
    if ($dir | path split | length) >= 2 {
        print $"  '($dir)' is already nested — skipping to avoid double-nesting."
        return
    }

    # Warn if directory name differs from remote repo name
    if ($dir | path basename) != $repo {
        print $"  NOTE: directory name '($dir)' differs from remote repo name '($repo)'. Will use remote name."
    }

    let bak  = $"($dir).bak"
    let dest = $"($org)/($repo)"

    # Refuse to overwrite an existing destination
    if ($dest | path exists) {
        print $"  WARNING: Destination '($dest)' already exists. Skipping to avoid overwrite."
        return
    }

    if not $allow_move {
        print $"  [DRY RUN] mv ($dir) ($bak)"
        print $"  [DRY RUN] mkdir -p ($org)"
        print $"  [DRY RUN] mv ($bak) ($dest)"
        print $"  [DRY RUN] → ($dir)  would be moved to  ($dest)  \(pass --allow-move to enable)"
    } else {
        mv $dir $bak
        mkdir $org
        mv $bak $dest
        print $"  ✓ Moved ($dir) → ($dest)"
    }
}
