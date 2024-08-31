{{- if (eq .chezmoi.os "linux") -}}
#!/usr/bin/env bash
set -ev pipefail

# 1. apt update
apt update && apt upgrade -y
apt install zsh -y
chsh -s $(which zsh)

# 2. Install Homebrew
which -a brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew="$(brew --prefix)/bin/brew"
$brew --version

{{- end -}}
