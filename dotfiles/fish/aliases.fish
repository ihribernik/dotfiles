# Aliases and small environment tweaks (ported from .bash_aliases)

alias open='xdg-open'
alias pcrun='pre-commit run --all-files'

if type -q batcat
  alias bat='batcat'
  set -gx MANPAGER "sh -c 'col -bx | batcat -l man -p'"
end

if type -q minikube
  set -gx INGRESS_HOST (minikube ip)
end

if type -q vim
  set -gx EDITOR vim
end
