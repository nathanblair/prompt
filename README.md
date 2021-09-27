# Prompt

A lightweight prompt consistent across sh/dash/ash, zsh, and pwsh.

# Section Explanations

## Last Exit Status

## Host

## Current Context

### Directory

If not in a version-controlled directory, this section will show the current shortened path (accounting for `~` substitution).

#### Version Control

**NOTE** Only `git` has been implemented so far; no `svn` or `hg` support (yet).

If the current path is a version-controlled directory, this section will show the `dirname` of the path (suggesting the repository name) followed by the current branch.

Then, multiple columns will enumerate `git` state, according to:

- The 4 left-most columns show staged operations (**A**dded, **R**enamed, **M**odified, **D**eleted).

- The 3 right-most columns track uncommitted operations (**M**odified, **??** New file, **D**eleted).

See [here](https://www.git-scm.com/docs/git-status#_short_format) for more information about the columns output.

- `git` stash

## Prompt

# Examples

## `sh`

## `zsh`

## `pwsh`

```
prompt default 0|0|0|0|1|1|1 > g
## default...origin/default
?? README.md
prompt default 0|0|0|0|1|1|1 > sleep 3
prompt default 0|0|0|0|1|1|1 >                                              3s
prompt default 0|0|0|0|1|1|1 >
```
