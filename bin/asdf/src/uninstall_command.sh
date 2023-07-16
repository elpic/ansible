echo "Uninstall plugins and software"

function uninstall_plugin() {
	plugin=$1

	echo " Checking if plugin: $plugin is installed"

	if [[ $(asdf plugin list | grep -c "$plugin") -ne 1 ]]; then
		echo " Skip plugin installation: $plugin"
	else
		echo "  Uninstalling plugin: $plugin"
		asdf plugin remove "$plugin"
	fi
}

function uninstall_software() {
	plugin=$1
	version=$2

	echo " Checking if software: $plugin, $version is installed"

	if [[ $(asdf list "$plugin" | grep -c "$version") -ne 1 ]]; then
		echo " Skip software uninstall: $plugin, $version"
	else
		echo " Uninstalling software: $plugin, $version"
		asdf uninstall "$plugin" "$version"
	fi
}

execute_on_each_software uninstall_software
execute_on_each_plugins uninstall_plugin
