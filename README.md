# fish-profile

A function that helps with using multiple fish "profiles" (or sessions), [history sessions](https://fishshell.com/docs/current/cmds/history.html#customizing-the-name-of-the-history-file), and [private mode](https://fishshell.com/docs/current/index.html#private-mode).

On the latest fish release, 3.1.2, `fish_private_mode` is not settable. It will be settable when [fish-shell/#7589](https://github.com/fish-shell/fish-shell/issues/7589) lands in fish 3.2.0 or later. (See also related issue [fish-shell/#7590](https://github.com/fish-shell/fish-shell/issues/7590).)

This function/plugin works with fish 3.1.2 and the current master branch at [fish-shell](https://github.com/fish-shell/fish-shell). (And possibly older versions, though untested.)

It includes workarounds for the 2 mentioned fish-shell issues by copying and deleting history files when private mode is toggled. These workarounds are only used when `fish_private_mode` is not settable. They should not be needed when these issues land in a future fish release.

## Install
`> fisher install etcusrvar/fish-profile`

## Usage
```
Usage: fish-profile [OPTIONS] [PROFILE]

Open a new fish shell with PROFILE, or the default profile if not provided.

Options:
      --prune       Prune orphaned private history files
      --use         Switch to PROFILE in current session
      --help        Show this help message and exit
```


## Examples

- Toggle private mode during an active fish session. Retains current history.
```fish
> set -g fish_profile_private_mode 1
> set -e fish_profile_private_mode

# Doesn't work when fish_private_mode is not settable
> set -g fish_private_mode 1
> set -e fish_private_mode
```

- Switch to a different profile during an active session.
```fish
> fish-profile --use foo
> set -g fish_profile foo

# When fish_private_mode is settable, this will work
# If not in private mode, this will also work
# Otherwise, this will have no effect
> set -g fish_history foo
```

- Open a new fish shell with a different profile in private mode at startup. Loads that profile's history. Doesn't retain history on exit (unless private mode is toggled).
```fish
> fish-profile foo --private
> env fish_profile=foo fish --private
```

- When fish_private_mode is not settable, and a shell ends abnormally (without the fish_exit event being called), orphaned private history files can linger. They can be removed with
```fish
> fish-profile --prune
```
