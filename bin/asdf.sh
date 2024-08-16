#!/bin/bash -i

set -o errexit
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo "Usage ./bin/asdf.sh [OPTIONS]"
	echo ""
	echo "  install - install all the asdf applications"
	exit
fi

declare -a plugin_and_versions=(
	"ffmpeg,6.0"
	"fzf,0.52.1"
	"golang,1.19.1"
	"helm,3.11.2"
	"kustomize,4.5.7"
	"kustomize,5.0.0"
	"nodejs,16.16.0"
	"postgres,14.0"
	"python,3.10.5"
	"python,3.12.3"
	"pipx,1.5.0"
	"ruby,3.1.0"
	"rust,1.66.0"
	"terraform,1.3.7"
	"yarn,1.22.17"
	"bun,1.0.7"
	"pnpm,8.15.4"
	"neovim,0.9.5"
	"fd,10.1.0"
)

# This function receive a function that is going to be executed
# with every plugin in the list of plugins if a plugin was already
# in executed is not going to be executed twice
#
# $1 a function that is going to be executed for each plugin
execute_on_each_plugins() {
	local -a unique_plugins=()

	for item in "${plugin_and_versions[@]}"; do
		plugin=$(echo "$item" | cut -d',' -f1)

		if [[ ! "${unique_plugins[*]}" =~ $plugin ]]; then
			unique_plugins=("${unique_plugins[@]}" "$plugin")
		fi
	done

	for plugin in "${unique_plugins[@]}"; do
		$1 "$plugin"
	done
}

# This function receive a function that is going to be executed
# with every plugin and the version of the software we are trying to
# install
#
# $1 a function that is going to be executed for each plugin
execute_on_each_software() {
	for item in "${plugin_and_versions[@]}"; do
		plugin=$(echo "$item" | cut -d',' -f1)
		version=$(echo "$item" | cut -d',' -f2)

		$1 "$plugin" "$version"
	done
}

echo "Install plugins and software"

function install_plugin() {
	plugin=$1

	echo " Checking if plugin: $plugin is installed"

	if [[ $(asdf plugin list | grep -c "$plugin") -ne 1 ]]; then
		echo " Installing plugin: $plugin"
		asdf plugin add "$plugin"
	else
		echo " Skip plugin installation: $plugin"
	fi
}

function install_software() {
	plugin=$1
	version=$2

	echo " Checking if software: $plugin, $version is installed"

	if [[ $(asdf list "$plugin" | grep -c "$version") -ne 1 ]]; then
		echo " Installing software: $plugin, $version"
		asdf install "$plugin" "$version"
	else
		echo " Skip software installation: $plugin, $version"
	fi
}

execute_on_each_plugins install_plugin
execute_on_each_software install_software
