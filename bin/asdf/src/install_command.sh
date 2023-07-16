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
