#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
  echo "Usage ./bin/base-install.sh"
  exit
fi

# Detect OS

unameOut="$(uname -s)"

case "${unameOut}" in
  Linux*)  machine=linux;;
  Darwin*) machine=mac;;
esac

# Install base software to install ansible

case "${machine}" in
  mac)
    # Install brew
    which brew &> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Install git
    which git &> /dev/null || brew install git
    ;;
  *)
    echo "OS not recognized please try on either linux or mac"
    exit 1
    ;;
esac

# Install base software

python3 -m pip install --upgrade pip
pip3 install --user ansible
pip3 install --user ansible-vault

echo ""
echo "NOTE: Remember to add the python binary path to your rc file"
echo ""
echo ""
echo "export PATH=\$PATH:$HOME/Library/Python/3.9/bin"
