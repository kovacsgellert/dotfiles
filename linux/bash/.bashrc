source ~/.local/share/omarchy/default/bash/rc

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

eval "$(starship init bash)"
