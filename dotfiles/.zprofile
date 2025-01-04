# System-wide profile for interactive zsh(1) login shells.

# Setup user specific overrides for this in ~/.zprofile. See zshbuiltins(1)
# and zshoptions(1) for more details.

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export GOBIN="$HOME/go/bin"
export PATH="$PATH:$GOBIN:/opt/cosmocc/bin"

