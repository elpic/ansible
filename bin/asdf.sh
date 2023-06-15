#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo "Usage ./bin/asdf.sh"
	echo ""
	echo "This program install all plugins and version of the software"
	echo "that are necessary"
	exit
fi

declare -a plugins=("elixir" "erlang" "golang" "nodejs" "python" "ruby" "rust" "yarn" "terraform" "kustomize" "postgres" "ffmpeg" "tmux" "fzf")

echo "Install plugins"

for plugin in "${plugins[@]}"; do
	if [[ $(asdf plugin list | grep -c "$plugin") -ne 1 ]]; then
		asdf plugin add "$plugin"
	fi
done

declare -a software=(
	"elixir,1.12.2"
	"elixir,1.14.3"
	"erlang,23.3"
	"nodejs,16.16.0"
	"golang,1.19.1"
	"python,2.7.18"
	"python,3.10.5"
	"yarn,1.22.17"
	"ruby,3.1.0"
	"ruby,2.6.6"
	"ruby,2.7.6"
	"rust,1.66.0"
	"terraform,1.3.7"
	"kustomize,4.5.7"
	"kustomize,5.0.0"
	"postgres,14.0"
	"ffmpeg,6.0"
	"tmux,3.0"
)
echo "Install software"

for i in "${software[@]}"; do
	IFS=","
	set -- $i

	if [[ $(asdf list "$1" | grep -c "$2") -ne 1 ]]; then
		asdf install "$1" "$2"
	fi
done
