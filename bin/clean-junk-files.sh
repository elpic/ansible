#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

declare -a home=(".zcompdump-*" ".lesshst" ".node_repl_history")

echo "Clean up files in home directory"

for fileRegex in "${home[@]}"; do
	rm -rf ~/$fileRegex
done

echo "Clean up brew"
brew cleanup -s
