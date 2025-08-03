# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

source ~/.bash_aliases

eval "$(direnv hook bash)"

eval "$(llm cmdcomp --init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
