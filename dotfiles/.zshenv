setopt aliases

alias wcat='python -m aider.scrape'
alias wpdf='playwright pdf'
alias clip='tee /dev/tty | grep -v \`\`\` | pbcopy'

export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH:/opt/cosmocc/bin"

export OLLAMA_FLASH_ATTENSTION=1
export OLLAMA_KV_CACHE_TYPE=q8_0
export OLLAMA_NUM_CTX=8192
