#!/usr/bin/env bash

# exit immediately if password-manager-binary is already in $PATH
type password-manager-binary >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    # commands to install password-manager-binary on Darwin
    which -a brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/work/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew="$(brew --prefix)/bin/brew"
    $brew --version

    $brew install cask "1password"
    $brew install cask "1password-cli"
    ;;
Linux)
    # commands to install password-manager-binary on Linux
    ARCH="amd64" && \
    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.0/op_linux_${ARCH}_v2.30.0.zip" -O op.zip && \
    unzip -d op op.zip && \
    sudo mv op/op /usr/local/bin/ && \
    rm -r op.zip op && \
    sudo groupadd -f onepassword-cli && \
    sudo chgrp onepassword-cli /usr/local/bin/op && \
    sudo chmod g+s /usr/local/bin/op
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac