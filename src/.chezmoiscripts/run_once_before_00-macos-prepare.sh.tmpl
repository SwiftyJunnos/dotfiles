{{- if (eq .chezmoi.os "darwin") -}}
#!/usr/bin/env bash
set -ev pipefail

# 1. Install Homebrew
which -a brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew="$(brew --prefix)/bin/brew"
$brew --version

# 2. Install brew packages
$brew bundle --no-lock --file={{ .chezmoi.sourceDir }}/.brewfiles/{{ .chezmoi.osid }}-Brewfile

# 3. Upgrade already-installed brew packages
$brew update && $brew upgrade

# 4. Change default sh to zsh
chsh -s $(which zsh)

{{- end -}}
