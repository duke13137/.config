setopt aliases

alias wcat='python -m aider.scrape'
alias wpdf='playwright pdf'
alias clip='tee /dev/tty | grep -v \`\`\` | pbcopy'

export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH:/opt/cosmocc/bin"

