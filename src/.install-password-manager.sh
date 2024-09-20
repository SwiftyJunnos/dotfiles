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
    if command -v sudo &> /dev/null; then
        SUDO="sudo"
    else
        SUDO=""
    fi

    if ! [ -f /usr/share/keyrings/1password-archive-keyring.gpg ]; then
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | $SUDO gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    fi

    if ! [ -f /etc/apt/sources.list.d/1password.list ]; then
        echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main' | $SUDO tee /etc/apt/sources.list.d/1password.list
    fi

    if ! [ -f /etc/debsig/policies/AC2D62742012EA22/1password.pol ]; then
        $SUDO mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | $SUDO tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
        $SUDO mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | $SUDO gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
    fi

    $SUDO apt update && $SUDO apt install 1password-cli -y
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac