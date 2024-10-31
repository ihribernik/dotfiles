alias open='xdg-open'
alias pcrun="pre-commit run --all-files"

if [ -x "$(command -v batcat)" ]; then
	alias bat="batcat"
	export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

if [ -x "$(command -v minikube)" ]; then
	export INGRESS_HOST=$(minikube ip)
fi

if [ -x "$(command -v vim)" ]; then
	export EDITOR=vim
fi