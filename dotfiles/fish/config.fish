# Fish shell configuration (ported from bash)

if not status is-interactive
  return
end

# Basic ls/grep colors and common aliases
if type -q ls
  alias ls='ls --color=auto'
end
if type -q grep
  alias grep='grep --color=auto'
end
if type -q fgrep
  alias fgrep='fgrep --color=auto'
end
if type -q egrep
  alias egrep='egrep --color=auto'
end

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Long command alert (kept from bash)
# alias alert='notify-send --urgency=low -i (test $status -eq 0; and echo terminal; or echo error) (history | tail -n1 | sed -e "s/^ *[0-9]\+ *//;s/[;&|] *alert$//")'

# Load split files
set -l fish_dir (dirname (status --current-filename))
if test -f "$fish_dir/aliases.fish"
  source "$fish_dir/aliases.fish"
end
if test -f "$fish_dir/personal.fish"
  source "$fish_dir/personal.fish"
end
