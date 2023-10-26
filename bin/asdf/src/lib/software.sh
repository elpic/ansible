declare -a plugin_and_versions=(
	"elixir,1.12.2"
	"elixir,1.14.3"
	"erlang,23.3"
	"ffmpeg,6.0"
	"fzf,0.32.0"
	"gcloud,422.0.0"
	"golang,1.19.1"
	"helm,3.11.2"
	"kustomize,4.5.7"
	"kustomize,5.0.0"
	"nodejs,16.16.0"
	"postgres,14.0"
	"python,2.7.18"
	"python,3.10.5"
	"python,3.9.16"
	"ruby,2.6.6"
	"ruby,2.7.6"
	"ruby,3.1.0"
	"rust,1.66.0"
	"skaffold,1.39.1"
	"skaffold,2.2.0"
	"terraform,1.3.7"
	"tmux,3.0"
	"yarn,1.22.17"
)

# This function receive a function that is going to be executed
# with every plugin in the list of plugins if a plugin was already
# in executed is not going to be executed twice
#
# $1 a function that is going to be executed for each plugin
execute_on_each_plugins() {
	declare -a unique_plugins=()

	for item in "${plugin_and_versions[@]}"; do
		plugin=$(echo "$item" | cut -d',' -f1)

		if [[ ! "${unique_plugins[*]}" =~ $plugin ]]; then
			unique_plugins+=("$plugin")
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
