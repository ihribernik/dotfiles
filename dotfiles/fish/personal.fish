# Personal config (ported from .bash_personal)

if type -q rg
  set -gx FZF_DEFAULT_COMMAND 'rg --files'
  set -gx FZF_DEFAULT_OPTS '-m --height 50% --border'
end

# NVM (best-effort; requires bass to source bash script)
set -gx NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"; and type -q bass
  bass source "$NVM_DIR/nvm.sh"
end
if test -s "$NVM_DIR/bash_completion"; and type -q bass
  bass source "$NVM_DIR/bash_completion"
end

if test -d "$HOME/go/bin"
  fish_add_path -g "$HOME/go/bin"
end

if test -d "/usr/local/go/bin"
  fish_add_path -g "/usr/local/go/bin"
end

if test -d "$HOME/.cargo/bin"
  fish_add_path -g "$HOME/.cargo/bin"
end

if test -f ~/.fzf.fish
  source ~/.fzf.fish
end

# Optional Fish-native completions
if test -f /home/ihribernik/dev/personal/alacritty/extra/completions/alacritty.fish
  source /home/ihribernik/dev/personal/alacritty/extra/completions/alacritty.fish
end

if test -x /usr/local/bin/aws_completer
  complete -c aws -f -a "(env COMP_SHELL=fish COMP_LINE=(commandline -cp) /usr/local/bin/aws_completer)"
end
