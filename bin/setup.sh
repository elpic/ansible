#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
  echo "Usage ./bin/setup.sh [OPTIONS]"
  echo ""
  echo "If --ask-vault-pass is not passed then ssh tag is going to be skip"
  echo ""
  echo "Options:"
  echo ""
  echo "  -t [tags] - a comma separated list that is going to be used to filter what to install"
  echo "  --ask-vault-pass - ask you the password to decrypt the encrypted files"
  exit
fi

# Install base software used

ANSIBLE_ARGS=""

# Ask for password if the ask-vault-pass is given
if [[ "$*" == *"--ask-vault-pass"* ]]; then
  unset -v PASSWORD # make sure it's not exported
  set +o allexport  # make sure variables are not automatically exported
  IFS= read -rsp 'Please enter password for vault: ' PASSWORD < /dev/tty

  TEMPFILE=$(mktemp)

  echo "$PASSWORD" >> $TEMPFILE
  ANSIBLE_ARGS="--vault-password-file=$TEMPFILE"
  echo ""
else
  # This is to prevent errors since the password was not provided
  ANSIBLE_ARGS="--skip-tags ssh"
fi

# Remove the option because is going to be provided in a tempfile
for arg do
  shift
  [ "$arg" = "--ask-vault-pass" ] && continue
  set -- "$@" "$arg"
done

ansible-pull -U https://github.com/elpic/ansible-personal.git $@ $ANSIBLE_ARGS

